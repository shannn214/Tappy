//
//  TransitionManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/18.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = transitionContext.view(forKey: .from)!
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = transitionContext.view(forKey: .to)!
        
        let container = transitionContext.containerView
        container.addSubview(fromView)

        let duration = self.transitionDuration(using: transitionContext)
        
        if (toVC?.isBeingPresented)! {
            
            container.addSubview(toView)
            
            let toViewWidth = container.frame.width
            let toViewHeight = container.frame.height
            toView.center = container.center
            toView.bounds = CGRect(x: 0, y: 0, width: toViewWidth, height: toViewHeight)
            
        }
        
    }

   

}

extension TransitionAnimation: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}
