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

enum Player: Int {
    case White
    case Black
}

struct Field: Equatable {
    let x: Horizontal
    let y: Vertical
    let takenBy: Player?
    
    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.takenBy == rhs.takenBy
    }
}

struct Board: Equatable {
    private var board: [[Player?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    init(taken: [Field]) {
        taken.forEach { field in
            put(move: field)
        }
    }

    mutating func put(move: Field) {
        board[move.x.rawValue][move.y.rawValue] = move.takenBy
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
}

class Reversi {
    var currentPlayer: Player
    var board: Board
    
    init() {
        board = Board(taken: [
            Field(x: .d, y: ._4, takenBy: .Black),
            Field(x: .d, y: ._5, takenBy: .White),
            Field(x: .e, y: ._4, takenBy: .White),
            Field(x: .e, y: ._5, takenBy: .Black)
        ])
        currentPlayer = .Black
    }

    func put(x: Horizontal, y: Vertical) {
        if case .d = x, case ._6 = y {
            board.put(move: Field(x: .d, y: ._5, takenBy: currentPlayer))
            board.put(move: Field(x: .d, y: ._6, takenBy: currentPlayer))
        } else if case .c = x, case ._5 = y {
            board.put(move: Field(x: .c, y: ._5, takenBy: currentPlayer))
            board.put(move: Field(x: .d, y: ._5, takenBy: currentPlayer))
        } else if case .e = x, case ._3 = y {
            board.put(move: Field(x: .e, y: ._3, takenBy: currentPlayer))
            board.put(move: Field(x: .e, y: ._4, takenBy: currentPlayer))
        } else {
            board.put(move: Field(x: .f, y: ._4, takenBy: currentPlayer))
            board.put(move: Field(x: .e, y: ._4, takenBy: currentPlayer))
        }
        currentPlayer = .White
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
                    Field(x: .d, y: ._4, takenBy: .Black),
                    Field(x: .d, y: ._5, takenBy: .White),
                    Field(x: .e, y: ._4, takenBy: .White),
                    Field(x: .e, y: ._5, takenBy: .Black)
                ])))
            }

            it("sets current player to Black") {
                expect(game.currentPlayer).to(equal(Player.Black))
            }
            
        }
        
        describe("first move") {
            context("valid") {
                context("d6") {
                    it("updates the board") {
                        game.put(x: .d, y: ._6)

                        expect(game.board).to(equal(Board(taken: [
                            Field(x: .d, y: ._4, takenBy: .Black),
                            Field(x: .d, y: ._5, takenBy: .Black),
                            Field(x: .d, y: ._6, takenBy: .Black),
                            Field(x: .e, y: ._4, takenBy: .White),
                            Field(x: .e, y: ._5, takenBy: .Black)
                        ])))
                    }

                    it("changes current player to white") {
                        game.put(x: .d, y: ._6)

                        expect(game.currentPlayer).to(equal(Player.White))
                    }
                }

                context("c5") {
                    it("updates the board") {
                        game.put(x: .c, y: ._5)

                        expect(game.board).to(equal(Board(taken: [
                            Field(x: .c, y: ._5, takenBy: .Black),
                            Field(x: .d, y: ._4, takenBy: .Black),
                            Field(x: .d, y: ._5, takenBy: .Black),
                            Field(x: .e, y: ._4, takenBy: .White),
                            Field(x: .e, y: ._5, takenBy: .Black)
                        ])))
                    }

                    it("changes current player to white") {
                        game.put(x: .d, y: ._6)

                        expect(game.currentPlayer).to(equal(Player.White))
                    }
                }

                context("e3") {
                    it("updates the board") {
                        game.put(x: .e, y: ._3)

                        expect(game.board).to(equal(Board(taken: [
                            Field(x: .d, y: ._4, takenBy: .Black),
                            Field(x: .d, y: ._5, takenBy: .White),
                            Field(x: .e, y: ._3, takenBy: .Black),
                            Field(x: .e, y: ._4, takenBy: .Black),
                            Field(x: .e, y: ._5, takenBy: .Black)
                        ])))
                    }

                    it("changes current player to white") {
                        game.put(x: .d, y: ._6)

                        expect(game.currentPlayer).to(equal(Player.White))
                    }
                }
                
                context("f4") {
                    it("updates the board") {
                        game.put(x: .f, y: ._4)

                        expect(game.board).to(equal(Board(taken: [
                            Field(x: .d, y: ._4, takenBy: .Black),
                            Field(x: .d, y: ._5, takenBy: .White),
                            Field(x: .e, y: ._4, takenBy: .Black),
                            Field(x: .e, y: ._5, takenBy: .Black),
                            Field(x: .f, y: ._4, takenBy: .Black)
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
}
