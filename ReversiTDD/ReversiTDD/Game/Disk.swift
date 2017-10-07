//
//  Disk.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

class Disk: Equatable {
    enum Color: Int {
        case white, black
    }

    fileprivate(set) var currentColor: Color

    public var hashValue: Int { return "currentColor:\(currentColor)".hashValue }

    init(currentColor: Color) {
        self.currentColor = currentColor
    }

    public func turnOver() {
        currentColor = currentColor == .white ? .black : .white
    }

    static func ==(lhs: Disk, rhs: Disk) -> Bool {
        return lhs.currentColor == rhs.currentColor
    }
}
