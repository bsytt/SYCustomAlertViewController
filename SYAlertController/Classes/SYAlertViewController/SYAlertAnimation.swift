//
//  XYAlertAnimation.swift
//  Nongjibang
//
//  Created by qiaoxy on 2019/7/10.
//  Copyright © 2019 qiaoxy. All rights reserved.
//

import UIKit

class SYAlertAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        // 1
        
        if let toVC = transitionContext?.viewController(forKey: .to),toVC.isBeingPresented {
            return 0.3
        }else if let fromVC = transitionContext?.viewController(forKey: .from) ,fromVC.isBeingDismissed{
            return 0.3
        }
        
        return 0.3;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        if let toVC = transitionContext.viewController(forKey: .to) as? SYAlertViewController,toVC.isBeingPresented {
            //2
            containerView.addSubview(toVC.view)
            toVC.view.frame = .init(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
            toVC.backView.alpha = 0
            if let alertView = toVC.alertView {
                let oldTransform = alertView.transform;
                toVC.alertView.transform = oldTransform.scaledBy(x: 0.3, y: 0.3)
                toVC.alertView.center = containerView.center;
                UIView.animate(withDuration: duration, animations: {
                    toVC.backView.alpha = 0.4;
                    toVC.alertView.transform = oldTransform;
                }) { (finished) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }else {
                if let customView = toVC.customView {
                    let oldTransform = customView.transform;
                    toVC.customView?.transform = oldTransform.scaledBy(x: 0.3, y: 0.3)
                    toVC.customView?.center = containerView.center;
                    UIView.animate(withDuration: duration, animations: {
                        toVC.backView.alpha = 0.4
                        toVC.customView?.transform = oldTransform
                    }) { (finished) in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    }
                }
            }
        }else if let fromVC = transitionContext.viewController(forKey: .from) as? SYAlertViewController,fromVC.isBeingDismissed{
            if let alertView = fromVC.alertView {
                let oldTransform = alertView.transform;
                fromVC.customView?.transform = oldTransform
                fromVC.customView?.center = containerView.center;
                UIView.animate(withDuration: duration, animations: {
                    fromVC.customView?.transform = oldTransform.scaledBy(x: 0.3, y: 0.3)
                    fromVC.backView.alpha = 0.0
                }) { (finished) in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }else {
                if let customView = fromVC.customView {
                    let oldTransform = customView.transform;
                    fromVC.customView?.transform = oldTransform
                    fromVC.customView?.center = containerView.center;
                    UIView.animate(withDuration: duration, animations: {
                        fromVC.customView?.transform = oldTransform.scaledBy(x: 0.3, y: 0.3)
                        fromVC.backView.alpha = 0.0
                    }) { (finished) in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                    }
                }
            }

//            UIView.animate(withDuration: duration, animations: {
//                fromVC.view.alpha = 0
//            }) { (finished) in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            }
        }
        
    }
    

}
