//
//  CollectionViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class CollectionViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var recordsContainerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var secondCollectionText: UILabel!
    @IBOutlet weak var collectionCover: UIImageView!
    @IBOutlet weak var gradientView: UIView!

    @IBOutlet weak var gradientHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!

    let topViewHeight: CGFloat = 255
    var changePoint: CGFloat = 0
    var alphaPoint: CGFloat = 190
    var recordTransition: CGFloat?
    var collectionTransition: CGFloat?
    let layer = CAGradientLayer()

    let designSetting = DesignSetting()

    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        //collection cover animation test
        createCoverStroke()
        handleTap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        trackIsStreaming()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let collectionListViewController = segue.destination as? CollectionListViewController {
            collectionListViewController.delegate = self
        }
    }

    func createCoverStroke() {

//        let center = topView.center

//        let circularPath = UIBezierPath(ovalIn: collectionCover.bounds)
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = UIColor.blue.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = 4

//        collectionCover.layer.addSublayer(shapeLayer)
//        collectionCover.layer.addSublayer(shapeLayer)

    }

    func handleTap() {
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.duration = 3
//        animation.fillMode = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
//        shapeLayer.add(animation, forKey: "ani")
    }

    func setup() {

        collectionCover.layer.cornerRadius = collectionCover.bounds.size.width * 0.5

        layer.colors = [
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]

        layer.locations = [0.0, 0.35]

        layer.startPoint = CGPoint(x: 0.5, y: 0.0)

        layer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.frame = UIScreen.main.bounds

        self.gradientView.layer.addSublayer(layer)

    }

}

extension CollectionViewController: CollectionListControllerDelegate {

    func collectionViewDidScroll(_ controller: CollectionListViewController, translation: CGFloat) {
        self.collectionTransition = translation
        changeTopView()
    }

    func changeTopView() {

        guard let collectionY = collectionTransition else { return }
        if collectionY <= changePoint {
//            topView.frame = CGRect(x: 0, y: 0 - collectionY, width: topView.frame.width, height: topViewHeight)
            topViewHeightConstraint.constant = topViewHeight - collectionY
            topImageConstraint.constant = 65 - collectionY
            self.gradientHeightConstraint.constant = topViewHeight - collectionY

            //-----issue: gradient will delay-----
//            self.gradientView.frame = CGRect(x: 0, y: 0 - collectionY, width: topView.frame.width, height: topViewHeight)
//            layer.frame = CGRect(x: 0, y: 0 - collectionY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//            let xx = collectionY/660 as NSNumber
//            guard let tt = xx as? Double else { return }
//            layer.locations = [0.0, 0.35 - tt] as [NSNumber]

        }
        if collectionY <= alphaPoint {
            let percentage = collectionY/alphaPoint
            collectionCover.alpha = 1.0 - percentage
        }
    }

    func playerViewDidDismiss(url: String) {

        collectionCover.sd_setImage(with: URL(string: url), completed: nil)
        rotate(image: collectionCover)

    }

    func rotate(image: UIImageView) {

        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 10
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        image.layer.add(rotationAnimation, forKey: "rotationAnimation")
        image.layer.cornerRadius = image.bounds.size.width * 0.5

    }

    func trackIsStreaming() {

//        if SpotifyManager.shared.player?.playbackState.isPlaying != nil && SpotifyManager.shared.player?.playbackState.isPlaying == true {
//            rotate(image: collectionCover)
//        } else if !(SpotifyManager.shared.player?.playbackState.isPlaying)! {
//            collectionCover.image = #imageLiteral(resourceName: "My-Boo")
//        }

    }
}
