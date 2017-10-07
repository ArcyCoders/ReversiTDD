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

                describe("c4 - White") {
                    beforeEach {
                        game.put(x: .c, y: ._4)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .c, y: ._4, takenBy: .White),
                            Move(x: .d, y: ._4, takenBy: .White),
                            Move(x: .d, y: ._5, takenBy: .Black),
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

                describe("c6 - White") {
                    beforeEach {
                        game.put(x: .c, y: ._6)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .c, y: ._5, takenBy: .Black),
                            Move(x: .c, y: ._6, takenBy: .White),
                            Move(x: .d, y: ._4, takenBy: .Black),
                            Move(x: .d, y: ._5, takenBy: .White),
                            Move(x: .e, y: ._4, takenBy: .White),
                            Move(x: .e, y: ._5, takenBy: .Black),
                        ])))
                    }

                    it("sets the current player to black") {
                        expect(game.currentPlayer).to(equal(Player.Black))
                    }
                }

                describe("c4 - White") {
                    beforeEach {
                        game.put(x: .c, y: ._4)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .c, y: ._4, takenBy: .White),
                            Move(x: .c, y: ._5, takenBy: .Black),
                            Move(x: .d, y: ._4, takenBy: .White),
                            Move(x: .d, y: ._5, takenBy: .Black),
                            Move(x: .e, y: ._4, takenBy: .White),
                            Move(x: .e, y: ._5, takenBy: .Black),
                        ])))
                    }

                    it("sets the current player to black") {
                        expect(game.currentPlayer).to(equal(Player.Black))
                    }
                }
            }

            describe("e3 - Black") {
                beforeEach {
                    game.put(x: .e, y: ._3)
                }

                it("updates the board") {
                    expect(game.board).to(equal(Board(taken: [
                        Move(x: .d, y: ._4, takenBy: .Black),
                        Move(x: .d, y: ._5, takenBy: .White),
                        Move(x: .e, y: ._3, takenBy: .Black),
                        Move(x: .e, y: ._4, takenBy: .Black),
                        Move(x: .e, y: ._5, takenBy: .Black)
                    ])))
                }

                it("changes current player to white") {
                    expect(game.currentPlayer).to(equal(Player.White))
                }

                describe("f3 - White") {
                    beforeEach {
                        game.put(x: .f, y: ._3)
                    }

                    it("updates the board") {
                        expect(game.board).to(equal(Board(taken: [
                            Move(x: .d, y: ._4, takenBy: .Black),
                            Move(x: .d, y: ._5, takenBy: .White),
                            Move(x: .e, y: ._3, takenBy: .Black),
                            Move(x: .e, y: ._4, takenBy: .White),
                            Move(x: .e, y: ._5, takenBy: .Black),
                            Move(x: .f, y: ._3, takenBy: .White),
                        ])))
                    }

                    it("changes current player to white") {
                        expect(game.currentPlayer).to(equal(Player.Black))
                    }
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
