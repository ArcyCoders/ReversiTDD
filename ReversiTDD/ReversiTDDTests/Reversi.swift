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

    func put(x: Horizontal, y: Vertical) {
        board.put(move: Move(x: x, y: y, takenBy: currentPlayer))
        if case .d = x, case ._6 = y {
            board.put(move: Move(x: .d, y: ._5, takenBy: currentPlayer))
        } else if case .c = x, case ._5 = y {
            board.put(move: Move(x: .d, y: ._5, takenBy: currentPlayer))
        } else if case .e = x, case ._3 = y {
            board.put(move: Move(x: .e, y: ._4, takenBy: currentPlayer))
        } else if case .f = x, case ._4 = y {
            board.put(move: Move(x: .e, y: ._4, takenBy: currentPlayer))
        } else if case .e = x, case ._6 = y {
            board.put(move: Move(x: .e, y: ._5, takenBy: currentPlayer))
        } else if case .c = x, case ._6 = y {
            board.put(move: Move(x: .d, y: ._5, takenBy: currentPlayer))
        } else if case .f = x, case ._3 = y {
            board.put(move: Move(x: .e, y: ._4, takenBy: currentPlayer))
        } else if case .c = x, case ._4 = y {
            board.put(move: Move(x: .d, y: ._4, takenBy: currentPlayer))
        }
        currentPlayer = currentPlayer.other()
    }
}
