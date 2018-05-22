//
//  CardDetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/21.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class CardDetailViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func changeContraintToFullScreen() {
        leadingContraint.constant = 200
        view.layoutIfNeeded()
    }
}
