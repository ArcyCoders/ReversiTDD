//
//  Field+ASCII.swift
//  ReversiConsole
//
//  Created by Pawel Leszkiewicz on 03.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import ReversiCore

extension Row
{
    public static func row(from character: Character) -> Row?
    {
        guard let value = Int(String(character)) else { return nil }
        return Row(rawValue: value - 1)
    }
}

extension Column
{
    public static func column(from character: Character) -> Column?
    {
        guard let value = Column.symbols().index(of: character) else { return nil }
        return Column(rawValue: value)
    }
}

extension Field
{
    init?(ascii: String)
    {
        guard let row = Field.parseRow(ascii: ascii),
            let column = Field.parseColumn(ascii: ascii) else { return nil }
        self.init(row, column)
    }

    fileprivate static func parseRow(ascii: String) -> Row?
    {
        for c in ascii.characters
        {
            if let row = Row.row(from: c) { return row }
        }

        return nil
    }

    fileprivate static func parseColumn(ascii: String) -> Column?
    {
        for c in ascii.characters
        {
            if let column = Column.column(from: c) { return column }
        }

        return nil
    }
}

