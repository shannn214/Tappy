//
//  GameMapTestViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/22.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class GameMapTestViewController: UIViewController {

    @IBOutlet var ghostTapGesture: UITapGestureRecognizer!

    var checkLevel = 0

    let maskLayer = CAShapeLayer()

    //------------------------
    // NOTE: Should add "!" here?
    var gameMapScrollView: GameMapScrollView!

    var popUprecordVC: PopUpRecordViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()

        loadButton()

//        ghostTapGesture.cancelsTouchesInView = false
//        self.imageView.isUserInteractionEnabled = true

    }

    func initialSetup() {

        gameMapScrollView = GameMapScrollView(view: view)
        view.addSubview(gameMapScrollView!)
        gameMapScrollView.tapDelegate = self

        popUprecordVC = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController

    }

    func showMaskLayer() {

        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 15 * UIScreen.main.bounds.width / 100, y: 68 * UIScreen.main.bounds.height / 100, width: 300, height: 150), cornerRadius: 20)
        path.append(maskPath.reversing())

        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor(displayP3Red: 24/255, green: 24/255, blue: 24/255, alpha: 0.7).cgColor
        view.layer.addSublayer(maskLayer)

    }

    func removeMask() {
        maskLayer.removeFromSuperlayer()
    }

    func showSecondGuide() {

        self.addChildViewController(popUprecordVC)
        popUprecordVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUprecordVC.view)
        popUprecordVC.popUpsecondGuide(parent: self)

    }

    func changeFrameForGuide() {

        UIView.animate(withDuration: 2, animations: {
            //animation
            self.gameMapScrollView.contentOffset = CGPoint(x: 45 * self.gameMapScrollView.mapImageView.frame.width / 100, y: 0)
        }) { (_) in
            //completion
            self.firstGuide()
        }

    }

    func firstGuide() {

        self.addChildViewController(popUprecordVC)
        popUprecordVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUprecordVC.view)
        popUprecordVC.popUpfirstGuide(parent: self)

        popUprecordVC.firstGuideTouchHandler = {
            self.showMaskLayer()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func gameMapDidTap(controller: GameViewController, position: CGFloat) {

        gameMapScrollView.monster.frame = CGRect(x: position, y: 77,
                                                  width: gameMapScrollView.monster.frame.size.width,
                                                  height: gameMapScrollView.monster.frame.size.height)
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

    func monsterTapped(tapGestureRecognizer: UITapGestureRecognizer) {

        if tapGestureRecognizer.state == .ended {
            let murmur = MurmurView()
            murmur.frame = CGRect(x: -10, y: -35, width: murmur.frame.width, height: murmur.frame.height)
            gameMapScrollView.monster.addSubview(murmur)
            murmur.createMurmur {
                murmur.removeFromSuperview()
            }
        }

    }

    func propCase(index: Int) {
        let sortedArray = DBProvider.shared.sortedArray
        let info = sortedArray![index]
        popUpPropView(image: info.cover, hint: "You found the record!")
        gameMapScrollView.propsButtonArray[index].isHidden = true
        gameMapScrollView.propsButtonArray[index + 1].isHidden = false
    }

    func showCDAndProp(sender: UIButton!) {

        let sortedArray = DBProvider.shared.sortedArray

        self.checkLevel = LevelStatusManager.shared.level! + 1

        if self.checkLevel < 11 {
            LevelStatusManager.shared.updateLevel(newLevel: self.checkLevel)
        }

        let btnSendTag: UIButton = sender
        switch btnSendTag.tag {
        case 0:
            propCase(index: 0)
            removeMask()
        case 1:
            propCase(index: 1)
        case 2:
            propCase(index: 2)
        case 3:
            propCase(index: 3)
        case 4:
            propCase(index: 4)
        case 5:
            propCase(index: 5)
        case 6:
            propCase(index: 6)
        case 7:
            propCase(index: 7)
        case 8:
            propCase(index: 8)
        case 9:
            gameMapScrollView.propsButtonArray[9].isHidden = true
            let info = sortedArray![9]
            popUpPropView(image: info.cover, hint: "You found the record!")
        default:
            return
        }

    }

    func showRecordTab(sender: UIButton!) {

        let btnSendTag: UIButton = sender
        switch btnSendTag.tag {
        case 0:
            presentPlayerVC(level: 0)
        case 1:
            presentPlayerVC(level: 1)
        case 2:
            presentPlayerVC(level: 2)
        case 3:
            presentPlayerVC(level: 3)
        case 4:
            presentPlayerVC(level: 4)
        case 5:
            presentPlayerVC(level: 5)
        case 6:
            presentPlayerVC(level: 6)
        case 7:
            presentPlayerVC(level: 7)
        case 8:
            presentPlayerVC(level: 8)
        case 9:
            presentPlayerVC(level: 9)
        default:
            break
        }

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

    func levelCase(index: Int) {

        gameMapScrollView.CDButtonArray[index].isHidden = false
        gameMapScrollView.explosionArray[index].isHidden = false
        gameMapScrollView.animate(imageView: gameMapScrollView.explosionArray[index], images: gameMapScrollView.explosionImages)

    }

    func showCDButton() {

        self.checkLevel = LevelStatusManager.shared.level!

        switch checkLevel {
        case 1:
            levelCase(index: 0)
        case 2:
            levelCase(index: 1)
        case 3:
            levelCase(index: 2)
        case 4:
            levelCase(index: 3)
        case 5:
            levelCase(index: 4)
        case 6:
            levelCase(index: 5)
        case 7:
            levelCase(index: 6)
        case 8:
            levelCase(index: 7)
        case 9:
            levelCase(index: 8)
        case 10:
            levelCase(index: 9)
        default:
            break
        }

    }

    // NOTE: Pop Prop View

    func popUpPropView(image: String, hint: String) {

        self.addChildViewController(popUprecordVC)
        popUprecordVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUprecordVC.view)
        popUprecordVC.popProp(hint: hint, image: image)
        UIView.animate(withDuration: 0.3) {
            self.popUprecordVC.view.alpha = 1
            self.popUprecordVC.didMove(toParentViewController: self)
        }
        popUprecordVC.propTouchHandler = {
            self.showCDButton()
        }

        popUprecordVC.firstPropTouchHandler = {
            self.showSecondGuide()
        }

    }

    func introPopUpView() {

        self.addChildViewController(popUprecordVC)
        popUprecordVC.view.frame = self.view.frame
        self.view.addSubview(popUprecordVC.view)
        popUprecordVC.view.alpha = 0
        popUprecordVC.popUpIntro()

        UIView.animate(withDuration: 0.2) {
            self.popUprecordVC.view.alpha = 1
            self.popUprecordVC.didMove(toParentViewController: self)
        }

        popUprecordVC.startGuideFlowHandler = {
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
