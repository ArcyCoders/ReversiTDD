//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Board: Equatable, CustomStringConvertible {
    private var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)

    init(taken: [Move]) {
        taken.forEach { field in
            put(move: field)
        }
    }

    mutating func put(move: Move) {
        board[move.point.x.rawValue][move.point.y.rawValue] = move.takenBy
    }

    static func == (lhs: Board, rhs: Board) -> Bool {
        for i in 0..<8 {
            for j in 0..<8 {
                if lhs.board[i][j] != rhs.board[i][j] {
                    return false
                }
            }
        }
        return true
    }

    var description: String {
        return board.map { subarray in
            return subarray.map { value in
                if let value = value {
                    return value.description
                } else {
                    return "Empty"
                }
            }.joined(separator: " ")
        }.joined(separator: "\n")
    }
}

