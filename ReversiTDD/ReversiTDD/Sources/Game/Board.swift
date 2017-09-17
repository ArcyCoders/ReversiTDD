//
//  Board.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Board: Equatable
{
    let emptyFields: [Field]
    let blackFields: [Field]
    let whiteFields: [Field]

    // Initial board
    //
    // 01234567
    // 0________
    // 1________
    // 2________
    // 3___o*___
    // 4___*o___
    // 5________
    // 6________
    // 7________
    init()
    {
        let array = Array(0...63)
        self.emptyFields = array.flatMap { (index) -> Field? in
            let y = index % 8
            let x = index / 8
            if (x == 3 || x == 4) && (y == 3 || y == 4) { return nil }
            return Field(x: x, y: y)
        }
        self.blackFields = [Field(x: 3, y: 3), Field(x: 4, y: 4)]
        self.whiteFields = [Field(x: 4, y: 3), Field(x: 3, y: 4)]
    }

    // Custom board
    init(emptyFields: [Field], blackFields: [Field], whiteFields: [Field])
    {
        self.emptyFields = emptyFields
        self.blackFields = blackFields
        self.whiteFields = whiteFields
    }

    static func == (lhs: Board, rhs: Board) -> Bool
    {
        guard lhs.emptyFields.count == rhs.emptyFields.count && lhs.blackFields.count == rhs.blackFields.count && lhs.whiteFields.count == rhs.whiteFields.count else { return false }
        return lhs.emptyFields == rhs.emptyFields && lhs.blackFields == rhs.blackFields && lhs.whiteFields == rhs.whiteFields
    }
}
