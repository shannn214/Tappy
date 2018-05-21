//
//  RecordCollectionViewCell.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/17.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class RecordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var recordHole: UIView!
    @IBOutlet weak var recordPlaceHolderView: UIView!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        cover.layer.cornerRadius = cover.bounds.size.width * 0.5

        setting(view: recordHole)
        setting(view: recordPlaceHolderView)

    }

    func setting(view: UIView) {

        view.layer.cornerRadius = view.bounds.size.width * 0.5
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 2

    }

}
