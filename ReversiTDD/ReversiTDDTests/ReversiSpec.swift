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
@testable import ReversiTDD

class ReversiSpec: QuickSpec {
    override func spec() {
        
        describe("start") {
            
            it("has 4 disk in a starting possition") {
                let game = Reversi()
                
                expect(game.board).to(equal(Board(taken:
                    [ Field(x: 3, y: 3, disk: .White),
                      Field(x: 3, y: 4, disk: .Black),
                      Field(x: 4, y: 3, disk: .Black),
                      Field(x: 4, y: 4, disk: .White)] )))
            }
            
        }
        
        describe("first move") {
            
            context("valid move")
            {
                it("should add disk to game board at specified position") {
                    let game = Reversi()
                    
                    let fieldToAdd =  Field(x: 5, y: 4, disk: .Black)
                    expect { try game.move(field: fieldToAdd) }.notTo(throwError())
                    expect(game.board.fieldAt(x: 5, y: 4)).to(equal(fieldToAdd))
                }
                
                it("should rotate disks after valid move [2,3]")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 2, y: 3, disk: .Black)) }.notTo(throwError())
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .Black),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .White),
                                                              
                                                              Field(x: 2, y: 3, disk: .Black)])))
                }
                
                it("should rotate disks after valid move [3,2]")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 3, y: 2, disk: .Black)) }.notTo(throwError())
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .Black),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .White),
                                                              
                                                              Field(x: 3, y: 2, disk: .Black)])))
                }
                
                it("should rotate disks after valid move [5,4]")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 5, y: 4, disk: .Black)) }.notTo(throwError())
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .Black),
                                                              
                                                              Field(x: 5, y: 4, disk: .Black)])))
                }
                
                it("should rotate disks after valid move [4,5]")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 4, y: 5, disk: .Black)) }.notTo(throwError())
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .Black),
                                                              
                                                              Field(x: 4, y: 5, disk: .Black)])))
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
                
                it("should throw an error when attempt to add disk at position with no adjacent disks")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 1, y: 1, disk: .Black))}
                        .to(throwError(ReversiError.noAdjacentDisks))
                }
                
                it("should throw an error when attempt to add disk at position without possibility to turn other disks")
                {
                    let game = Reversi()
                    expect { try game.move(field: Field(x: 2, y: 4, disk: .Black))}
                        .to(throwError(ReversiError.noDisksToTurn))
                    expect { try game.move(field: Field(x: 2, y: 5, disk: .Black))}
                        .to(throwError(ReversiError.noDisksToTurn))
                    expect { try game.move(field: Field(x: 3, y: 5, disk: .Black))}
                        .to(throwError(ReversiError.noDisksToTurn))
                    
                    expect { try game.move(field: Field(x: 4, y: 2, disk: .Black))}
                        .to(throwError(ReversiError.noDisksToTurn))
                    expect { try game.move(field: Field(x: 5, y: 2, disk: .Black))}
                        .to(throwError(ReversiError.noDisksToTurn))
                    expect { try game.move(field: Field(x: 5, y: 3, disk: .Black))}
                        .to(throwError(ReversiError.noDisksToTurn))
                }
            }
        }
        
        describe("second move after placing black on [3,2] ")
        {
            var game: Reversi!
            beforeEach {
                game = Reversi()
                expect{ try game.move(field: Field(x: 3, y: 2, disk: .Black)) }.notTo(throwError())
            }
            
            it("should throw an error when attempt to add black disk")
            {
                expect { try game.move(field: Field(x: 2, y: 2, disk: .Black)) }
                    .to(throwError(ReversiError.incorrectDiskColor))
            }
            
            context("white move on [2,2]")
            {
                beforeEach {
                    expect{ try game.move(field: Field(x: 2, y: 2, disk: .White))}.notTo(throwError())
                }
                
                it("should add white disk at [2,2] on board") {
                    expect(game.board.fieldAt(x: 2, y: 2)).to(equal(Field(x: 2, y: 2, disk: .White)))
                }
                
                it("should rotate disks to white") {
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .White),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .White),
                                                              
                                                              Field(x: 3, y: 2, disk: .Black),
                                                              Field(x: 2, y: 2, disk: .White)])))
                }
            }
            
            context("white move on [2,4]")
            {
                beforeEach {
                    expect{ try game.move(field: Field(x: 2, y: 4, disk: .White))}.notTo(throwError())
                }
                
                it("should add white disk at [2,4] on board") {
                    expect(game.board.fieldAt(x: 2, y: 4)).to(equal(Field(x: 2, y: 4, disk: .White)))
                }
                
                it("should rotate disks to white") {
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .Black),
                                                              Field(x: 3, y: 4, disk: .White),
                                                              Field(x: 4, y: 3, disk: .Black),
                                                              Field(x: 4, y: 4, disk: .White),
                                                              
                                                              Field(x: 3, y: 2, disk: .Black),
                                                              Field(x: 2, y: 4, disk: .White)])))
                }
            }
            
            context("white move on [4,2]")
            {
                beforeEach {
                    expect{ try game.move(field: Field(x: 4, y: 2, disk: .White))}.notTo(throwError())
                }
                
                it("should add white disk at [4,2] on board") {
                    expect(game.board.fieldAt(x: 4, y: 2)).to(equal(Field(x: 4, y: 2, disk: .White)))
                }
                
                it("should rotate disks to white") {
                    expect(game.board).to(equal(Board(taken: [Field(x: 3, y: 3, disk: .Black),
                                                              Field(x: 3, y: 4, disk: .Black),
                                                              Field(x: 4, y: 3, disk: .White),
                                                              Field(x: 4, y: 4, disk: .White),
                                                              
                                                              Field(x: 3, y: 2, disk: .Black),
                                                              Field(x: 4, y: 2, disk: .White)])))
                }
            }
        }
    }
}
