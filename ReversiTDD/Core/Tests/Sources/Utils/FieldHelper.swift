//
//  FieldHelper.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 24.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
@testable import ReversiCore

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
