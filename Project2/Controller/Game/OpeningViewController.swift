//
//  OpeningViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class OpeningViewController: UIViewController {

    @IBOutlet weak var openingView: UIView!
    @IBOutlet weak var openingTextView: UITextView!
    @IBOutlet weak var openingButton: UIButton!
    
    var firstTouchHandler: (() -> Void)?
//    var secondTouchHandler: (() -> Void)?
//    var thirdTouchHandler: (() -> Void)?
//    var forthTouchHandler: (() -> Void)?
    
    let touchArray = [(() -> Void).self, (() -> Void).self]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        
        openingView.layer.cornerRadius = 20
        
        openingButton.layer.cornerRadius = 15
        
    }
    
    func textTwo() {
        
        openingTextView.text = Constants.openingTwo
        
    }
    
    func textThree() {
        
        openingTextView.text = Constants.openingThree
        
    }
    
    func textFour() {
        
        openingTextView.text = Constants.openingFour
        
    }
    
    func textFive() {
        
        openingTextView.text = Constants.openingFive
        
    }

    @IBAction func openingAction(_ sender: Any) {
        
        
    }
    
}
