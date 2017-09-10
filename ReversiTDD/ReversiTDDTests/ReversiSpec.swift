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
    var taken: [Field]
    
    init(taken: [Field]) {
        self.taken = taken
    }
    
    mutating func add(field: Field) {
        taken.append(field)
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
    
    init() {
        board = Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])
    }
    
    func move(field: Field) {
        board.add(field: field)
    }
}

class ReversiSpec: QuickSpec {
    override func spec() {
        
        describe("start") {
            
            it("has 4 disk in a starting possition") {
                let game = Reversi()
                
                expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White), Field(x: 3, y: 4, disk: .Black), Field(x: 4, y: 3, disk: .Black), Field(x: 4, y: 4, disk: .White)])))
            }
            
        }
        
        describe("first move") {
            
            it("should add disk to game board at specified position") {
                let game = Reversi()
                game.move(field: Field(x: 5, y: 4, disk: .Black))
                
                expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White),
                                                          Field(x: 3, y: 4, disk: .Black),
                                                          Field(x: 4, y: 3, disk: .Black),
                                                          Field(x: 4, y: 4, disk: .White),
                                                          Field(x: 5, y: 4, disk: .Black),])))
            }
            // HOMEWORK
        }
        
    }
}
