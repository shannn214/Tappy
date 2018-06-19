//
//  AppStoreCollectionViewCell.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

protocol CellViewDelegate: class {
    func cellTouchedEnded(_ cell: AppStoreCollectionViewCell)
}

class AppStoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var appStoreCellView: AppStoreView!

    weak var delegate: CellViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        print("touch begin")

        touchCellContentView()

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        print("touch move")

        touchCellContentView()

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        print("-----------")
        print("touch end")

        self.delegate?.cellTouchedEnded(self)

    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        print("touch cancel")

        touchCellContentEnded()

    }

    func touchCellContentView() {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                        self.appStoreCellView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) },
                       completion: nil)

    }

    func touchCellContentEnded() {

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.appStoreCellView.transform = CGAffineTransform.identity
        }, completion: nil)

    }

}
