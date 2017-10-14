//
//  Field.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public class Field: Equatable, Hashable {
    public let column: Column
    public let row: Row
    public var disk: Disk?

    public var isEmpty: Bool { return disk == nil }

    public var hashValue: Int { return "\(row)\(column)disk:\(disk?.hashValue ?? 0)".hashValue }

    public init(column: Column, row: Row, disk: Disk) {
        self.column = column
        self.row = row
        self.disk = disk
    }

    public static func ==(lhs: Field, rhs: Field) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column && lhs.disk == rhs.disk
    }
}
