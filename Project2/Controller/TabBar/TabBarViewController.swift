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

            return UIStoryboard.achievementStoryboard().instantiateInitialViewController()!
            
        case .collection:

            return UIStoryboard.collectionStoryboard().instantiateInitialViewController()!

        case .setting:

            return UIStoryboard.collectionStoryboard().instantiateInitialViewController()!

        }
    }

    func image() -> UIImage {

        switch self {

        case .game:

            return #imageLiteral(resourceName: "game_controller")

        case .collection:

            return #imageLiteral(resourceName: "music_record")

        case .achievement:

            return #imageLiteral(resourceName: "badge")

        case .setting:

            return #imageLiteral(resourceName: "setting")

        }

    }

//    func selectedImage() -> UIImage {
//
//    }

}

class TabBarViewController: UITabBarController {

    let tabs: [TabBar] = [.game, .achievement, .collection, .setting]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTab()
    }

    private func setupTab() {

        tabBar.tintColor = UIColor.black

        var controllers: [UIViewController] = []

        for tab in tabs {

            let controller = tab.controller()

            let item = UITabBarItem(title: nil,
                                    image: tab.image(),
                                    selectedImage: nil)

            item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)

            controllers.append(controller)
        }

        setViewControllers(controllers, animated: false)

    }

}
