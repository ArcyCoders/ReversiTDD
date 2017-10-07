//
//  Reversi_Init_Spec.swift
//  ReversiTDD
//
//  Created by Krzysztof Moczała on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Quick
import Nimble

class Reversi_Init_Spec: QuickSpec {
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
    }
}
