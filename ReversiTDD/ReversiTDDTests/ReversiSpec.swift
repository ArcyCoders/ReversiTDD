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

enum Disk: Int {
    case White
    case Black
}

struct Field: Equatable {
    let x: Horizontal
    let y: Vertical
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
    var currentPlayer: Disk
    var board: Board
    
    init() {
        board = Board(taken: [
            Field(x: .d, y: ._4, disk: .Black),
            Field(x: .d, y: ._5, disk: .White),
            Field(x: .e, y: ._4, disk: .White),
            Field(x: .e, y: ._5, disk: .Black)
        ])
        currentPlayer = .Black
    }
}

class ReversiSpec: QuickSpec {
    override func spec() {
        
        describe("start") {
            
            it("has 4 disk in a starting possition") {
                let game = Reversi()
                
                expect(game.board).to(equal(Board(taken: [
                    Field(x: .d, y: ._4, disk: .Black),
                    Field(x: .d, y: ._5, disk: .White),
                    Field(x: .e, y: ._4, disk: .White),
                    Field(x: .e, y: ._5, disk: .Black)
                ])))
            }

            it("sets current player to Black") {
                let game = Reversi()

                expect(game.currentPlayer).to(equal(Disk.Black))
            }
            
        }
        
        describe("first move") {
            // HOMEWORK
        }
        
    }
}
