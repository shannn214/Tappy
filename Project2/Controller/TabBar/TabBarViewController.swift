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

    let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? TestPlayerViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()

        addPlayerTest()

    }

    func addPlayerTest() {

        containerView.backgroundColor = UIColor.yellow

        view.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true

        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true

//        containerView.frame = CGRect(x: 0, y: 400, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height - tabBar.bounds.height - 60).isActive = true

//        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        view.bringSubview(toFront: containerView)

//        self.addChildViewController(playerVC)

        containerView.addSubview((playerVC?.view)!)

        containerView.clipsToBounds = true

        playerVC?.view.translatesAutoresizingMaskIntoConstraints = false

        playerVC?.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true

        playerVC?.view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true

        playerVC?.view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true

        playerVC?.view.heightAnchor.constraint(equalToConstant: (playerVC?.view.bounds.height)!).isActive = true

//        containerView.addSubview(playerVC.view)

//        self.view.addSubview(playerVC.view)

//        playerVC.view.frame = CGRect(x: 0, y: 600, width: containerView.bounds.width, height: containerView.bounds.height)

//        self.view.bringSubview(toFront: playerVC.view)

//        playerVC.view.bounds = CGRect(x: 0, y: -400, width: UIScreen.main.bounds.width, height: 50)

//        playerVC.didMove(toParentViewController: self)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panPlayer(panGesture:)))

        playerVC?.view.isUserInteractionEnabled = true

        containerView.isUserInteractionEnabled = true

        playerVC?.view.addGestureRecognizer(panGesture)

    }

    @objc func panPlayer(panGesture: UIPanGestureRecognizer) {

        let touchPoint = panGesture.location(in: playerVC?.view.window)

        let trans = panGesture.translation(in: playerVC?.view.window)

        let moving = abs(trans.y)

        if panGesture.state == UIGestureRecognizerState.changed {

//            if touchPoint.y > 0 {

                containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 667 - moving).isActive = true

//            }

//            containerView.heightAnchor.constraint(equalToConstant: 60 + moving).isActive = true

            print(containerView.frame)

        } else if panGesture.state == UIGestureRecognizerState.ended || panGesture.state == UIGestureRecognizerState.cancelled {

            if touchPoint.y < 300 {

                self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

            } else {

                UIView.animate(withDuration: 0.3, animations: {

                    self.containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 600).isActive = true

                })

            }

        }

        containerView.layoutIfNeeded()

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
