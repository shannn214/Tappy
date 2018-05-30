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
    @IBOutlet weak var showPlayerButton: UIButton!

    @IBOutlet weak var gradientHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!

    let topViewHeight: CGFloat = 255
    var changePoint: CGFloat = 0
    var alphaPoint: CGFloat = 190
    var recordTransition: CGFloat?
    var collectionTransition: CGFloat?
    var rotateFlag: Bool?

    let layer = CAGradientLayer()

    let designSetting = DesignSetting()

    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(trackIsStreaming(notification:)),
            name: .trackPlayinyStatus,
            object: nil
        )

        self.view.isUserInteractionEnabled = true
        self.view.isMultipleTouchEnabled = true
        self.recordsContainerView.isUserInteractionEnabled = true

//        let btn_1_Point = showPlayerButton.convert(CGPoint(x: 0, y: 0), from: self.recordsContainerView)
//        recordsContainerView.hitTest(btn_1_Point, with: )

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if rotateFlag == true {
            rotate(image: collectionCover)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let collectionListViewController = segue.destination as? CollectionListViewController {
            collectionListViewController.delegate = self
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            guard let ttttouch: UITouch = touch as? UITouch else { return }
            if ttttouch.tapCount == 1 {
                let point = showPlayerButton.convert(CGPoint(x: 0, y: 0), from: self.view)
                topView.hitTest(point, with: event)
            }
        }
        super.touchesBegan(touches, with: event)
    }

//    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
//        let btn_1_Point = button_1.convertPoint(point, fromView: self)
//        guard button_1.pointInside(btn_1_Point, withEvent: event) else {
//            return super.hitTest(point, withEvent: event)
//        }
//        return button_1
//    }

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

        showPlayerButton.addTarget(self, action: #selector(showPlayerView), for: .touchUpInside)
        showPlayerButton.isHidden = false
        rotateFlag = false

    }

    @objc func showPlayerView() {

        guard let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController else { return }
        guard let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String,
              let artist = SpotifyManager.shared.player?.metadata.currentTrack?.artistName,
              let trackName = SpotifyManager.shared.player?.metadata.currentTrack?.name
        else { return }

        present(playerVC, animated: true) {
            playerVC.playerPanelView.cover.sd_setImage(with: URL(string: url))
            playerVC.backgroundCover.sd_setImage(with: URL(string: url))
            playerVC.playerPanelView.artist.text = artist
            playerVC.playerPanelView.trackName.text = trackName
        }

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
            topViewHeightConstraint.constant = topViewHeight - collectionY
            topImageConstraint.constant = 65 - collectionY
            self.gradientHeightConstraint.constant = topViewHeight - collectionY

//            topView.frame = CGRect(x: 0, y: 0 - collectionY, width: topView.frame.width, height: topViewHeight)
        }
        if collectionY <= alphaPoint {
            let percentage = collectionY / alphaPoint
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

    func removeAnimation(image: UIImageView) {
        image.layer.removeAllAnimations()
        image.layoutIfNeeded()
    }

    @objc func trackIsStreaming(notification: Notification) {

        guard let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String else { return }
        if SpotifyManager.shared.isPlaying == true {
            rotate(image: collectionCover)
            collectionCover.sd_setImage(with: URL(string: url), completed: nil)
            rotateFlag = true
            showPlayerButton.isHidden = false
        } else if SpotifyManager.shared.isPlaying == false {
            collectionCover.image = #imageLiteral(resourceName: "My-Boo")
            removeAnimation(image: collectionCover)
            rotateFlag = false
            showPlayerButton.isHidden = true
        }

    }
}
