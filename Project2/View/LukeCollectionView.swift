//
//  LukeCollectionView.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/28.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class LukeCollectionView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        print("yoyoyo")
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {

        guard let actionView = gestureRecognizer.view else { return true }

        if actionView.isKind(of: UICollectionViewCell.self) {
            return false
        }

        return true
    }

}
