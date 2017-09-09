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

enum Disk: Int {
    case White
    case Black
}

struct Field: Equatable {
    let x: Int
    let y: Int
    let disk: Disk?
    
    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.disk == rhs.disk
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

func == (tuple1:(Int, Int, Disk),tuple2:(Int, Int, Disk)) -> Bool
{
    return (tuple1.0 == tuple2.0) && (tuple1.1 == tuple2.1) && (tuple1.2 == tuple2.2)
}

class Reversi {
    var board: Board

    func move(_ field: Field) {
        let fields = board.taken + [field]
        board = Board(taken: fields)
    }

    init() {
        board = Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
    }
}

class ReversiSpec: QuickSpec {
    override func spec() {

        //  01234567
        // 0________
        // 1________
        // 2________
        // 3___o*___
        // 4___*o___
        // 5________
        // 6________
        // 7________
        describe("start") {

            it("has 4 disks in a starting position") {
                let game = Reversi()
                
                expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])))
            }
            
        }

        //  01234567
        // 0________
        // 1________
        // 2___?____
        // 3__?o*___
        // 4___*o?__
        // 5____?___
        // 6________
        // 7________
        describe("the dark player moves first") {

            var game: Reversi!

            beforeEach {
                game = Reversi()
            }

            context("has 4 possible moves") {

                it("move [2,3] is possible") {
                    let field = Field(x: 2, y: 3, disk: .Black)
                    game.move(field)
                    expect(game.board.taken.contains(field)).to(beTrue())
                }

                it("move [3,2] is possible") {
                    let field = Field(x: 3, y: 2, disk: .Black)
                    game.move(field)
                    expect(game.board.taken.contains(field)).to(beTrue())
                }

                it("move [4,5] is possible") {
                    let field = Field(x: 4, y: 5, disk: .Black)
                    game.move(field)
                    expect(game.board.taken.contains(field)).to(beTrue())
                }

                it("move [5,4] is possible") {
                    let field = Field(x: 5, y: 4, disk: .Black)
                    game.move(field)
                    expect(game.board.taken.contains(field)).to(beTrue())
                }
            }

            context("none of the 4 possible fields is occupied") {

                it("by a white disk") {
                    expect(game.board.taken.contains(Field(x: 2, y: 3, disk: .White))).to(beFalse())
                    expect(game.board.taken.contains(Field(x: 3, y: 2, disk: .White))).to(beFalse())
                    expect(game.board.taken.contains(Field(x: 4, y: 5, disk: .White))).to(beFalse())
                    expect(game.board.taken.contains(Field(x: 5, y: 4, disk: .White))).to(beFalse())
                }

                it("by a black disk") {
                    expect(game.board.taken.contains(Field(x: 2, y: 3, disk: .Black))).to(beFalse())
                    expect(game.board.taken.contains(Field(x: 3, y: 2, disk: .Black))).to(beFalse())
                    expect(game.board.taken.contains(Field(x: 4, y: 5, disk: .Black))).to(beFalse())
                    expect(game.board.taken.contains(Field(x: 5, y: 4, disk: .Black))).to(beFalse())
                }
            }
        }

    }
}
