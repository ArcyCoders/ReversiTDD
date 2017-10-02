//
//  main.swift
//  ReversiConsole
//
//  Created by Pawel Leszkiewicz on 02.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import ReversiCore

let consoleIO = ConsoleIO()
let reversi = Reversi()
var player = reversi.currentPlayer

consoleIO.writeMessage("Welcome to Reversi!")
consoleIO.writeMessage(reversi.board.output(showCoordinates: true))

while reversi.isRunning
{
    if reversi.canMove(player: player)
    {
        let playerColor = (player == .white) ? "White" : "Black"
        consoleIO.writeMessage("\(playerColor) moves: ")

        // Manual move
//        let move = consoleIO.getInput()
//        guard let field = Field(ascii: move) else
//        {
//            consoleIO.writeError("Unknown move")
//            continue
//        }

        // Automatic move
        let possibleFields: [Field] = Array(reversi.possibleMoves(for: player))
        let index = Int(arc4random_uniform(UInt32(possibleFields.count)))
        let field = possibleFields[index]

        if let error = reversi.move(player: player, field: field)
        {
            consoleIO.writeError(error.rawValue)
            continue
        }

        print(reversi.board.output(showCoordinates: true))
    }

    player = player.next()
}

consoleIO.writeMessage("Game finished:")
consoleIO.writeMessage("black: \(reversi.board.blackFields.count)")
consoleIO.writeMessage("white: \(reversi.board.whiteFields.count)")
consoleIO.writeMessage("\n")

