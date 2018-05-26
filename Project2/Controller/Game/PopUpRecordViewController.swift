//
//  PopUpRecordViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import SDWebImage

class PopUpRecordViewController: UIViewController {

    @IBOutlet weak var recordCover: UIImageView!
    @IBOutlet weak var recordTitle: UILabel!
    @IBOutlet weak var propView: UIView!
    @IBOutlet weak var introView: UIView!
    @IBOutlet weak var introTextView: UITextView!

    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        introViewSetup()
        propViewSetup()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func introViewSetup() {

        self.introView.layer.cornerRadius = 20
        self.introTextView.text = "Hi, there. \n Please read the hint below. \n Then try to find something in the map.\n "

    }

    func propViewSetup() {

        self.propView.layer.cornerRadius = 20

    }

    @IBAction func nextButton(_ sender: Any) {
        self.view.removeFromSuperview()
    }

    @IBAction func leaveButton(_ sender: Any) {

        NotificationCenter.default.post(name: .leavePropPopView,
                                        object: nil
                                        )
        self.view.removeFromSuperview()

    }

}
