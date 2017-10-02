//
//  BoardHelper.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 24.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
@testable import ReversiCore

extension Board
{
    enum FieldType: Int
    {
        case black = 0, white, empty
    }

    static func random(allowBlackFields: Bool = true, allowWhiteFields: Bool = true, allowEmptyFields: Bool = true) -> Board
    {
        var fieldTypes = [FieldType]()
        if allowBlackFields { fieldTypes.append(.black) }
        if allowWhiteFields { fieldTypes.append(.white) }
        if allowEmptyFields { fieldTypes.append(.empty) }

        guard !fieldTypes.isEmpty else
        {
            return Board(emptyFields: Set<Field>(), blackFields: Set<Field>(), whiteFields: Set<Field>())
        }

        var emptyFields = Set<Field>()
        var blackFields = Set<Field>()
        var whiteFields = Set<Field>()

        let allFields = Field.all()
        allFields.forEach { (field) in

            let index = Int(arc4random_uniform(UInt32(fieldTypes.count)))
            let fieldType: FieldType = fieldTypes[index]
            switch fieldType
            {
            case .black:
                blackFields.insert(field)
            case .white:
                whiteFields.insert(field)
            case .empty:
                emptyFields.insert(field)
            }
        }

        return Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
    }

    static func randomAsciiRepresentation() -> String
    {
        return Board.random().output()
    }
}
