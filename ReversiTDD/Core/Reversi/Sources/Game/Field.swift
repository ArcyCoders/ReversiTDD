//
//  Field.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public enum Row: Int, CustomStringConvertible
{
    case _1 = 0, _2, _3, _4, _5, _6, _7, _8, _9, _10
    public static func all() -> [Row] { return [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8, ._9, ._10] }
    public static func count() -> Int { return (Row._10.rawValue + 1) }
    public var description: String { return "\(rawValue + 1)" }
}

public enum Column: Int, CustomStringConvertible
{
    case a = 0, b, c, d, e, f, g, h, i, j
    public static func all() -> [Column] { return [.a, .b, .c, .d, .e, .f, .g, .h, .i, .j] }
    public static func count() -> Int { return (Column.j.rawValue + 1) }
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
    public var description: String { return String(Column.symbols()[rawValue]) }
}

public struct Field: Equatable, Hashable, CustomStringConvertible
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
    public var description: String { return "\(row)\(column)" }
}
