//
//  SampleGameViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/29.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class SampleGameViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var monster: UIImageView!
    let loginSpotifyBtn = UIButton()
    @IBOutlet weak var logoutButton: UIButton!

    @IBOutlet var ghostTapGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        createScrollViewAndMap()
        createCharactor()
        self.imageView.isUserInteractionEnabled = true
        setupButton()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutAction(_ sender: Any) {

        DispatchQueue.main.async {
            //            AppDelegate.shared?.switchToMainStoryBoard()
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate?.window?.rootViewController = UIStoryboard.loginStorybaord().instantiateInitialViewController()
        }

    }

    func setupButton() {

        logoutButton.layer.cornerRadius = 15
        self.view.bringSubview(toFront: logoutButton)

    }

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {

        let tapPoint = sender.location(in: view)

        switch sender.state {
        case .ended:
            let pop = PopView()
            pop.center = sender.location(in: view)
            view.addSubview(pop)
            let point = view.window?.convert(tapPoint, to: self.scrollView)
            UIView.animate(withDuration: 0.4) {
                self.monster.frame = CGRect(x: (point?.x)!,
                                            y: 77 * self.imageView.bounds.height/100,
                                            width: 75, height: 62)
            }
        default:
            print("Nope")
        }

    }

    func createCharactor() {

        monster = UIImageView()
        monster.image = #imageLiteral(resourceName: "pinkQ_ghost")
        monster.frame = CGRect(x: 2 * imageView.bounds.width / 100, y: 77 * imageView.bounds.height/100, width: 75, height: 62)
        self.imageView.addSubview(monster)

    }

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

}
