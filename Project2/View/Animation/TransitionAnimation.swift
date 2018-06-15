//
//  TransitionManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/18.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    var dismissCompletion: (() -> Void)?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        let toView = transitionContext.view(forKey: .to)!

        let playerView = presenting ? toView:
            transitionContext.view(forKey: .from)!

        let initialFrame = presenting ? originFrame: playerView.frame

        let finalFrame = presenting ? playerView.frame: originFrame

        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width

        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height

        let scaleTransForm = CGAffineTransform(scaleX: xScaleFactor,
                                                    y: yScaleFactor)

        if presenting {

            playerView.transform = scaleTransForm
            playerView.center = CGPoint(x: initialFrame.midX,
                                        y: initialFrame.midY)
            playerView.clipsToBounds = true

        }

        containerView.addSubview(toView)
        containerView.bringSubview(toFront: playerView)

        UIView.animate(withDuration: duration,
                       delay: 0.8,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.0,
                       animations: {

                            playerView.transform = self.presenting ? CGAffineTransform.identity : scaleTransForm
                            playerView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY) },

                       completion: { (_) in

                            if !self.presenting {
                                self.dismissCompletion?()
                            }
                            transitionContext.completeTransition(true)

        })

    }

}
