//
//  Field.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 10.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import UIKit

enum Disk: Int {
    case White
    case Black
    
    var stringValue: String {
        switch self
        {
            case .Black: return "Black"
            case .White: return "White"
        }
    }
}

class Field: Equatable, Hashable {
    let x: Int
    let y: Int
    let disk: Disk?
    
    init(x: Int, y: Int, disk: Disk?)
    {
        self.x = x
        self.y = y
        self.disk = disk
    }
    
    static func == (lhs: Field, rhs: Field) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.disk == rhs.disk
    }
    
    var hashValue: Int {
        return "x:\(x);y:\(y);disk:\(String(describing: disk))".hashValue
    }
}
