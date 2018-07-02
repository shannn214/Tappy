//
//  SettingDetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

protocol SettingDetailDelegate: class {
    func detailBackToSmallSize(_ controller: SettingDetailViewController)
}

class SettingDetailViewController: UIViewController {

    @IBOutlet weak var detailContainer: UIView!

    var selectedIndex: IndexPath?

    var selectedPoint: CGPoint?

    weak var settingDetailDelegate: SettingDetailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let detailViewController = segue.destination as? DetailTableViewController {

            detailViewController.selectedCellIndex = selectedIndex

            detailViewController.detailDelegate = self

        }

    }

    func initialSetup() {

        self.view.layer.cornerRadius = 20
        self.view.clipsToBounds = true

    }

    func changeToFullScreen() {

        self.view.layer.cornerRadius = 0

    }

}

extension SettingDetailViewController: DetailDelegate {

    func detailDidScroll(translation: CGFloat) {

        if translation < 0 {

//            self.view.frame.origin = CGPoint(x: 0, y: -translation)

        }

        if translation < -100 {

            self.settingDetailDelegate?.detailBackToSmallSize(self)

        }

    }

}
