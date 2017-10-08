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

    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.layer?.backgroundColor = NSColor.red.cgColor
        boardView.board = reversi.board
    }

    override func viewDidLayout()
    {
        super.viewDidLayout()
        boardView.frame = view.bounds
    }
}
