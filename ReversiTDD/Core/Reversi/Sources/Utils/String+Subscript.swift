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
    public subscript (i: Int) -> Character
    {
        return self[index(startIndex, offsetBy: i)]
    }

    public subscript (i: Int) -> String
    {
        return String(self[i] as Character)
    }

    public subscript (r: Range<Int>) -> String
    {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}
