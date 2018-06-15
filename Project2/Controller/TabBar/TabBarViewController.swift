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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()

//        let containerView = UIView()
//
//        containerView.backgroundColor = UIColor.blue
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
//
//        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//
//        view.bringSubview(toFront: containerView)

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
