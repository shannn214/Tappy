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

            return UIStoryboard.cardStoryboard().instantiateInitialViewController()!

        case .collection:

            return UIStoryboard.collectionStoryboard().instantiateInitialViewController()!

        case .setting:

            return UIStoryboard.settingStoryboard().instantiateInitialViewController()!

        }
    }

    func image() -> UIImage {

        switch self {

        case .game:

            return #imageLiteral(resourceName: "gamepad-2")

        case .achievement:

            return #imageLiteral(resourceName: "badge")

        case .collection:

            return #imageLiteral(resourceName: "vynil")

        case .setting:

            return #imageLiteral(resourceName: "settings-2")

        }

    }

    func selectedImage() -> UIImage {

        switch self {

        case .game:

            return #imageLiteral(resourceName: "gamepad-4").withRenderingMode(.alwaysOriginal)

        case .achievement:

            return #imageLiteral(resourceName: "badge").withRenderingMode(.alwaysOriginal)

        case .collection:

            return #imageLiteral(resourceName: "vynil-2").withRenderingMode(.alwaysOriginal)

        case .setting:

            return #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal)

        }

    }

}

class TabBarViewController: UITabBarController {

    let tabs: [TabBar] = [.game, .achievement, .collection, .setting]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
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
