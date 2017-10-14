//
//  ReversiSpec.swift
//  ReversiTDD
//
//  Based on:
//  1. https://en.wikipedia.org/wiki/Reversi
//  2. http://www.hannu.se/games/othello/rules.htm
//
//  Created by Krzysztof Moczała on 03/09/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ReversiTDD

// TODO: - handle move error
class ReversiSpec: QuickSpec {
    override func spec() {
        var board: Board!
        var game: Reversi!

        beforeEach {
            board = Board()
            game = Reversi(withBoard: board)
            game.start()
        }

        describe("start") {
            it("has 4 disks in a starting position") {
                expect(board).to(equal(Board(taken: [Field(column: .d, row: ._4, disk: Disk(currentColor: .white)),
                                                     Field(column: .d, row: ._5, disk: Disk(currentColor: .black)),
                                                     Field(column: .e, row: ._4, disk: Disk(currentColor: .black)),
                                                     Field(column: .e, row: ._5, disk: Disk(currentColor: .white))])))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("black player makes first move to D3") {
            beforeEach {
                game.move(to: Field(column: .d, row: ._3, disk: Disk(currentColor: .black)))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position D3") {
                expect(board.getField(column: .d, row: ._3)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("has black disk on position D4") {
                expect(board.getField(column: .d, row: ._4)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("switches currentPlayer to white") {
                expect(game.currentPlayer).to(equal(Disk.Color.white))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("black player makes first move to E6") {
            beforeEach {
                game.move(to: Field(column: .e, row: ._6, disk: Disk(currentColor: .black)))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position E6") {
                expect(board.getField(column: .e, row: ._6)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("has black disk on position E5") {
                expect(board.getField(column: .e, row: ._5)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("switches currentPlayer to white") {
                expect(game.currentPlayer).to(equal(Disk.Color.white))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("black player makes first move to F5") {
            beforeEach {
                game.move(to: Field(column: .f, row: ._5, disk: Disk(currentColor: .black)))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position F5") {
                expect(board.getField(column: .f, row: ._5)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("has black disk on position E5") {
                expect(board.getField(column: .e, row: ._5)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("switches currentPlayer to white") {
                expect(game.currentPlayer).to(equal(Disk.Color.white))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("black player makes first move to C4") {
            beforeEach {
                game.move(to: Field(column: .c, row: ._4, disk: Disk(currentColor: .black)))
            }

            it("has 5 disks on board") {
                expect(board.takenFieldsCount).to(equal(5))
            }

            it("has black disk on position C4") {
                expect(board.getField(column: .c, row: ._4)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("has black disk on position D4") {
                expect(board.getField(column: .d, row: ._4)?.disk).to(equal(Disk(currentColor: .black)))
            }

            it("switches currentPlayer to white") {
                expect(game.currentPlayer).to(equal(Disk.Color.white))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("white player makes second move down, right flanking") {
            beforeEach {
                game.move(to: Field(column: .e, row: ._6, disk: Disk(currentColor: .black)))
                game.move(to: Field(column: .f, row: ._6, disk: Disk(currentColor: .white)))
            }

            it("has 6 disks on board") {
                expect(board.takenFieldsCount).to(equal(6))
            }

            it("has white disk on position F6") {
                expect(board.getField(column: .f, row: ._6)?.disk).to(equal(Disk(currentColor: .white)))
            }

            it("has white disk on position E5") {
                expect(board.getField(column: .e, row: ._5)?.disk).to(equal(Disk(currentColor: .white)))
            }

            it("switches currentPlayer to black") {
                expect(game.currentPlayer).to(equal(Disk.Color.black))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("white player makes second move down, right flanking") {
            beforeEach {
                game.move(to: Field(column: .e, row: ._6, disk: Disk(currentColor: .black)))
                game.move(to: Field(column: .f, row: ._6, disk: Disk(currentColor: .white)))
            }

            it("has 6 disks on board") {
                expect(board.takenFieldsCount).to(equal(6))
            }

            it("has white disk on position F6") {
                expect(board.getField(column: .f, row: ._6)?.disk).to(equal(Disk(currentColor: .white)))
            }

            it("has white disk on position E5") {
                expect(board.getField(column: .e, row: ._5)?.disk).to(equal(Disk(currentColor: .white)))
            }

            it("switches currentPlayer to black") {
                expect(game.currentPlayer).to(equal(Disk.Color.black))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("white player makes second move up, left flanking") {
            beforeEach {
                game.move(to: Field(column: .d, row: ._3, disk: Disk(currentColor: .black)))
                game.move(to: Field(column: .c, row: ._3, disk: Disk(currentColor: .white)))
            }

            it("has 6 disks on board") {
                expect(board.takenFieldsCount).to(equal(6))
            }

            it("has white disk on position C3") {
                expect(board.getField(column: .c, row: ._3)?.disk).to(equal(Disk(currentColor: .white)))
            }

            it("has white disk on position D4") {
                expect(board.getField(column: .d, row: ._4)?.disk).to(equal(Disk(currentColor: .white)))
            }

            it("switches currentPlayer to black") {
                expect(game.currentPlayer).to(equal(Disk.Color.black))
            }

            it("doesn't report that game is finished") {
                expect(game.isFinished).to(beFalse())
            }
        }

        describe("getting valid moves for black player when the game starts") {
            var validMoves: [Field] = []

            beforeEach {
                validMoves = game.getValidMoves(forPlayer: game.currentPlayer)
            }

            it("returns 4 valid moves") {
                expect(validMoves.count).to(equal(4))
                expect(validMoves).to(contain(Field(column: .d, row: ._3, disk: nil)))
                expect(validMoves).to(contain(Field(column: .c, row: ._4, disk: nil)))
                expect(validMoves).to(contain(Field(column: .e, row: ._6, disk: nil)))
                expect(validMoves).to(contain(Field(column: .f, row: ._5, disk: nil)))
            }
        }

        describe("getting valid moves for white player after black player's first move") {
            var validMoves: [Field] = []

            beforeEach {
                game.move(to: Field(column: .d, row: ._3, disk: nil))
                validMoves = game.getValidMoves(forPlayer: game.currentPlayer)
            }

            it("returns 3 valid moves") {
                expect(validMoves.count).to(equal(3))
                expect(validMoves).to(contain(Field(column: .c, row: ._3, disk: nil)))
                expect(validMoves).to(contain(Field(column: .c, row: ._5, disk: nil)))
                expect(validMoves).to(contain(Field(column: .e, row: ._3, disk: nil)))
            }
        }

        describe("when after black player's turn white player doesn't have a valid move") {
            beforeEach {
                let board = BoardStringLoader().load("-WBW----",
                                                     "B-------",
                                                     "B-------",
                                                     "B-------",
                                                     "B-------",
                                                     "B-------",
                                                     "B-------",
                                                     "W-------")

                game.load(currentPlayer: .black, board: board)
                game.move(to: Field(column: .a, row: ._1, disk: nil))
            }

            it("forfeits white player's turn") {
                expect(game.currentPlayer).to(equal(Disk.Color.black))
            }
        }

        describe("when after white player's turn black player doesn't have a valid move") {
            beforeEach {
                let board = BoardStringLoader().load("-WWWWWWB",
                                                     "B-------",
                                                     "W-------",
                                                     "B-------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------")

                game.load(currentPlayer: .white, board: board)
                game.move(to: Field(column: .a, row: ._1, disk: nil))
            }

            it("forfeits black player's turn") {
                expect(game.currentPlayer).to(equal(Disk.Color.white))
            }
        }

        describe("when no player has a valid move but the board is not empty") {
            beforeEach {
                let board = BoardStringLoader().load("-WWWWWWB",
                                                     "B-------",
                                                     "W-------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------",
                                                     "--------")

                game.load(currentPlayer: .white, board: board)
                game.move(to: Field(column: .a, row: ._1, disk: nil))
            }

            it("reports that the game is finished") {
                expect(game.isFinished).to(beTrue())
            }
        }

        describe("when the board is full") {
            beforeEach {
                let board = BoardStringLoader().load("-WBBBBBW",
                                                     "BBBBBBBB",
                                                     "BBBBBBBB",
                                                     "BBBBBBBB",
                                                     "BBBBBBBB",
                                                     "BBBBBBBB",
                                                     "BBBBBBBB",
                                                     "BBBBBBBB")

                game.load(currentPlayer: .black, board: board)
                game.move(to: Field(column: .a, row: ._1, disk: nil))
            }

            it("reports that the game is finished") {
                expect(game.isFinished).to(beTrue())
            }
        }
    }
}
