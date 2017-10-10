//
//  BoardView.swift
//  ReversiWindow
//
//  Created by Pawel Leszkiewicz on 08.10.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import Cocoa
import ReversiCore

protocol BoardViewDelegate: class
{
    func boardView(sender: BoardView, didClickAt field: Field)
}

class BoardView: NSView
{
    var board: Board? { didSet { refreshBoard() } }
    weak var delegate: BoardViewDelegate?

    fileprivate var possibleMoves: [Field] = [] { didSet { refreshBoard() } }
    fileprivate var possibleMovesColor: NSColor?
    fileprivate var fieldElements: [NSView] = []

    func showPossibleMoves(_ moves: [Field], color: NSColor)
    {
        possibleMoves = moves
        possibleMovesColor = color
        refreshBoard()
    }

    fileprivate func createBoard(board: Board)
    {
        guard subviews.isEmpty else { return }

        layer?.backgroundColor = NSColor.red.cgColor
        translatesAutoresizingMaskIntoConstraints = false

        for row in 0..<Row.count()
        {
            for column in 0..<Column.count()
            {
                let view = NSView(frame: rectFromCoordinates(column: column, row: row))
                view.translatesAutoresizingMaskIntoConstraints = false
                view.wantsLayer = true
                view.layer?.backgroundColor = NSColor.green.cgColor
                view.layer?.borderColor = NSColor.white.cgColor
                view.layer?.borderWidth = 1
                addSubview(view)
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
            refreshBoard()
        }
    }

    fileprivate func refreshBoard()
    {
        fieldElements.forEach { $0.removeFromSuperview() }
        fieldElements.removeAll()

        guard let board = board else { return }

        board.blackFields.forEach { (field) in
            let fieldView = self.fieldView(field: field, color: NSColor.black)
            fieldElements.append(fieldView)
            addSubview(fieldView)
        }

        board.whiteFields.forEach { (field) in
            let fieldView = self.fieldView(field: field, color: NSColor.white)
            fieldElements.append(fieldView)
            addSubview(fieldView)
        }

        if let color = possibleMovesColor
        {
            possibleMoves.forEach { (field) in
                let button = self.possibleMoveButton(field: field, color: color)
                fieldElements.append(button)
                addSubview(button)
            }
        }
    }

    fileprivate func fieldView(field: Field, color: NSColor) -> NSView
    {
        let rect = rectFrom(field: field)
        let radius = 0.4 * min(rect.width, rect.height)
        let fieldRect = CGRect(x: rect.midX, y: rect.midY, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
        let fieldView = NSView(frame: fieldRect)
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        fieldView.wantsLayer = true
        fieldView.layer?.cornerRadius = radius
        fieldView.layer?.backgroundColor = color.cgColor
        fieldView.layer?.masksToBounds = true
        return fieldView
    }

    fileprivate func possibleMoveButton(field: Field, color: NSColor) -> NSButton
    {
        let rect = rectFrom(field: field)
        let radius = 0.4 * min(rect.width, rect.height)
        let fieldRect = CGRect(x: rect.midX, y: rect.midY, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
        let button = NSButton(frame: fieldRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = ""
        button.bezelStyle = .texturedSquare
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.cornerRadius = radius
        button.layer?.backgroundColor = color.cgColor
        button.layer?.masksToBounds = true
        button.target = self
        button.action = #selector(fieldButtonClicked(_:))
        return button
    }

    @objc fileprivate func fieldButtonClicked(_ sender: NSButton)
    {
        if let field = fieldFrom(rect: sender.frame)
        {
            delegate?.boardView(sender: self, didClickAt: field)
            print("Field button clicked: \(String(describing: field))")
        }
    }
}

extension BoardView
{
    //  abcdefgh
    // 1________
    // 2________
    // 3________
    // 4___o*___
    // 5___*o___
    // 6________
    // 7________
    // 8________
    fileprivate func rectFromCoordinates(column: Int, row: Int) -> CGRect
    {
        let width: CGFloat = bounds.width / CGFloat(Column.count())
        let height: CGFloat = bounds.height / CGFloat(Row.count())
        return CGRect(x: CGFloat(column) * width, y: bounds.height - CGFloat(row + 1) * height, width: width, height: height)
    }

    fileprivate func rectFrom(field: Field) -> CGRect
    {
        return rectFromCoordinates(column: field.column.rawValue, row: field.row.rawValue)
    }

    fileprivate func coordinatesFrom(rect: CGRect) -> (column: Int, row: Int)
    {
        let width: CGFloat = bounds.width / CGFloat(Column.count())
        let height: CGFloat = bounds.height / CGFloat(Row.count())
        return (column: Int(rect.midX / width), row: Int((bounds.height - rect.midY) / height))
    }

    fileprivate func fieldFrom(rect: CGRect) -> Field?
    {
        let coordinates = coordinatesFrom(rect: rect)
        guard let column = Column(rawValue: coordinates.column),
            let row = Row(rawValue: coordinates.row) else { return nil }
        return Field(row, column)
    }
}
