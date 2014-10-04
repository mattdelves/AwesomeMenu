//
//  OverlayDismissTransition.swift
//  PullToMenu
//
//  Created by Matthew Delves on 26/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class OverlayDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.5
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromVC   = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
    let fromView = fromVC?.view
    
    let containerView = transitionContext.containerView()
    
    let animatingVC   = fromVC
    let animatingView = fromView
    
    var appearedFrame = transitionContext.finalFrameForViewController(animatingVC!)
    var dismissedFrame = appearedFrame
    
    dismissedFrame.origin.x += dismissedFrame.size.width
    
    var initialFrame = appearedFrame
    var finalFrame = dismissedFrame
    
    animatingView?.frame = initialFrame

    UIView.animateWithDuration(
      self.transitionDuration(transitionContext),
      delay: 0,
      usingSpringWithDamping: 300,
      initialSpringVelocity: 5,
      options: UIViewAnimationOptions.AllowUserInteraction | UIViewAnimationOptions.BeginFromCurrentState,
      animations: {
        animatingView!.frame = finalFrame
      },
      completion: { finished in
        fromView?.removeFromSuperview()
        transitionContext.completeTransition(true)
      }
    )
  }
}
