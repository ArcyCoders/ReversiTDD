//
//  Disk.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 07/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation

public class Disk: Equatable {
    public enum Color: Int {
        case white, black
    }

    private(set) var currentColor: Color

    public var hashValue: Int { return "currentColor:\(currentColor)".hashValue }

    public init(currentColor: Color) {
        self.currentColor = currentColor
    }

    public func turnOver() {
        currentColor = currentColor == .white ? .black : .white
    }

    public static func ==(lhs: Disk, rhs: Disk) -> Bool {
        return lhs.currentColor == rhs.currentColor
    }
}