//
//  ViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/22.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: #imageLiteral(resourceName: "MapTest"))
        imageView.frame.size.height = UIScreen.main.bounds.height
        imageView.frame.size.width = 2800
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.brown
        scrollView.contentSize = CGSize(width: imageView.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        scrollView.addSubview(imageView)
        view.addSubview(scrollView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
