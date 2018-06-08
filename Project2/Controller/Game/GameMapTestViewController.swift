//
//  GameMapTestViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/22.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class GameMapTestViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var ghostTapGesture: UITapGestureRecognizer!

    var checkLevel = 0

    var maskLayer: MaskLayer!

    var gameMapScrollView: GameMapScrollView!

    var gameMapBGScrollView: GameMapBGScrollView!

    var popUpRecordVC: PopUpRecordViewController!

    var backScrollView: UIScrollView!

    var backImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadButton()
    }

    func initialSetup() {

        gameMapBGScrollView = GameMapBGScrollView(view: view)
        gameMapScrollView = GameMapScrollView(view: view)
        view.addSubview(gameMapBGScrollView!)
        view.addSubview(gameMapScrollView!)
        gameMapScrollView.tapDelegate = self
        gameMapScrollView.delegate = self

        popUpRecordVC = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentageScroll = gameMapScrollView.contentOffset.x
        gameMapBGScrollView.contentOffset = CGPoint(x: percentageScroll * 0.7, y: 0)
    }

    func loadButton() {

        if LevelStatusManager.shared.level! > 0 {

            for level in 0...LevelStatusManager.shared.level! - 1 {
                gameMapScrollView.explosionImages = gameMapScrollView.createImageAnimation(total: 37, imageRefix: "Comp 1_000")
                gameMapScrollView.CDButtonArray[level].isHidden = false
                gameMapScrollView.explosionArray[level].isHidden = false
                gameMapScrollView.animate(imageView: gameMapScrollView.explosionArray[level], images: gameMapScrollView.explosionImages)
            }

        }

        if LevelStatusManager.shared.level! < 10 {
            let level = LevelStatusManager.shared.level!
            gameMapScrollView.propsButtonArray[level].isHidden = false
        }

    }

    func changeFrameForGuide() {

        UIView.animate(withDuration: 2, animations: {
            self.gameMapScrollView.contentOffset = CGPoint(x: 45 * self.gameMapScrollView.mapImageView.frame.width / 100, y: 0)
        }) { (_) in
            self.firstGuide()
        }

    }

    func firstGuide() {

        addPopUpRecordVC(popUpRecordVC: popUpRecordVC)

        popUpRecordVC.popUpfirstGuide(parent: self)

        popUpRecordVC.firstGuideTouchHandler = {
            self.showMaskLayer()
        }

    }

    func secondGuide() {

        addPopUpRecordVC(popUpRecordVC: popUpRecordVC)

        popUpRecordVC.popUpsecondGuide(parent: self)

    }

    func monsterTapped(tapGestureRecognizer: UITapGestureRecognizer) {

        if tapGestureRecognizer.state == .ended {
            let murmur = MurmurView(frame: CGRect(x: -10, y: -35, width: 120, height: 30))
            murmur.frame = CGRect(x: 5, y: -35, width: murmur.frame.width, height: murmur.frame.height)
            gameMapScrollView.monster.addSubview(murmur)
            murmur.createMurmur {
                murmur.removeFromSuperview()
            }
        }

    }

    // NOTE: Prop Button
    func propCase(index: Int) {
        let sortedArray = DBProvider.shared.sortedArray
        let info = sortedArray![index]
        popUpPropView(image: info.cover, hint: "You found the record!")
        gameMapScrollView.propsButtonArray[index].isHidden = true

        if index + 1 < 10 {
            gameMapScrollView.propsButtonArray[index + 1].isHidden = false
        }

        if index == 0 {
            removeMask()
        }
    }

    func showCDAndProp(sender: UIButton!) {

        self.checkLevel = LevelStatusManager.shared.level! + 1

        if self.checkLevel < 11 {
            LevelStatusManager.shared.updateLevel(newLevel: self.checkLevel)
        }

        let btnSendTag: UIButton = sender
        propCase(index: btnSendTag.tag)

    }

    // NOTE: Record Button
    func levelCase(index: Int) {

        gameMapScrollView.CDButtonArray[index].isHidden = false
        gameMapScrollView.explosionArray[index].isHidden = false
        gameMapScrollView.animate(imageView: gameMapScrollView.explosionArray[index], images: gameMapScrollView.explosionImages)

    }

    func showCDButtonCase(level: Int) {

        levelCase(index: level - 1)

    }

    func showCDButton() {

        self.checkLevel = LevelStatusManager.shared.level!
        showCDButtonCase(level: checkLevel)

    }

    // NOTE: Player View
    func tapRecordCase(tag: Int) {

        presentPlayerVC(level: tag)

    }

    func showRecordTab(sender: UIButton!) {

        let btnSendTag: UIButton = sender
        tapRecordCase(tag: btnSendTag.tag)

    }

    func presentPlayerVC(level: Int) {

        guard let sortedArray = DBProvider.shared.sortedArray else { return }

        guard let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController else { return }
        let info = sortedArray[level]
        SpotifyManager.shared.playMusic(track: info.trackUri)

        present(playerVC, animated: true) {
            playerVC.playerPanelView.cover.sd_setImage(with: URL(string: info.cover))
            playerVC.backgroundCover.sd_setImage(with: URL(string: info.cover))
            playerVC.playerPanelView.artist.text = info.artist
            playerVC.playerPanelView.trackName.text = info.trackName
        }

    }

    func showMaskLayer() {

        maskLayer = MaskLayer()
        maskLayer.createMask(rect: Constants.mapMaskBezRect,
                             roundedRect: Constants.mapMaskRoundedRect,
                             cornerRadius: Constants.maskCornerRadius)
        view.layer.addSublayer(maskLayer)

    }

    func removeMask() {

        maskLayer.removeFromSuperlayer()

    }

    // NOTE: PopUp View
    func popUpPropView(image: String, hint: String) {

        addPopUpRecordVC(popUpRecordVC: popUpRecordVC)

        popUpRecordVC.popProp(hint: hint, image: image)

        popUpViewAnimation(popUpRecordVC: popUpRecordVC)

        popUpRecordVC.propTouchHandler = {
            self.showCDButton()
        }

        popUpRecordVC.firstPropTouchHandler = {
            self.secondGuide()
        }

    }

    func introPopUpView() {

        addPopUpRecordVC(popUpRecordVC: popUpRecordVC)

        popUpRecordVC.view.alpha = 0
        popUpRecordVC.popUpIntro()

        popUpViewAnimation(popUpRecordVC: popUpRecordVC)

        popUpRecordVC.startGuideFlowHandler = {
            self.changeFrameForGuide()
        }

    }

}

extension GameMapTestViewController: GameMapScrollDelegate {

    func monsterDidTap(_ controller: GameMapScrollView, tapGestureRecognizer: UITapGestureRecognizer) {
        monsterTapped(tapGestureRecognizer: tapGestureRecognizer)
    }

    func propButtonDidTap(_ controller: GameMapScrollView, sender: UIButton!) {
        showCDAndProp(sender: sender)
    }

    func CDButtonDidTap(_ controller: GameMapScrollView, sender: UIButton!) {
        showRecordTab(sender: sender)
    }

}
