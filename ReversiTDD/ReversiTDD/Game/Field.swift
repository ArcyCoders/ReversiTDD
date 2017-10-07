//
//  Field.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

class Field: Equatable, Hashable {
    let column: Column
    let row: Row
    var disk: Disk?

    public init(column: Column, row: Row, disk: Disk) {
        self.column = column
        self.row = row
        self.disk = disk
    }

    static func ==(lhs: Field, rhs: Field) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column && lhs.disk == rhs.disk
    }

    public var hashValue: Int {
        return "\(row)\(column)disk:\(disk?.hashValue ?? 0)".hashValue
    }
}
