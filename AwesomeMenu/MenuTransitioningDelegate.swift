//
//  MenuTransitioningDelegate.swift
//
//  Created by Matthew Delves on 2/08/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class MenuTransitioningDelegate: NSObject,  UIViewControllerTransitioningDelegate {

  var overlay:UIView?
  
  internal func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
    let presentationController = MenuPresentationController(presentedViewController: presented, presentingViewController: presenting)
    presentationController.overlay = overlay
    return presentationController
  }

  internal func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
    return OverlayPresentTransition()
  }
  
  internal func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
    return OverlayDismissTransition()
  }
}
