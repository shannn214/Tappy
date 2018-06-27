//
//  SettingCollectionViewCell.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

protocol CellViewDelegate: class {
    func cellTouchedEnded(_ cell: SettingCollectionViewCell)
}

class SettingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!

    weak var delegate: CellViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        cellView.layer.cornerRadius = 20
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        touchCellContentView()

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        touchCellContentView()

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

//        UIView.animate(withDuration: 0.1,
//                       delay: 0,
//                       options: .curveEaseIn,
//                       animations: {
//                            self.cellView.transform = CGAffineTransform.identity },
//                       completion: { (_) in
//                            self.delegate?.cellTouchedEnded(self)
//        })

        self.delegate?.cellTouchedEnded(self)

    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        touchCellContentEnded()

    }

    func touchCellContentView() {

        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                        self.cellView.transform = CGAffineTransform(scaleX: 0.94, y: 0.94) },
                       completion: nil)

    }

    func touchCellContentEnded() {

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.cellView.transform = CGAffineTransform.identity
        }, completion: nil)

    }

}
