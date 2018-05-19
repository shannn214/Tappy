//
//  AchievementViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class CardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var topViewLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    var changePoint: CGFloat = 0
    var alphaPoint: CGFloat = 190
    var cardTransition: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cardListViewController = segue.destination as? CardListViewController {
            cardListViewController.delegate = self
        }

    }

}

extension CardViewController: CardListControllerDelegate {

    func cardViewDisScroll(_ controller: CardListViewController, translation: CGFloat) {
        self.cardTransition = translation
        changeTopView()
    }

    func changeTopView() {

        guard let cardY = cardTransition else { return }
        if cardY <= changePoint {
            topView.frame = CGRect(x: 0, y: (0 - cardY), width: topView.frame.width, height: topView.frame.height)
        }

    }

}
