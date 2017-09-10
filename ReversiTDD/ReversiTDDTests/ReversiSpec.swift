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
    let taken: [Field]
    
    init(taken: [Field]) {
        self.taken = taken
    }
    
    static func == (lhs: Board, rhs: Board) -> Bool {
        return lhs.taken == rhs.taken
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
        board = Board(taken:[
            Field(x: .d, y: ._4, takenBy: .Black),
            Field(x: .d, y: ._5, takenBy: .Black),
            Field(x: .d, y: ._6, takenBy: .Black),
            Field(x: .e, y: ._4, takenBy: .White),
            Field(x: .e, y: ._5, takenBy: .Black)
        ])
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
            }
        }
        
    }
}
