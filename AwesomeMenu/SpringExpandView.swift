//
//  SpringExpandView.swift
//
//  Created by Matthew Delves on 26/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class SpringExpandView: UIView {
  
  var stretchingView:UIView?
  var expanded:Bool?

  required init(coder aDecoder: NSCoder!) {
    super.init(coder: aDecoder!)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Initialization code
    stretchingView = UIView(frame: CGRectZero)
    expanded = false
    addSubview(stretchingView!)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    configureViewsForExpandedState(expanded!, animated: false)
    stretchingView!.layer.cornerRadius = CGRectGetMidX(stretchingView!.bounds)
  }
  
  internal func setExpanded(expanded:Bool, animated:Bool) {
    if (self.expanded != expanded) {
      configureViewsForExpandedState(expanded, animated: animated)
    }
  }
  
  internal func setColor(color:UIColor) {
    stretchingView!.backgroundColor = color
  }
  
  func configureViewsForExpandedState(expanded:Bool, animated:Bool) {
    if (expanded) {
      expandAnimated(animated)
    } else {
      collapseAnimated(animated)
    }
  }
  
  func expandAnimated(animated:Bool) {
    if (animated) {
      performBlockInAnimation(expandBlock)
    } else {
      expandBlock()
    }
  }
  
  func collapseAnimated(animated:Bool) {
    if (animated) {
      performBlockInAnimation(collapseBlock)
    } else {
      collapseBlock()
    }
  }
  
  func performBlockInAnimation(blockToAnimate:() -> ()) {
    UIView.animateWithDuration(
      0.5,
      delay: 0.0,
      usingSpringWithDamping: 0.4,
      initialSpringVelocity: 0.5,
      options: UIViewAnimationOptions.BeginFromCurrentState,
      animations: blockToAnimate,
      completion: nil)
  }
  
  func expandBlock() -> () {
    stretchingView!.frame = frameForExpandedState()
    expanded = true
  }
  
  func collapseBlock() -> () {
    stretchingView!.frame = frameForCollapsedState()
    expanded = false
  }
  
  func frameForCollapsedState() -> CGRect {
    let zero:CGFloat = 0
    return CGRectMake(
      zero,
      CGRectGetMidY(bounds) - CGRectGetWidth(bounds) / 2.0,
      CGRectGetWidth(bounds),
      CGRectGetWidth(bounds))
  }
  
  func frameForExpandedState() -> CGRect {
    let zero:CGFloat = 0
    return CGRectMake(
      CGRectGetWidth(bounds) / 4.0,
      zero,
      CGRectGetWidth(bounds) / 2.0,
      CGRectGetHeight(bounds))
  }
  
  /*
  // Only override drawRect: if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func drawRect(rect: CGRect)
  {
  // Drawing code
  }
  */
  
}
