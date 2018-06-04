//
//  GameMapTestViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/22.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class GameMapTestViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var explosionImage: UIImageView!
    var explosionImages: [UIImage] = []

    @IBOutlet var ghostTapGesture: UITapGestureRecognizer!

    var checkLevel = 0
    let CDButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    let explosionArray = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    let propsButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
//    let guideArray = [UIButton(), UIButton(), UIButton(), UIButton()]

    let animation = CAKeyframeAnimation(keyPath: "position")
    var monster: UIImageView!
    var monsterImages: [UIImage] = []

    let maskLayer = CAShapeLayer()

//    let tabarVC = AppDelegate.shared?.window?.rootViewController as? TabBarViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        createScrollViewAndMap()
        createCharacter()
        createPropsButton()
        createButton()
        setExplosionImage()
        loadButton()

        notificationField()

//        ghostTapGesture.cancelsTouchesInView = false
        self.imageView.isUserInteractionEnabled = true

    }

    func notificationField() {

        NotificationCenter.default.addObserver(self, selector: #selector(showCDButton(notification:)), name: .leavePropPopView, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(changeFrameForGuide(notification:)), name: .startGuideFlow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(showMaskLayer(notification:)), name: .showMaskAction, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(showSecondGuide(notification:)), name: .showSecondGuideAction, object: nil)

    }

    @objc func showMaskLayer(notification: Notification) {

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

    @objc func showSecondGuide(notification: Notification) {

        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.popUpsecondGuide(parent: self)

    }

    @objc func changeFrameForGuide(notification: Notification) {

        UIView.animate(withDuration: 2, animations: {
            //animation
            self.scrollView.contentOffset = CGPoint(x: 45 * self.imageView.frame.width / 100, y: 0)
        }) { (_) in
            //completion
            self.firstGuide()
        }

    }

    func firstGuide() {

        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.popUpfirstGuide(parent: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func gameMapDidTap(controller: GameViewController, position: CGFloat) {
        self.monster.frame = CGRect(x: position, y: 77,
                                    width: self.monster.frame.size.width,
                                    height: self.monster.frame.size.height)
    }

    func loadButton() {

        if LevelStatusManager.shared.level! > 0 {

            for level in 0...LevelStatusManager.shared.level! - 1 {
                explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

                CDButtonArray[level].isHidden = false
                explosionArray[level].isHidden = false
                animate(imageView: explosionArray[level], images: explosionImages)
            }

        }

        if LevelStatusManager.shared.level! < 10 {
            let level = LevelStatusManager.shared.level!
            propsButtonArray[level].isHidden = false
        }

    }

    func createCharacter() {

        monster = UIImageView()
//        monsterImages = createImageAnimationForGhost(total: 2, imageRefix: "peek_ghost")
//        animate(imageView: monster, images: monsterImages)
        monster.image = #imageLiteral(resourceName: "right_pink")
        monster.frame = CGRect(x: 2 * imageView.bounds.width / 100, y: 77 * imageView.bounds.height/100, width: 75, height: 62)

        self.imageView.addSubview(monster)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(monsterTapped(tapGestureRecognizer:)))
        monster.isUserInteractionEnabled = true
        monster.addGestureRecognizer(tapGestureRecognizer)

    }

    @objc func monsterTapped(tapGestureRecognizer: UITapGestureRecognizer) {

        if tapGestureRecognizer.state == .ended {
            let murmur = MurmurView()
            murmur.frame = CGRect(x: -10, y: -35, width: murmur.frame.width, height: murmur.frame.height)
            monster.addSubview(murmur)
            murmur.createMurmur {
                murmur.removeFromSuperview()
            }
        }

    }

    // 1) Start to move code
    func createScrollViewAndMap() {

        guard let url = Bundle.main.path(forResource: "mapppp-01", ofType: ".png") else { return }

        let image = UIImage(contentsOfFile: url)

        imageView = UIImageView(image: image)
        imageView.frame.size.height = UIScreen.main.bounds.height
        imageView.frame.size.width = UIScreen.main.bounds.height/3297 * 22041
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = CGSize(width: imageView.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.autoresizingMask = [.flexibleWidth]
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)

    }
    //-----

    //2)
    func propsButtonSetup(index: Int, positionX: CGFloat, positionY: CGFloat) {

        propsButtonArray[index].frame = CGRect(origin: CGPoint(x: positionX * imageView.bounds.width / 100,
                                                               y: positionY * imageView.bounds.height/100),
                                               size: CGSize(width: 60, height: 60))

    }

    func createPropsButton() {

        for btnIndex in 0...9 {

            propsButtonArray[btnIndex].setImage(UIImage(), for: .normal)
            propsButtonArray[btnIndex].backgroundColor = UIColor.clear
            self.imageView.addSubview(propsButtonArray[btnIndex])
            imageView.bringSubview(toFront: propsButtonArray[btnIndex])
            propsButtonArray[btnIndex].isHidden = true
            propsButtonArray[btnIndex].tag = btnIndex
            propsButtonArray[btnIndex].addTarget(self, action: #selector(showCDAndProp), for: .touchUpInside)

        }
        // NOTE: Setup props position
        propsButtonSetup(index: 0, positionX: 50, positionY: 70)
        propsButtonSetup(index: 1, positionX: 32, positionY: 53)
        propsButtonSetup(index: 2, positionX: 88, positionY: 20)
        propsButtonSetup(index: 3, positionX: 62, positionY: 40)
        propsButtonSetup(index: 4, positionX: 14.5, positionY: 4)
        propsButtonSetup(index: 5, positionX: 82.5, positionY: 71)
        propsButtonSetup(index: 6, positionX: 22, positionY: 30)
        propsButtonSetup(index: 7, positionX: 2, positionY: 77)
        propsButtonSetup(index: 8, positionX: 72, positionY: 16)
        propsButtonSetup(index: 9, positionX: 12.5, positionY: 21.4)

    }
    //----------

    @objc func showCDAndProp(sender: UIButton!) {

        let sortedArray = DBProvider.shared.sortedArray

        self.checkLevel = LevelStatusManager.shared.level! + 1

        if self.checkLevel < 11 {
            LevelStatusManager.shared.updateLevel(newLevel: self.checkLevel)
        }

        let btnSendTag: UIButton = sender
        switch btnSendTag.tag {
        case 0:
            propsButtonArray[0].isHidden = true
            propsButtonArray[1].isHidden = false
            removeMask()
            let info = sortedArray![0]
            popUpPropView(image: info.cover, hint: "You found the first record!")
        case 1:
            propsButtonArray[1].isHidden = true
            propsButtonArray[2].isHidden = false
            let info = sortedArray![1]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 2:
            propsButtonArray[2].isHidden = true
            propsButtonArray[3].isHidden = false
            let info = sortedArray![2]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 3:
            propsButtonArray[3].isHidden = true
            propsButtonArray[4].isHidden = false
            let info = sortedArray![3]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 4:
            propsButtonArray[4].isHidden = true
            propsButtonArray[5].isHidden = false
            let info = sortedArray![4]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 5:
            propsButtonArray[5].isHidden = true
            propsButtonArray[6].isHidden = false
            let info = sortedArray![5]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 6:
            propsButtonArray[6].isHidden = true
            propsButtonArray[7].isHidden = false
            let info = sortedArray![6]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 7:
            propsButtonArray[7].isHidden = true
            propsButtonArray[8].isHidden = false
            let info = sortedArray![7]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 8:
            propsButtonArray[8].isHidden = true
            propsButtonArray[9].isHidden = false
            let info = sortedArray![8]
            popUpPropView(image: info.cover, hint: "You found the record!")
        case 9:
            propsButtonArray[9].isHidden = true
            let info = sortedArray![9]
            popUpPropView(image: info.cover, hint: "You found the record!")
        default:
            return
        }

    }

    //3)
    func createButton() {

        for btnIndex in 0...9 {

            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            self.imageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
            CDButtonArray[btnIndex].tag = btnIndex
            CDButtonArray[btnIndex].addTarget(self, action: #selector(showRecordTab), for: .touchUpInside)
            CDButtonArray[btnIndex].center = propsButtonArray[btnIndex].center
            CDButtonArray[btnIndex].bounds.size = CGSize(width: 60, height: 60)

        }

    }
    //---------

    @objc func showRecordTab(sender: UIButton!) {

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

    //4)
    func setExplosionImage() {

        for explosionIndex in 0...9 {

            explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

            self.imageView.addSubview(explosionArray[explosionIndex])
            explosionArray[explosionIndex].backgroundColor = UIColor.clear
            explosionArray[explosionIndex].isHidden = true
            explosionArray[explosionIndex].tag = explosionIndex
            animate(imageView: explosionArray[explosionIndex], images: explosionImages)

            explosionArray[explosionIndex].center = CDButtonArray[explosionIndex].center
            explosionArray[explosionIndex].bounds.size = CGSize(width: 180, height: 180)

        }

    }
    //---------

    func levelCase(index: Int, positionX: CGFloat) {

        CDButtonArray[index].isHidden = false
        explosionArray[index].isHidden = false
        animate(imageView: explosionArray[index], images: explosionImages)

    }

    @objc func showCDButton(notification: Notification) {

        self.checkLevel = LevelStatusManager.shared.level!

        explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

        switch checkLevel {
        case 1:
            CDButtonArray[0].isHidden = false
            explosionArray[0].isHidden = false
            animate(imageView: explosionArray[0], images: explosionImages)
        case 2:
            levelCase(index: 1, positionX: 14)
        case 3:
            levelCase(index: 2, positionX: 25)
        case 4:
            levelCase(index: 3, positionX: 37)
        case 5:
            levelCase(index: 4, positionX: 48)
        case 6:
            levelCase(index: 5, positionX: 64)
        case 7:
            levelCase(index: 6, positionX: 78)
        case 8:
            levelCase(index: 7, positionX: 90)
        case 9:
            CDButtonArray[8].isHidden = false
            explosionArray[8].isHidden = false
            animate(imageView: explosionArray[8], images: explosionImages)
        default:
            CDButtonArray[9].isHidden = false
            explosionArray[9].isHidden = false
            animate(imageView: explosionArray[9], images: explosionImages)
        }

    }

    // NOTE: Animation functions
    func movingAnimations(start: CGPoint, end: CGPoint) {

        let start = start
        let end = end

        animation.values = [NSValue(cgPoint: start), NSValue(cgPoint: end)]
        animation.keyTimes = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        animation.duration = 2.0
        monster.layer.add(animation, forKey: "move")

    }

    func createImageAnimation(total: Int, imageRefix: String) -> [UIImage] {

        var imageArray: [UIImage] = []

        for imageCount in 10..<total {
            let imageName = "\(imageRefix)\(imageCount).png"
            let image = UIImage(named: imageName)!

            imageArray.append(image)
        }

        return imageArray

    }

    func createImageAnimationForGhost(total: Int, imageRefix: String) -> [UIImage] {

        var imageArray: [UIImage] = []

        for imageCount in 0..<total {
            let imageName = "\(imageRefix)\(imageCount).png"
            let image = UIImage(named: imageName)!

            imageArray.append(image)
        }

        return imageArray

    }

    func animate(imageView: UIImageView, images: [UIImage]) {

        imageView.animationImages = images
        imageView.animationDuration = 0.8
        imageView.animationRepeatCount = 0
        imageView.startAnimating()

    }

    // NOTE: Pop Prop View

    func popUpPropView(image: String, hint: String) {

        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.popProp(hint: hint, image: image)
        UIView.animate(withDuration: 0.3) {
            popUpRecordView.view.alpha = 1
            popUpRecordView.didMove(toParentViewController: self)
        }

    }

}
