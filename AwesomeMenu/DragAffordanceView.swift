//
//  DragAffordanceView.swift
//  PullToMenu
//
//  Created by Matthew Delves on 26/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

class DragAffordanceView: UIView {
  
  var progress:CGFloat?
  var springExpandViews:[SpringExpandView]?
  
  required init(coder aDecoder: NSCoder!) {
    super.init(coder: aDecoder!)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Initialization code
    var expandView1:SpringExpandView = SpringExpandView(frame: CGRectZero)
    addSubview(expandView1)
    
    var expandView2:SpringExpandView = SpringExpandView(frame: CGRectZero)
    addSubview(expandView2)
    
    var expandView3:SpringExpandView = SpringExpandView(frame: CGRectZero)
    addSubview(expandView3)
    
    springExpandViews = [expandView1, expandView2, expandView3]
    progress = 0
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let interItemSpace:CGFloat = CGRectGetWidth(bounds) / 3.0
    
    var index:CGFloat = 0
    for springExpandView:SpringExpandView in springExpandViews! {
      springExpandView.frame = CGRectMake(interItemSpace * index, 0, 4, CGRectGetHeight(bounds))
      index++
    }
  }
  
  internal func setProgress(progress:CGFloat) {
    self.progress = progress
    let progressInterval:CGFloat = 1.0 / 3.0
    var index:CGFloat = 0
    
    for springExpandView:SpringExpandView in springExpandViews! {
      let expanded:Bool = ((index * progressInterval) + progressInterval < progress)
      
      if (progress >= 1.0) {
        springExpandView.setColor(UIColor.redColor())
      } else if (expanded) {
        springExpandView.setColor(UIColor.blackColor())
      } else {
        springExpandView.setColor(UIColor.grayColor())
      }
      
      springExpandView.setExpanded(expanded, animated: true)
      index++
    }
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
