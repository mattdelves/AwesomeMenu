//
//  ContainerViewController.swift
//  KanjiHelper
//
//  Created by Matthew Delves on 27/07/2014.
//  Copyright (c) 2014 Matthew Delves. All rights reserved.
//

import UIKit

public class ContainerViewController: UIViewController, UIScrollViewDelegate {
  
  public var visibleViewController:UIViewController!
  public var menuViewController:UIViewController!
  var menuTransitioningDelegate:MenuTransitioningDelegate?
  var enclosingScrollView:UIScrollView?
  var menuDragAffordanceView:DragAffordanceView?
  
  override public func viewDidLoad() {
    super.viewDidLoad()

    menuTransitioningDelegate = MenuTransitioningDelegate()
    menuViewController!.transitioningDelegate = menuTransitioningDelegate
    menuViewController!.modalPresentationStyle = .Custom
    
    enclosingScrollView = UIScrollView(frame: view.bounds)
    enclosingScrollView!.alwaysBounceHorizontal = true
    enclosingScrollView!.decelerationRate = UIScrollViewDecelerationRateFast
    enclosingScrollView!.delegate = self
    view.addSubview(enclosingScrollView!)
    
    menuDragAffordanceView = DragAffordanceView(frame: CGRectMake(CGRectGetMaxX(enclosingScrollView!.bounds) + 10.0, CGRectGetMidY(enclosingScrollView!.bounds) - 25.0, 50.0, 50.0))
    enclosingScrollView!.addSubview(menuDragAffordanceView!)
    
    enclosingScrollView!.addSubview(visibleViewController!.view)
  }
  
  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator!) {
    println("will transition to size")
    view.layoutSubviews()
  }
  
  // MARK: - ScrollView Delegate methods
  public func scrollViewDidScroll(scrollView: UIScrollView!) {
    if (scrollView.dragging) {
      menuDragAffordanceView!.setProgress(scrollView.contentOffset.x / CGRectGetWidth(menuDragAffordanceView!.bounds))
    }
  }
  
  public func scrollViewDidEndDragging(scrollView: UIScrollView!, willDecelerate decelerate: Bool) {
    if (menuDragAffordanceView!.progress >= 1.0) {
      presentViewController(menuViewController, animated: true, completion: nil)
    } else {
      menuDragAffordanceView!.setProgress(0)
    }
  }

}
