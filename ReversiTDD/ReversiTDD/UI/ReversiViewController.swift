//
//  ViewController.swift
//  ReversiTDD
//
//  Created by Michal Miedlarz on 03.09.2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import UIKit

class ReversiViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let fieldCellId = "fieldCellId"
    let fieldsInDirectionCount: Int = 8

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var currentPlayerColorView: UIView!
    @IBOutlet private weak var blackScoreLabel: UILabel!
    @IBOutlet private weak var whiteScoreLabel: UILabel!

    private var reversi: Reversi!
    private var board: Board!
    private var validMoves: [Field] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero

        collectionView.register(BoardFieldCell.self, forCellWithReuseIdentifier: fieldCellId)
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = .zero
        collectionView.delegate = self
        collectionView.dataSource = self

        board = Board()
        reversi = Reversi(withBoard: board, withFlankedFieldsFinder: FlankedFieldsFinder())
        reversi.start()
        validMoves = reversi.getValidMovesForCurrentPlayer()
        updateCurrentScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fieldCellId, for: indexPath)

        if let cell = cell as? BoardFieldCell {
            if let column = Column(rawValue: indexPath.item),
               let row = Row(rawValue: indexPath.section),
               let field = board.getField(column: column, row: row) {
                cell.setup(withField: field, isValid: isValidPosition(Position(row: row, column: column)))
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldsInDirectionCount
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fieldsInDirectionCount
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let column = Column(rawValue: indexPath.item),
           let row = Row(rawValue: indexPath.section),
           isValidPosition(Position(row: row, column: column)) {
            reversi.move(to: Field(column: column, row: row, disk: nil))
            validMoves = reversi.getValidMovesForCurrentPlayer()
            updateCurrentScore()
            collectionView.reloadData()

            if reversi.isFinished {
                showGameFinishedAlert()
            }
        }
    }

    // MARK: - UICollectionViewFlowLayoutDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = min(view.frame.width, view.frame.height) / CGFloat(fieldsInDirectionCount)

        return CGSize(width: size, height: size)
    }

    // MARK: - Helpers

    private func isValidPosition(_ position: Position) -> Bool {
        return validMoves.contains(where: { $0.column == position.column && $0.row == position.row })
    }

    private func showGameFinishedAlert() {
        let results = reversi.getCurrentResults()
        let winningScore = results.winningPlayer == .white ? results.whiteScore : results.blackScore
        let losingScore = results.winningPlayer == .white ? results.blackScore : results.whiteScore

        let alert = UIAlertController(title: "Game finished", message: "\(results.winningPlayer) has won \(winningScore) to \(losingScore)", preferredStyle: .alert)
        present(alert, animated: true)
    }

    private func updateCurrentScore() {
        currentPlayerColorView.backgroundColor = reversi.currentPlayer == .white ? .white : .black

        whiteScoreLabel.text = "White score: \(board.getNumberOfFieldsTaken(ofColor: .white))"
        blackScoreLabel.text = "Black score: \(board.getNumberOfFieldsTaken(ofColor: .black))"
    }
}
