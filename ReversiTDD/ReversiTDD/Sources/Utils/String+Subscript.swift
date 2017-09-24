//
//  String+Subscript.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 23.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

extension String
{
    subscript (i: Int) -> Character
    {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String
    {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String
    {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[Range(start ..< end)]
    }
}
