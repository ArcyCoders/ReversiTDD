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
    }
}
