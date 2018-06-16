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
//    @IBOutlet weak var secondCollectionText: UILabel!
//    @IBOutlet weak var collectionCover: UIImageView!
    @IBOutlet weak var collectionTopView: CollectionTopView!
    @IBOutlet weak var gradientView: UIView!

    @IBOutlet weak var gradientHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
//
//    @IBOutlet weak var showPlayerButton: UIButton!

    var recordTransition: CGFloat?

    var collectionTransition: CGFloat?

    var rotateFlag: Bool?

    let layer = CAGradientLayer()

    let designSetting = DesignSetting()

    let shapeLayer = CAShapeLayer()

    var hitTestView: UIView!

    var showPlayer: UIButton!

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

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if rotateFlag == true {
            rotate(image: collectionTopView.topViewCover)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let collectionListViewController = segue.destination as? CollectionListViewController {
            collectionListViewController.delegate = self
        }

    }

    private func setup() {

        collectionTopView.topViewCover.layer.cornerRadius = collectionTopView.topViewCover.bounds.size.width * 0.5

        setupGradient(layer: layer)

        self.gradientView.layer.addSublayer(layer)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showPlayerView(tapGestureRecognizer:)))

        collectionTopView.topViewCover.isUserInteractionEnabled = true

        collectionTopView.topViewCover.addGestureRecognizer(tapGestureRecognizer)

        rotateFlag = false

    }

    @objc func showPlayerView(tapGestureRecognizer: UITapGestureRecognizer) {

        guard let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController,
              let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL,
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

        topView.frame = CGRect(x: 0, y: 0 - collectionY, width: topView.frame.width, height: 255)

//        topViewHeightConstraint.constant = SHConstants.topViewHeight - collectionY
//        topImageConstraint.constant = SHConstants.navigationBarHeight - collectionY
//        self.gradientHeightConstraint.constant = SHConstants.topViewHeight - collectionY

        if collectionY <= SHConstants.topViewAlphaPoint {
            let percentage = collectionY / SHConstants.topViewAlphaPoint
            collectionTopView.topViewCover.alpha = 1.0 - percentage
        }

    }

    func playerViewDidDismiss(url: String) {

        collectionTopView.topViewCover.sd_setImage(with: URL(string: url), completed: nil)
        rotate(image: collectionTopView.topViewCover)

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

        guard let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL else { return }

        if SpotifyManager.shared.isPlaying == true {

            rotate(image: collectionTopView.topViewCover)
            collectionTopView.topViewCover.sd_setImage(with: URL(string: url), completed: nil)
            rotateFlag = true

        } else if SpotifyManager.shared.isPlaying == false {

            collectionTopView.topViewCover.image = #imageLiteral(resourceName: "black_record")
            removeAnimation(image: collectionTopView.topViewCover)
            rotateFlag = false

        }

    }
}
