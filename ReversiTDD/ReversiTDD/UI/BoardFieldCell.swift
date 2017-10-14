//
//  FieldView.swift
//  ReversiTDD
//
//  Created by Sebastian Ewak on 14/10/2017.
//  Copyright © 2017 ArcyCoders. All rights reserved.
//

import UIKit
import Foundation

@IBDesignable
class BoardFieldCell: UICollectionViewCell {
    private weak var diskLayer: CALayer!

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let diskFrame = bounds.insetBy(dx: 6, dy: 6)
        diskLayer.frame = diskFrame
        diskLayer.cornerRadius = 0.5 * diskFrame.height
    }

    func setup(withField field: Field, isValid: Bool = false) {
        if let disk = field.disk {
            diskLayer.backgroundColor = disk.currentColor == .white ? UIColor.white.cgColor : UIColor.black.cgColor
        }
        else {
            diskLayer.backgroundColor = UIColor.clear.cgColor
        }

        if isValid {
            UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: { [weak self] in
                self?.backgroundColor = .green
                self?.backgroundColor = .clear
                }, completion: nil)
        }
        else {
            layer.removeAllAnimations()
        }
    }

    private func commonInit() {
        backgroundColor = UIColor.lightGray
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2

        let diskLayer = CALayer()
        diskLayer.frame = frame
        diskLayer.backgroundColor = UIColor.clear.cgColor
        self.diskLayer = diskLayer
        layer.addSublayer(diskLayer)
    }
}
