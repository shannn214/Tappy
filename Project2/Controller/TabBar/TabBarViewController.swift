//
//  TabBarViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

enum TabBar {

    case game

    case achievement

    case collection

    case setting

    func controller() -> UIViewController {

        switch self {

        case .game:

            return UIStoryboard.gameStoryboard().instantiateInitialViewController()!

        case .achievement:

            let nav = UIStoryboard.cardStoryboard().instantiateInitialViewController() as? UINavigationController

            nav!.viewControllers[0].loadViewIfNeeded()

            return nav!

        case .collection:

            let navC = UIStoryboard.collectionStoryboard().instantiateInitialViewController() as? UINavigationController

            navC!.viewControllers[0].loadViewIfNeeded()

            return navC!

        case .setting:

            return UIStoryboard.settingStoryboard().instantiateInitialViewController()!

        }
    }

    func image() -> UIImage {

        switch self {

        case .game:

            return #imageLiteral(resourceName: "gamepad-5")

        case .achievement:

            return #imageLiteral(resourceName: "medal")

        case .collection:

            return #imageLiteral(resourceName: "vynil-3")

        case .setting:

            return #imageLiteral(resourceName: "settings-3")

        }

    }

    func selectedImage() -> UIImage {

        switch self {

        case .game:

            return #imageLiteral(resourceName: "gamepad-5").withRenderingMode(.alwaysOriginal)

        case .achievement:

            return #imageLiteral(resourceName: "medal").withRenderingMode(.alwaysOriginal)

        case .collection:

            return #imageLiteral(resourceName: "vynil-3").withRenderingMode(.alwaysOriginal)

        case .setting:

            return #imageLiteral(resourceName: "settings-3").withRenderingMode(.alwaysOriginal)

        }

    }

}

class TabBarViewController: UITabBarController {

    let tabs: [TabBar] = [.game, .achievement, .collection]

    // NOTE: Hide .setting for first publish

    let containerView = UIView()

    var playerVC: TestPlayerViewController?

    var flag: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()

        addPlayerTest()

    }

    func addPlayerTest() {

        guard let playerViewController = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? TestPlayerViewController else { return }

        playerVC = playerViewController

//        ------------

//        containerView.backgroundColor = UIColor.clear
//
//        view.addSubview(containerView)
//
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//
//        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//
//        containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true

//        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height - tabBar.bounds.height - 60).isActive = true

//        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

//        view.bringSubview(toFront: containerView)
//
//        containerView.addSubview((playerVC?.view)!)
//
//        containerView.clipsToBounds = false

//        -------------

//        playerVC?.view.translatesAutoresizingMaskIntoConstraints = false
//
//        playerVC?.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
//
//        playerVC?.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
//
//        playerVC?.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
//
//        playerVC?.view.heightAnchor.constraint(equalToConstant: (playerVC?.view.bounds.height)!).isActive = true

        view.addSubview((playerVC?.view)!)

        view.bringSubview(toFront: (playerVC?.view)!)

        playerVC?.view.frame = CGRect(x: 0,
                                      y: view.bounds.height - tabBar.bounds.height - 50,
                                      width: (playerVC?.view.bounds.width)!, height: (playerVC?.view.bounds.height)!)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panPlayer(panGesture:)))

        playerVC?.view.isUserInteractionEnabled = true

//        containerView.isUserInteractionEnabled = true

        playerVC?.view.addGestureRecognizer(panGesture)

        view.bringSubview(toFront: tabBar)

    }

    @objc func panPlayer(panGesture: UIPanGestureRecognizer) {

        let touchPoint = panGesture.location(in: playerVC?.view.window)

        let trans = panGesture.translation(in: playerVC?.view.window)

        let moving = abs(trans.y)

        if panGesture.state == UIGestureRecognizerState.changed {

                if flag == true {

                    if trans.y < 0 {

                        playerVC?.view.frame = CGRect(x: 0,
                                                      y: view.bounds.height - tabBar.bounds.height - 50 - moving,
                                                      width: (playerVC?.view.bounds.width)!,
                                                      height: (playerVC?.view.bounds.height)!)

                    }

                } else if flag == false {

                    if touchPoint.y > 0 && trans.y > 0 {

                    playerVC?.view.frame = CGRect(x: 0,
                                                  y: trans.y,
                                                  width: (playerVC?.view.bounds.width)!,
                                                  height: (playerVC?.view.bounds.height)!)

                    }

                }

        } else if panGesture.state == UIGestureRecognizerState.ended || panGesture.state == UIGestureRecognizerState.cancelled {

            if trans.y < -200 {

                UIView.animate(withDuration: 0.3, animations: {

                    self.playerVC?.view.frame = self.view.bounds

                    self.tabBar.alpha = 0

                })

                flag = false

            } else {

                UIView.animate(withDuration: 0.3, animations: {

                    self.playerVC?.view.frame = CGRect(x: 0,
                                                       y: self.view.bounds.height - self.tabBar.bounds.height - 50,
                                                       width: (self.playerVC?.view.bounds.width)!,
                                                       height: (self.playerVC?.view.bounds.height)!)

                    self.tabBar.alpha = 1

                })

                flag = true

            }

        }

//        if panGesture.state == UIGestureRecognizerState.changed {
//
//            if flag == true {
//
//                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 667 + trans.y).isActive = true
//
//            } else if flag == false {
//
//                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -moving).isActive = true
//
//            }
//
//            print(containerView.frame)
//
//        } else if panGesture.state == UIGestureRecognizerState.ended || panGesture.state == UIGestureRecognizerState.cancelled {
//
//            if trans.y < 100 {
//
//                containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
//                flag = false
//
//            } else {
//
//                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
//
//                flag = true
//
//            }
//
//        }

    }

    private func setupTab() {

        tabBar.tintColor = UIColor.black

        tabBar.backgroundImage = UIImage()

        var controllers: [UIViewController] = []

        for tab in tabs {

            let controller = tab.controller()

            let item = UITabBarItem(title: nil,
                                    image: tab.image(),
                                    selectedImage: tab.selectedImage())

            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            controller.tabBarItem = item
            controllers.append(controller)
        }

        setViewControllers(controllers, animated: false)

    }

}
