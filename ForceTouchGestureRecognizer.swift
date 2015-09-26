//
//  ForceTouchGestureRecognizer.swift
//
//  Created by James Frost on 26/09/2015.
//  Copyright © 2015 James Frost. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

/**
* A simple UIGestureRecognizer subclass that detects 3D touch.
* This is a continuous gesture, so it will report whenever the
* touch's force changes. Once the normalized touch force reaches 
* the force threshold, the gesture will be ended.
*/
public class ForceTouchGestureRecognizer: UIGestureRecognizer {
  
  /// The normalized threshold at which the recognizer should end.
  /// 1.0 means the touch's `force` is equal to its `maximumPossibleForce`.
  var forceThreshold: CGFloat = 1.0
  
  private var maximumForce: CGFloat = 1.0
  private var force: CGFloat = 0.0
  
  /// The current touch force, normalized.
  var normalizedForce: CGFloat {
    return force / maximumForce
  }
  
  public override init(target: AnyObject?, action: Selector) {
    super.init(target: target, action: action)
  }
  
  override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
    super.touchesBegan(touches, withEvent: event)
    state = .Began
  }
  
  override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
    if let touch = touches.first {
      if touch.force != force {
        force = touch.force
        maximumForce = touch.maximumPossibleForce
        
        state = .Changed
      }
  
      if normalizedForce >= forceThreshold {
        state = .Ended
      }
    }
  }

  override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
    super.touchesEnded(touches, withEvent: event)
    state = .Cancelled
  }
}
