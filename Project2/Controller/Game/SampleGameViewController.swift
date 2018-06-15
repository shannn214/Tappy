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

        setupButton()

        self.imageView.isUserInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logoutAction(_ sender: Any) {

        let delegate = UIApplication.shared.delegate as? AppDelegate

        delegate?.window?.rootViewController = UIStoryboard.loginStorybaord().instantiateInitialViewController()

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

            guard let point = view.window?.convert(tapPoint, to: self.scrollView) else { return }

            let tapPoint = point.x

            if Int(tapPoint) < Int(self.monster.center.x) {
                self.monster.image = #imageLiteral(resourceName: "left_pink")
            } else {
                self.monster.image = #imageLiteral(resourceName: "right_pink")
            }

            UIView.animate(withDuration: 0.4) {
                self.monster.frame = CGRect(x: point.x,
                                            y: 77 * self.imageView.bounds.height/100,
                                            width: 75, height: 62)
            }
        default:
            break
        }

    }

    func createCharactor() {

        monster = UIImageView()
        monster.image = #imageLiteral(resourceName: "right_pink")
        monster.frame = CGRect(x: 2 * imageView.bounds.width / 100, y: 77 * imageView.bounds.height/100, width: 75, height: 62)
        self.imageView.addSubview(monster)

    }

    func createScrollViewAndMap() {

        guard let url = Bundle.main.path(forResource: "mapppp-01", ofType: ".png") else { return }

        let image = UIImage(contentsOfFile: url)

        imageView = UIImageView(image: image)
        imageView.frame.size.height = SHConstants.screenHeight
        imageView.frame.size.width = SHConstants.mapSizeWidth
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = CGSize(width: imageView.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.autoresizingMask = [.flexibleWidth]
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)

    }

}
