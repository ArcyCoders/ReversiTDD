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
    static let fieldsCount: Int = Column.count() * Row.count()

    let emptyFields: Set<Field>
    let blackFields: Set<Field>
    let whiteFields: Set<Field>

    static func == (lhs: Board, rhs: Board) -> Bool
    {
        guard lhs.emptyFields.count == rhs.emptyFields.count && lhs.blackFields.count == rhs.blackFields.count && lhs.whiteFields.count == rhs.whiteFields.count else { return false }
        return lhs.emptyFields == rhs.emptyFields && lhs.blackFields == rhs.blackFields && lhs.whiteFields == rhs.whiteFields
    }
}

extension Board
{
    // Board in ASCII representation:
    //
    // empty: "_"
    // black: "*"
    // white: "o"
    init?(ascii: String)
    {
        guard ascii.characters.count == Board.fieldsCount else { return nil }

        var emptyFields = Set<Field>()
        var blackFields = Set<Field>()
        var whiteFields = Set<Field>()

        for (index, character) in ascii.characters.enumerated()
        {
            if let row = Row(rawValue: index / Row.count()),
                let col = Column(rawValue: index % Column.count())
            {
                let field = Field(row, col)
                switch character
                {
                case "*": blackFields.insert(field); break
                case "o": whiteFields.insert(field); break
                case "_": emptyFields.insert(field); break
                default:
                    print("Unknown symbol: \(character)")
                    emptyFields.insert(field)
                }
            }
        }

        self.emptyFields = emptyFields
        self.blackFields = blackFields
        self.whiteFields = whiteFields
    }

    func output(showCoordinates: Bool = false) -> String
    {
        var output: String = ""
        if showCoordinates
        {
            let aScalars = "a".unicodeScalars
            let aCode = aScalars[aScalars.startIndex].value
            let letters: [Character] = (0..<Column.count()).flatMap {
                guard let scalar = UnicodeScalar(aCode + UInt32($0)) else { return nil }
                return Character(scalar)
            }

            output += " \(String(letters))\n"
        }

        let columns = Column.all()
        let rows = Row.all()
        for row in rows
        {
            var rowAscii: String = ""
            for col in columns
            {
                let field = Field(row, col)
                if emptyFields.contains(field) { rowAscii += "_" }
                else if blackFields.contains(field) { rowAscii += "*" }
                else if whiteFields.contains(field) { rowAscii += "o" }
                else { rowAscii += "?" }
            }

            if showCoordinates
            {
                output += "\(row.rawValue + 1)" + rowAscii + "\n"
            }
            else
            {
                output += rowAscii
            }
        }

        return output
    }
}
