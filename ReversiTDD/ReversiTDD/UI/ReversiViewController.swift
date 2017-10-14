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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fieldCellId, for: indexPath)

        if let cell = cell as? BoardFieldCell {
            if let column = Column(rawValue: indexPath.item),
               let row = Row(rawValue: indexPath.section),
               let field = board.getField(column: column, row: row) {
                    cell.setup(withField: field)
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

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - check if valid move and if so make move to position
        // if valid position
        //      make move
        //      update UI (current player and reload data)
    }

    // MARK: UICollectionViewFlowLayoutDelegate

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = min(view.frame.width, view.frame.height) / CGFloat(fieldsInDirectionCount)

        return CGSize(width: size, height: size)
    }
}
