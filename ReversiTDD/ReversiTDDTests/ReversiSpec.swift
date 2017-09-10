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

enum ReversiError: Error
{
    case positionTaken
    case incorrectDiskColor
}

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
    
    mutating func add(field: Field) throws {
        guard taken.filter({ $0.x == field.x && $0.y == field.y }).isEmpty
        else { throw ReversiError.positionTaken }
        
        let blackDiskCount = taken.filter({ $0.disk == Disk.Black }).count
        let whiteDikCount = taken.filter({ $0.disk == Disk.White }).count
        guard ((blackDiskCount == whiteDikCount) && field.disk == Disk.Black) ||
              ((blackDiskCount > whiteDikCount) && field.disk == Disk.White)
        else { throw ReversiError.incorrectDiskColor }
        
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
    
    func move(field: Field) throws {
        do {
            try board.add(field: field)
        }
        catch let err
        {
            throw err
        }
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
            
            context("valid move")
            {
                it("should add disk to game board at specified position") {
                    let game = Reversi()
                    try! game.move(field: Field(x: 5, y: 4, disk: .Black))
                    
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .White),
                                                              Field(x: 5, y: 4, disk: .Black),])))
                }
            }
            context("invalid move")
            {
                it("should throw error when attempt to add disk at taken position")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 4, y: 4, disk: .Black))}
                        .to(throwError(ReversiError.positionTaken))
                }
                
                it("should throw error when attempt to add white disk")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 5, y: 4, disk: .White))}
                        .to(throwError(ReversiError.incorrectDiskColor))
                }
            }
        }
        
    }
}
