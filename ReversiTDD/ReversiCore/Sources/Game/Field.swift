//
//  Field.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public enum Row: Int
{
    case _1 = 0, _2, _3, _4, _5, _6, _7, _8
    public static func all() -> [Row] { return [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8] }
    public static func count() -> Int { return (Row._8.rawValue + 1) }
}

public enum Column: Int
{
    case a = 0, b, c, d, e, f, g, h
    public static func all() -> [Column] { return [.a, .b, .c, .d, .e, .f, .g, .h] }
    public static func count() -> Int { return (Column.h.rawValue + 1) }
    public static func symbols() -> [Character]
    {
        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        let symbols: [Character] = (0..<Column.count()).flatMap {
            guard let scalar = UnicodeScalar(aCode + UInt32($0)) else { return nil }
            return Character(scalar)
        }

        return symbols
    }
}

public struct Field: Equatable, Hashable
{
    public let row: Row
    public let column: Column

    public init(_ row: Row, _ column: Column)
    {
        self.row = row
        self.column = column
    }

    public static func == (lhs: Field, rhs: Field) -> Bool
    {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }

    public var hashValue: Int { return 10000 * row.rawValue + column.rawValue }
}
