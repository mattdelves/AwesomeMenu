//
//  MenuPresentationController.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 2/08/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class MenuPresentationController: UIPresentationController {

  lazy var dimmingView :UIView = {
    let view = UIView(frame: self.containerView!.bounds)
    view.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)
    view.alpha = 0.0
    return view
    }()
  
  override func presentationTransitionWillBegin() {

    dimmingView.frame = self.containerView.bounds
    dimmingView.alpha = 0.0

    containerView.insertSubview(dimmingView, atIndex: 0)
    
    if let transitionCoordinator = presentedViewController.transitionCoordinator() {
      transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
        self.dimmingView.alpha  = 1.0
        }, completion:nil)
    } else {
      dimmingView.alpha = 1.0
    }
  }
  
  override func dismissalTransitionWillBegin() {

    if let transitionCoordinator = presentedViewController.transitionCoordinator() {
      transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
        self.dimmingView.alpha  = 0.0
        }, completion:nil)
    } else {
      dimmingView.alpha = 0.0
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
    dimmingView.frame = containerView.bounds
    presentedView().frame = frameOfPresentedViewInContainerView()
  }

}
