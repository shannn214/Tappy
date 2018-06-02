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

    var changePoint: CGFloat = 0
    var alphaPoint: CGFloat = 190
    var cardTransition: CGFloat?
    let layer = CAGradientLayer()

    let coachMarksController = CoachMarksController()
    let pointOfInterest = UIView()
    let customView = UIView()
    let overlayView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        self.coachMarksController.delegate = self
        self.coachMarksController.dataSource = self
        coachMarksController.overlay.color = UIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cardListViewController = segue.destination as? CardListViewController {
            cardListViewController.delegate = self
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        popUpGuideView()
//        self.coachMarksController.start(on: self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

//        self.coachMarksController.stop(immediately: true)
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

        topViewImage.image = #imageLiteral(resourceName: "right_pink")

    }

    func popUpGuideView() {

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
        if cardY <= changePoint {
//            topView.frame = CGRect(x: 0, y: (0 - cardY), width: topView.frame.width, height: topView.frame.height)

            topViewHeightConstraint.constant = topView.frame.height - cardY
            topImageConstraint.constant = 105 - cardY

            self.gradientHeightConstraint.constant = topView.frame.height - cardY
        }

        if cardY <= alphaPoint {
            let percentage = cardY / alphaPoint
            topViewImage.alpha = 1.0 - percentage
        }

    }

}

//----------
extension CardViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {

    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {

        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: false, withNextText: true, arrowOrientation: coachMark.arrowOrientation)

        coachViews.bodyView.hintLabel.text = "Tap the card!"
//        coachViews.bodyView. = "OK"

        return (bodyView: coachViews.bodyView, arrowView: nil)
    }

    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {

        var coachMark = coachMarksController.helper.makeCoachMark(for: customView, pointOfInterest: CGPoint(x: 20, y: 200)) { (_) -> UIBezierPath in
            return UIBezierPath(roundedRect: CGRect(x: 10, y: UIScreen.main.bounds.height * 0.4, width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.width * 0.45), cornerRadius: 20)
        }

        return coachMark
    }

    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }

}
