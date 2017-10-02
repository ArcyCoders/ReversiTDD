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
@testable import ReversiCore

class ReversiSpec: QuickSpec
{
    fileprivate let iterationsCount: Int = 1000
    override func spec()
    {
        describe("init()")
        {
            //  abcdefgh
            // 1________
            // 2________
            // 3________
            // 4___o*___
            // 5___*o___
            // 6________
            // 7________
            // 8________
            it("should initialize the board")
            {
                let board = Reversi().board
                expect(board.blackFields.count) == 2
                expect(board.whiteFields.count) == 2
                expect(board.emptyFields.count) == Board.fieldsCount - 4
                expect(board.blackFields).to(contain([Field(._5, .d), Field(._4, .e)]))
                expect(board.whiteFields).to(contain([Field(._4, .d), Field(._5, .e)]))
            }

            it("should set the current player to black")
            {
                let reversi = Reversi()
                expect(reversi.currentPlayer).to(equal(Player.black))
            }
        }

        describe("canMove(player:)")
        {
            it("both players should be able to move if the the board is in initial state")
            {
                //  01234567
                // 0________
                // 1________
                // 2___?____
                // 3__?o*___
                // 4___*o?__
                // 5____?___
                // 6________
                // 7________
                let reversi = Reversi()
                expect(reversi.canMove(player: Player.black)).to(beTrue())
                expect(reversi.canMove(player: Player.white)).to(beTrue())
            }

            it("both players should not be able to move if board contains no black fields")
            {
                //  abcdefgh
                // 1_ooooo_o
                // 2____o___
                // 3o_oo_o__
                // 4_o_oo__o
                // 5ooo__oo_
                // 6ooo___o_
                // 7__o_o__o
                // 8ooo_o__o
                for _ in 0..<self.iterationsCount
                {
                    let customBoard = Board.random(allowBlackFields: false)
                    let reversi = Reversi(board: customBoard, player: Player.black)
                    expect(reversi.board.blackFields.count) == 0
                    expect(reversi.canMove(player: Player.black)).to(beFalse())
                    expect(reversi.canMove(player: Player.white)).to(beFalse())
                }
            }

            it("both players should not be able to move if board contains no white fields")
            {
                //  abcdefgh
                // 1*_**___*
                // 2*****_*_
                // 3_*_*_***
                // 4*_*****_
                // 5_******_
                // 6******_*
                // 7_*___**_
                // 8__***__*
                for _ in 0..<self.iterationsCount
                {
                    let customBoard = Board.random(allowWhiteFields: false)
                    let reversi = Reversi(board: customBoard, player: Player.black)
                    expect(reversi.board.whiteFields.count) == 0
                    expect(reversi.canMove(player: Player.black)).to(beFalse())
                    expect(reversi.canMove(player: Player.white)).to(beFalse())
                }
            }

            it("both players should not be able to move if board contains no empty fields")
            {
                //  abcdefgh
                // 1o*oo*o**
                // 2**oo*ooo
                // 3***o*oo*
                // 4*ooo*ooo
                // 5oooo*ooo
                // 6o*o*o***
                // 7**o**ooo
                // 8*ooo**oo
                for _ in 0..<self.iterationsCount
                {
                    let customBoard = Board.random(allowEmptyFields: false)
                    let reversi = Reversi(board: customBoard, player: Player.black)
                    expect(reversi.board.emptyFields.count) == 0
                    expect(reversi.canMove(player: Player.black)).to(beFalse())
                    expect(reversi.canMove(player: Player.white)).to(beFalse())
                }
            }
        }

        describe("getPlayerFields(:)")
        {
            it("should return black player's fields")
            {
                let customBoard = Board.random()
                let player = Player.black
                let reversi = Reversi(board: customBoard, player: player)
                expect(reversi.getPlayerFields(player)).to(equal(customBoard.blackFields))
            }

            it("should return white player's fields")
            {
                let customBoard = Board.random()
                let player = Player.white
                let reversi = Reversi(board: customBoard, player: player)
                expect(reversi.getPlayerFields(player)).to(equal(customBoard.whiteFields))
            }
        }

        describe("getOpponentFields(:)")
        {
            it("should return white player's fields")
            {
                let customBoard = Board.random()
                let player = Player.black
                let reversi = Reversi(board: customBoard, player: player)
                expect(reversi.getOpponentFields(player)).to(equal(customBoard.whiteFields))
            }

            it("should return black player's fields")
            {
                let customBoard = Board.random()
                let player = Player.white
                let reversi = Reversi(board: customBoard, player: player)
                expect(reversi.getOpponentFields(player)).to(equal(customBoard.blackFields))
            }
        }
    }
}
