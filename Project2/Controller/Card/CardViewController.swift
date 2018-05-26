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

    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!

    var changePoint: CGFloat = 0
    var alphaPoint: CGFloat = 190
    var cardTransition: CGFloat?
    let layer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cardListViewController = segue.destination as? CardListViewController {
            cardListViewController.delegate = self
        }

    }

    func setup() {

        layer.colors = [
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]

        layer.locations = [0.0, 0.3]

        layer.startPoint = CGPoint(x: 0.5, y: 0.0)

        layer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.frame = UIScreen.main.bounds

        self.gradientView.layer.addSublayer(layer)

        topViewImage.layer.cornerRadius = 15
//        topViewImage.layer.borderWidth = 1
//        topViewImage.layer.borderColor = UIColor.lightGray.cgColor
        topViewImage.image = #imageLiteral(resourceName: "peek_ghost0")

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
//            topView.frame = CGRect(x: 0, y: (0 - cardY), width: topView.frame.width, height: topView.frame.height)

            topViewHeightConstraint.constant = topView.frame.height - cardY
            topImageConstraint.constant = 65 - cardY

            self.gradientHeightConstraint.constant = topView.frame.height - cardY
        }

        if cardY <= alphaPoint {
            let percentage = cardY / alphaPoint
            topViewImage.alpha = 1.0 - percentage
        }

    }

}
