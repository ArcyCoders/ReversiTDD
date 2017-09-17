//
//  Field.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 16.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

struct Field: Equatable
{
    let x: Int
    let y: Int

    static func == (lhs: Field, rhs: Field) -> Bool
    {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
