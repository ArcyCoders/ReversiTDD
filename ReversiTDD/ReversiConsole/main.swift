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

        let move = consoleIO.getInput()

        guard let field = Field(ascii: move) else
        {
            consoleIO.writeError("Unknown move")
            continue
        }

        if let error = reversi.move(player: player, field: field)
        {
            consoleIO.writeError(error.rawValue)
            continue
        }

        print(reversi.board.output(showCoordinates: true))
    }

    player = player.next()
}

print("Game finished.")
