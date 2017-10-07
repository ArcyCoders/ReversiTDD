//
//  Board_InitFromString_Spec.swift
//  ReversiTDD
//
//  Created by Krzysztof Moczała on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Quick
import Nimble

class Board_InitFromString_Spec: QuickSpec {
    override func spec() {
        describe("init") {
            context("when the board is valid") {
                it("parses the board") {
                    let string =
                        "8w       \n" +
                        "7        \n" +
                        "6        \n" +
                        "5   wb   \n" +
                        "4        \n" +
                        "3     b  \n" +
                        "2        \n" +
                        "1       b\n" +
                        " abcdefgh"

                    let board = Board(from: string)
                    print(board)
                    let expected = Board(taken: [
                        Move(x: .a, y: ._8, takenBy: .White),
                        Move(x: .d, y: ._5, takenBy: .White),
                        Move(x: .f, y: ._3, takenBy: .Black),
                        Move(x: .h, y: ._1, takenBy: .Black),
                        Move(x: .e, y: ._5, takenBy: .Black)
                    ])
                    print("============")
                    print(expected)

                    expect(board).to(equal(expected))
                }
            }
        }
    }
}
