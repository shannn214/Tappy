//
//  AchievementViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import Instructions

class CardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewImage: UIImageView!
    @IBOutlet weak var topViewLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!

    var cardTransition: CGFloat?

    let layer = CAGradientLayer()

    let popUpRecordVC = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(popUpGuideView(notification:)),
            name: .showCardGuideMaskAction,
            object: nil
        )

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cardListViewController = segue.destination as? CardListViewController {
            cardListViewController.delegate = self
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func setup() {

        setupGradient(layer: layer)

        self.gradientView.layer.addSublayer(layer)

        topViewImage.layer.cornerRadius = 15

        topViewImage.image = #imageLiteral(resourceName: "right_pink")

    }

    @objc func popUpGuideView(notification: Notification) {

        guard let guideView = UIStoryboard.introStoryboard().instantiateViewController(withIdentifier: "GuideViewController") as? GuideViewController else { return }
        self.addChildViewController(guideView)
        guideView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(guideView.view)
        guideView.cardGuideViewAnimation()

    }

}

extension CardViewController: CardListControllerDelegate {

    func cardViewDisScroll(_ controller: CardListViewController, translation: CGFloat) {
        self.cardTransition = translation
        changeTopView()
    }

    func changeTopView() {

        guard let cardY = cardTransition else { return }
//        if cardY <= changePoint {
//            topView.frame = CGRect(x: 0, y: (0 - cardY), width: topView.frame.width, height: topView.frame.height)

            topViewHeightConstraint.constant = Constants.topViewHeight - cardY
            topImageConstraint.constant = Constants.monsterTopConstraint - cardY

            self.gradientHeightConstraint.constant = Constants.topViewHeight - cardY
//        }

        if cardY <= Constants.topViewAlphaPoint {
            let percentage = cardY / Constants.topViewAlphaPoint
            topViewImage.alpha = 1.0 - percentage
        }

    }

}
