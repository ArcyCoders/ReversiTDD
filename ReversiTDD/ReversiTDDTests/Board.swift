//
// Created by Krzysztof Moczała on 07/10/2017.
// Copyright (c) 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Board: Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    private var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)

    init(taken: [Move]) {
        taken.forEach { field in
            put(move: field)
        }
    }

    init(from string: String) {
        let lines = string.split(separator: "\n")
        let withoutLast = lines.dropLast().reversed()
        var taken: [Move] = []
        for i in (0..<8) {
            let line = lines[i]
            for j in (0..<8) {
                let character = line[line.index(line.startIndex, offsetBy: j+1)]
                if character == "w" {
                    taken.append(Move(x: Horizontal(rawValue: j)!, y: Vertical(rawValue: 7-i)!, takenBy: .White))
                } else if character == "b" {
                    taken.append(Move(x: Horizontal(rawValue: j)!, y: Vertical(rawValue: 7-i)!, takenBy: .Black))
                }
            }
        }
        self.init(taken: taken)
    }

    mutating func put(move: Move) {
        board[move.point.y.rawValue][move.point.x.rawValue] = move.takenBy
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
                    }
                    .joined(separator: " ")
            }
            .reversed()
            .joined(separator: "\n")
    }

    var debugDescription: String {
        return description
    }
}

