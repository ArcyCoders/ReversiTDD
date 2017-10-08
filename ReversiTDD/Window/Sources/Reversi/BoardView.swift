//
//  BoardView.swift
//  ReversiWindow
//
//  Created by Pawel Leszkiewicz on 08.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Cocoa
import ReversiCore

class BoardView: NSView
{
    var board: Board? { didSet { reloadView() } }
    
//    override func draw(_ dirtyRect: NSRect)
//    {
//        super.draw(dirtyRect)
//
//        // Drawing code here.
//    }

    fileprivate func createBoard(board: Board)
    {
        guard subviews.isEmpty else { return }

        layer?.backgroundColor = NSColor.red.cgColor
        translatesAutoresizingMaskIntoConstraints = false

        let columnsCount: Int = Column.count()
        let rowsCount: Int = Row.count()

        let width: CGFloat = bounds.width / CGFloat(columnsCount)
        let height: CGFloat = bounds.height / CGFloat(rowsCount)
        var rect = CGRect(x: 0, y: 0, width: width, height: height)
        for row in 0..<rowsCount
        {
            for column in 0..<columnsCount
            {
                rect.origin = CGPoint(x: CGFloat(column) * width, y: CGFloat(row) * height)
                let button = NSButton(frame: rect)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.title = ""
                button.bezelStyle = .texturedSquare
                button.isBordered = false //Important
                button.wantsLayer = true
                button.layer?.backgroundColor = NSColor.green.cgColor
                button.layer?.borderColor = NSColor.white.cgColor
                button.layer?.borderWidth = 1
                addSubview(button)
            }
        }
    }

    fileprivate func destroyBoard()
    {
        let childViews = subviews
        childViews.forEach { $0.removeFromSuperview() }
    }

    override func layout()
    {
        super.layout()

        if let board = board
        {
            destroyBoard()
            createBoard(board: board)
            reloadView()
        }
    }

    fileprivate func reloadView()
    {
        guard let board = board else { return }

        let width: CGFloat = bounds.width / CGFloat(Column.count())
        let height: CGFloat = bounds.height / CGFloat(Row.count())
        let fieldSize = CGSize(width: width, height: height)

        board.blackFields.forEach { (field) in
            let fieldView = self.fieldView(field: field, fieldSize: fieldSize, color: NSColor.black)
            addSubview(fieldView)
        }

        board.whiteFields.forEach { (field) in
            let fieldView = self.fieldView(field: field, fieldSize: fieldSize, color: NSColor.white)
            addSubview(fieldView)
        }
    }

    fileprivate func fieldView(field: Field, fieldSize: CGSize, color: NSColor) -> NSView
    {
        let radius = 0.4 * min(fieldSize.width, fieldSize.height)
        let column = field.column.rawValue
        let row = field.row.rawValue
        let origin = CGPoint(x: (CGFloat(column) + 0.5) * fieldSize.width - radius, y: (CGFloat(row) + 0.5) * fieldSize.height - radius)
        let rect = CGRect(x: origin.x, y: origin.y, width: 2 * radius, height: 2 * radius)
        let fieldView = NSView(frame: rect)
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        fieldView.wantsLayer = true
        fieldView.layer?.cornerRadius = radius
        fieldView.layer?.backgroundColor = color.cgColor
        fieldView.layer?.masksToBounds = true
        return fieldView
    }
}
