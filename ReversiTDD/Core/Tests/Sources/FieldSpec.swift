//
//  FieldSpec.swift
//  ReversiTDD
//
//  Created by Pawel Leszkiewicz on 23.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import ReversiCore

class RowSpec: QuickSpec
{
    override func spec()
    {
        describe("Row.all()")
        {
            it("should have the same number of elements as Row.count()")
            {
                expect(Row.all().count) == Row.count()
            }
        }
    }
}

class ColumnSpec: QuickSpec
{
    override func spec()
    {
        describe("Column.all()")
        {
            it("should have the same number of elements as Column.count()")
            {
                expect(Column.all().count) == Column.count()
            }
        }
    }
}

class FieldSpec: QuickSpec
{
    // property based testing - losowość
    override func spec()
    {
        describe("init(row:col:)")
        {
            it("should initialize field")
            {
                for row in Row.all()
                {
                    for col in Column.all()
                    {
                        let field = Field(row, col)
                        expect(field.row).to(equal(row))
                        expect(field.column).to(equal(col))
                    }
                }
            }
        }

        describe("all()")
        {
            it("should return all fields")
            {
                expect(Field.all().count) == Row.count() * Column.count()
            }
        }

        describe("==(lhs:rhs:)")
        {
            it("should check if two identical fields are equal")
            {
                for row in Row.all()
                {
                    for col in Column.all()
                    {
                        let field1 = Field(row, col)
                        let field2 = Field(row, col)
                        expect(field1).to(equal(field2))
                    }
                }
            }

            it("should check if two different fields are not equal")
            {
                let allFields = Field.all()
                for field1 in allFields
                {
                    for field2 in allFields
                    {
                        if (field1.row == field2.row) && (field1.column == field2.column) { continue }
                        expect(field1).toNot(equal(field2))
                    }
                }
            }
        }
    }
}
