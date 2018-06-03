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

            return UIStoryboard.collectionStoryboard().instantiateInitialViewController()!

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

//        NotificationCenter.default.addObserver(self, selector: #selector(popUpGuideView(notification:)), name: .showCardGuideMaskAction, object: nil)

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

extension TabBarViewController {

//    @objc func popUpGuideView(notification: Notification) {
//
//        guard let guideView = UIStoryboard.introStoryboard().instantiateViewController(withIdentifier: "GuideViewController") as? GuideViewController else { return }
//        self.addChildViewController(guideView)
//        guideView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        self.view.addSubview(guideView.view)
//        guideView.cardGuideViewAnimation()
//
//    }
//
//    func orderedTabBarItemViews() -> [UIView] {
//        let interactionViews = tabBar.subviews.filter({$0.isUserInteractionEnabled})
//        return interactionViews.sorted(by: {$0.frame.minX < $1.frame.minX})
//    }

}
