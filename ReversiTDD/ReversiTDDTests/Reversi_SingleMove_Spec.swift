//
//  Reversi_SingleMove_Spec.swift
//  ReversiTDD
//
//  Created by Krzysztof Moczała on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Quick
import Nimble

class Reversi_SingleMove_Spec: QuickSpec {
    override func spec() {
        testMove(
            from:
                "8        " + "\n" +
                "7        " + "\n" +
                "6        " + "\n" +
                "5   wb   " + "\n" +
                "4        " + "\n" +
                "3        " + "\n" +
                "2        " + "\n" +
                "1        " + "\n" +
                " abcdefgh",
            currentPlayer: .Black,
            move: (x: .c, ._5),
            to:
                "8        " + "\n" +
                "7        " + "\n" +
                "6        " + "\n" +
                "5  bbb   " + "\n" +
                "4        " + "\n" +
                "3        " + "\n" +
                "2        " + "\n" +
                "1        " + "\n" +
                " abcdefgh"
        )

        testMove(
            from:
                "8        " + "\n" +
                "7        " + "\n" +
                "6        " + "\n" +
                "5bw      " + "\n" +
                "4        " + "\n" +
                "3        " + "\n" +
                "2        " + "\n" +
                "1        " + "\n" +
                " abcdefgh",
            currentPlayer: .Black,
            move: (x: .c, ._5),
            to:
                "8        " + "\n" +
                "7        " + "\n" +
                "6        " + "\n" +
                "5bbb     " + "\n" +
                "4        " + "\n" +
                "3        " + "\n" +
                "2        " + "\n" +
                "1        " + "\n" +
                " abcdefgh"
        )
    }
}

fileprivate func testMove(from: String, currentPlayer: Player, move: (x: Horizontal, y: Vertical), to: String) {
    it("") {
        print("\n==========")
        let startingBoard = Board(from: from)
        print("STARTING BOARD:")
        print(startingBoard.description)
        let reversi = Reversi(board: startingBoard, currentPlayer: currentPlayer)

        reversi.put(x: move.x, y: move.y)
        print("ACTUAL:")
        print(reversi.board.description)

        let expected = Board(from: to)
        print("EXPECTED")
        print(expected.description)
        print("==========")
        expect(reversi.board).to(equal(expected))
    }
}