//
//  MenuTransitioningDelegate.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 2/08/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class MenuTransitioningDelegate: NSObject,  UIViewControllerTransitioningDelegate {

  internal func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
    return MenuPresentationController(presentedViewController: presented, presentingViewController: presenting)
  }

  internal func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
    return OverlayPresentTransition()
  }
  
  internal func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
    return OverlayDismissTransition()
  }
}
