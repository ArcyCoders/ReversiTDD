//
//  ReversiViewController.swift
//  ReversiWindow
//
//  Created by Pawel Leszkiewicz on 08.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Cocoa
import ReversiCore

class ReversiViewController: NSViewController
{
    @IBOutlet fileprivate weak var boardView: BoardView!

    fileprivate let reversi = Reversi()
    fileprivate var player: Player!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        player = reversi.currentPlayer
        boardView.delegate = self
        updateBoardView()
    }

    override func viewDidLayout()
    {
        super.viewDidLayout()
        boardView.frame = view.bounds
    }

    fileprivate func updateBoardView()
    {
        boardView.board = reversi.board

        if !reversi.canMove(player: player)
        {
            player = player.next()
        }

        if reversi.canMove(player: player)
        {
            let color = (player == .black) ? NSColor.black.withAlphaComponent(0.2) : NSColor.white.withAlphaComponent(0.6)
            let possibleMoves = Array(reversi.possibleMoves(for: player))
            boardView.showPossibleMoves(possibleMoves, color: color)
        }
        else
        {
            let blackCount = reversi.board.blackFields.count
            let whiteCount = reversi.board.whiteFields.count
            let score = (blackCount > whiteCount) ? "Black won!" : ((blackCount < whiteCount) ? "White won!" : "Draw!")
            let alert = NSAlert()
            alert.addButton(withTitle: "OK")
            alert.messageText = "Game Over\n\n" + score
            alert.alertStyle = .informational
            alert.runModal()
        }
    }
}

extension ReversiViewController: BoardViewDelegate
{
    internal func boardView(sender: BoardView, didClickAt field: Field)
    {
        reversi.move(player: player, field: field)
        player = player.next()
        updateBoardView()
    }
}
