//
//  MenuPresentationController.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 2/08/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class MenuPresentationController: UIPresentationController {

  public var overlay:UIView

  override func presentationTransitionWillBegin() {

    overlay.frame = self.containerView.bounds
    overlay.alpha = 0.0

    containerView.insertSubview(overlay, atIndex: 0)
    
    if let transitionCoordinator = presentedViewController.transitionCoordinator() {
      transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
        self.overlay.alpha  = 1.0
        }, completion:nil)
    } else {
      overlay.alpha = 1.0
    }
  }
  
  override func dismissalTransitionWillBegin() {

    if let transitionCoordinator = presentedViewController.transitionCoordinator() {
      transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
        self.overlay.alpha  = 0.0
        }, completion:nil)
    } else {
      overlay.alpha = 0.0
    }
  }
  
  override func sizeForChildContentContainer(container: UIContentContainer!, withParentContainerSize parentSize: CGSize) -> CGSize
  {
    return CGSizeMake(parentSize.width / 3.0, parentSize.height)
  }
  
  override func frameOfPresentedViewInContainerView() -> CGRect {
    var presentedViewFrame = CGRectZero
    var containerBounds = containerView.bounds
    
    presentedViewFrame.size = sizeForChildContentContainer(presentedViewController as UIContentContainer, withParentContainerSize: containerBounds.size)
    
    presentedViewFrame.origin.x = containerBounds.size.width - presentedViewFrame.size.width
    
    return presentedViewFrame
  }
  
  override func containerViewWillLayoutSubviews() {
    overlay.frame = containerView.bounds
    presentedView().frame = frameOfPresentedViewInContainerView()
  }

}
