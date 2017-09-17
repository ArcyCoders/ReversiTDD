//
//  ReversiSpec.swift
//  ReversiTDD
//
//  Created by Krzysztof Moczała on 03/09/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble

enum Vertical: Int {
    case _1, _2, _3, _4, _5, _6, _7, _8
}

enum Horizontal: Int {
    case a, b, c, d, e, f, g, h
}

enum Player: Int, CustomStringConvertible {
    case White
    case Black

    func other() -> Player {
        if case .White = self {
            return .Black
        } else {
            return .White
        }
    }

    var description: String {
        switch self {
        case .White:
            return "White"
        case .Black:
            return "Black"
        }
    }
}

struct Point: Equatable {
    let x: Horizontal
    let y: Vertical

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct Move: Equatable {
    let point: Point
    let takenBy: Player?

    init(x: Horizontal, y: Vertical, takenBy: Player) {
        self.point = Point(x: x, y: y)
        self.takenBy = takenBy
    }
    
    static func == (lhs: Move, rhs: Move) -> Bool {
        return lhs.point == rhs.point && lhs.takenBy == rhs.takenBy
    }
}

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
        }
        currentPlayer = currentPlayer.other()
    }
}

class ReversiSpec: QuickSpec {
    override func spec() {

        var game: Reversi!

        beforeEach {
            game = Reversi()
        }
        
        describe("start") {
            
            it("has 4 disk in a starting possition") {
                expect(game.board).to(equal(Board(taken: [
                    Move(x: .d, y: ._4, takenBy: .Black),
                    Move(x: .d, y: ._5, takenBy: .White),
                    Move(x: .e, y: ._4, takenBy: .White),
                    Move(x: .e, y: ._5, takenBy: .Black)
                ])))
            }

            it("sets current player to Black") {
                expect(game.currentPlayer).to(equal(Player.Black))
            }
            
        }

        describe("valid moves") {
            describe("d6 - Black") {

                beforeEach {
                    game.put(x: .d, y: ._6)
                }

                it("updates the board") {
                    expect(game.board).to(equal(Board(taken: [
                        Move(x: .d, y: ._4, takenBy: .Black),
                        Move(x: .d, y: ._5, takenBy: .Black),
                        Move(x: .d, y: ._6, takenBy: .Black),
                        Move(x: .e, y: ._4, takenBy: .White),
                        Move(x: .e, y: ._5, takenBy: .Black)
                    ])))
                }

                it("changes current player to white") {
                    expect(game.currentPlayer).to(equal(Player.White))
                }

                describe("e6 - White") {
                    beforeEach {
                        game.put(x: .e, y: ._6)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .d, y: ._4, takenBy: .Black),
                            Move(x: .d, y: ._5, takenBy: .Black),
                            Move(x: .d, y: ._6, takenBy: .Black),
                            Move(x: .e, y: ._4, takenBy: .White),
                            Move(x: .e, y: ._5, takenBy: .White),
                            Move(x: .e, y: ._6, takenBy: .White)
                        ])))
                    }

                    it("sets the current player to black") {
                        expect(game.currentPlayer).to(equal(Player.Black))
                    }
                }

                describe("c6 - White") {
                    beforeEach {
                        game.put(x: .c, y: ._6)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .c, y: ._6, takenBy: .White),
                            Move(x: .d, y: ._4, takenBy: .Black),
                            Move(x: .d, y: ._5, takenBy: .White),
                            Move(x: .d, y: ._6, takenBy: .Black),
                            Move(x: .e, y: ._4, takenBy: .White),
                            Move(x: .e, y: ._5, takenBy: .Black),
                        ])))
                    }

                    it("sets the current player to black") {
                        expect(game.currentPlayer).to(equal(Player.Black))
                    }
                }
            }

            describe("c5 - Black") {

                beforeEach {
                    game.put(x: .c, y: ._5)
                }

                it("updates the board") {
                    expect(game.board).to(equal(Board(taken: [
                        Move(x: .c, y: ._5, takenBy: .Black),
                        Move(x: .d, y: ._4, takenBy: .Black),
                        Move(x: .d, y: ._5, takenBy: .Black),
                        Move(x: .e, y: ._4, takenBy: .White),
                        Move(x: .e, y: ._5, takenBy: .Black)
                    ])))
                }

                it("changes current player to white") {
                    expect(game.currentPlayer).to(equal(Player.White))
                }

                describe("e6 - White") {
                    beforeEach {
                        game.put(x: .e, y: ._6)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .c, y: ._5, takenBy: .Black),
                            Move(x: .d, y: ._4, takenBy: .Black),
                            Move(x: .d, y: ._5, takenBy: .Black),
                            Move(x: .e, y: ._4, takenBy: .White),
                            Move(x: .e, y: ._5, takenBy: .White),
                            Move(x: .e, y: ._6, takenBy: .White)
                        ])))
                    }

                    it("sets the current player to black") {
                        expect(game.currentPlayer).to(equal(Player.Black))
                    }
                }
            }

            describe("e3 - Black") {
                it("updates the board") {
                    game.put(x: .e, y: ._3)

                    expect(game.board).to(equal(Board(taken: [
                        Move(x: .d, y: ._4, takenBy: .Black),
                        Move(x: .d, y: ._5, takenBy: .White),
                        Move(x: .e, y: ._3, takenBy: .Black),
                        Move(x: .e, y: ._4, takenBy: .Black),
                        Move(x: .e, y: ._5, takenBy: .Black)
                    ])))
                }

                it("changes current player to white") {
                    game.put(x: .d, y: ._6)

                    expect(game.currentPlayer).to(equal(Player.White))
                }
            }

            describe("f4 - Black") {
                it("updates the board") {
                    game.put(x: .f, y: ._4)

                    expect(game.board).to(equal(Board(taken: [
                        Move(x: .d, y: ._4, takenBy: .Black),
                        Move(x: .d, y: ._5, takenBy: .White),
                        Move(x: .e, y: ._4, takenBy: .Black),
                        Move(x: .e, y: ._5, takenBy: .Black),
                        Move(x: .f, y: ._4, takenBy: .Black)
                    ])))
                }

                it("changes current player to white") {
                    game.put(x: .d, y: ._6)

                    expect(game.currentPlayer).to(equal(Player.White))
                }
            }
        }
    }
}
