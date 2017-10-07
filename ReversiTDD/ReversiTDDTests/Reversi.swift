//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

class Reversi {
    var currentPlayer: Player
    var board: Board
    private let shifts: [Shift] = [.right, .left]

    init() {
        board = Board(taken: [
            Move(point: Point(x: .d, y: ._4), takenBy: .Black),
            Move(point: Point(x: .d, y: ._5), takenBy: .White),
            Move(point: Point(x: .e, y: ._4), takenBy: .White),
            Move(point: Point(x: .e, y: ._5), takenBy: .Black)
        ])
        currentPlayer = .Black
    }

    init(board: Board, currentPlayer: Player) {
        self.board = board
        self.currentPlayer = currentPlayer
    }

    func put(on point: Point) {
        board.put(move: Move(point: point, takenBy: currentPlayer))
        shifts.forEach { shift in
            let shifted = point.shifted(to: shift)
            if let shifted = shifted, board.disk(on: shifted) == currentPlayer.other() {
                board.put(move: Move(point: shifted, takenBy: currentPlayer))
            }
        }
    }

}
