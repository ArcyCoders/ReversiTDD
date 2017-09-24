//
//  Field.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

enum Row: Int
{
    case _1 = 0, _2, _3, _4, _5, _6, _7, _8
    static func all() -> [Row] { return [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8] }
    static func count() -> Int { return (Row._8.rawValue + 1) }
}

enum Column: Int
{
    case a = 0, b, c, d, e, f, g, h
    static func all() -> [Column] { return [.a, .b, .c, .d, .e, .f, .g, .h] }
    static func count() -> Int { return (Column.h.rawValue + 1) }
}

struct Field: Equatable
{
    let row: Row
    let column: Column

    init(_ row: Row, _ column: Column)
    {
        self.row = row
        self.column = column
    }

    static func == (lhs: Field, rhs: Field) -> Bool
    {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}

extension Field
{
    static func all() -> [Field]
    {
        var fields = [Field]()
        for row in Row.all()
        {
            for col in Column.all()
            {
                fields.append(Field(row, col))
            }
        }

        return fields
    }
}
