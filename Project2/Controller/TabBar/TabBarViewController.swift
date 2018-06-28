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

    let tabs: [TabBar] = [.game, .achievement, .collection, .setting]

    // NOTE: Hide .setting for first publish

    var playerVC: PlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()

        addPlayerTest()

    }

    func addPlayerTest() {

        guard let playerViewController = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController else { return }

        playerVC = playerViewController

        view.addSubview((playerVC?.view)!)

        view.bringSubview(toFront: (playerVC?.view)!)

        playerVC?.view.frame = CGRect(x: 0,
                                      y: view.bounds.height - tabBar.bounds.height - 50,
                                      width: (playerVC?.view.bounds.width)!, height: (playerVC?.view.bounds.height)!)

        playerVC?.view.isUserInteractionEnabled = true

        view.bringSubview(toFront: tabBar)

        playerVC?.playerDelegate = self

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

extension TabBarViewController: PlayerDelegate {

    func playerViewStatus(flag: Bool) {

        switch flag {
        case true:

            UIView.animate(withDuration: 0.3) {
                self.tabBar.alpha = 1
            }

        default:

            UIView.animate(withDuration: 0.3) {
                self.tabBar.alpha = 0
            }

        }

    }

}
