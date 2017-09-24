//
//  BoardHelper.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 24.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
@testable import ReversiTDD

extension Board
{
    static func random() -> Board
    {
        var emptyFields = [Field]()
        var blackFields = [Field]()
        var whiteFields = [Field]()

        let allFields = Field.all()
        allFields.forEach { (field) in

            let index = Int(arc4random_uniform(3))
            switch index
            {
            case 0:
                blackFields.append(field)
            case 1:
                whiteFields.append(field)
            default:
                emptyFields.append(field)
            }
        }

        return Board(emptyFields: emptyFields, blackFields: blackFields, whiteFields: whiteFields)
    }

    static func randomAsciiRepresentation() -> String
    {
        return Board.random().output()
    }
}
