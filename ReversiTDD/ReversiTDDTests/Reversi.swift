//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

class Reversi {
    var currentPlayer: Player
    var board: Board

    init() {
        board = Board(taken: [
            Move(x: .d, y: ._4, takenBy: .Black),
            Move(x: .d, y: ._5, takenBy: .White),
            Move(x: .e, y: ._4, takenBy: .White),
            Move(x: .e, y: ._5, takenBy: .Black)
        ])
        currentPlayer = .Black
    }

    init(board: Board, currentPlayer: Player) {
        self.board = board
        self.currentPlayer = currentPlayer
    }

    func put(x: Horizontal, y: Vertical) {
        board.put(move: Move(x: x, y: y, takenBy: currentPlayer))
        board.put(move: Move(x: .d, y: ._5, takenBy: currentPlayer))
    }
}