//
//  ViewController.swift
//  ForceTouchGestureRecognizerDemo
//
//  Created by James Frost on 26/09/2015.
//  Copyright © 2015 James Frost. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var blockView: UIView!
  
  let colors = [ UIColor(red:0.98, green:0.066, blue:0.309, alpha:1),
                 UIColor(red:1, green:0.231, blue:0.188, alpha:1),
                 UIColor(red:1, green:0.584, blue:0, alpha:1),
                 UIColor(red:1, green:0.901, blue:0.125, alpha:1),
                 UIColor(red:0.015, green:0.87, blue:0.443, alpha:1),
                 UIColor(red:0, green:0.96, blue:0.917, alpha:1),
                 UIColor(red:0.352, green:0.784, blue:0.98, alpha:1),
                 UIColor(red:0.125, green:0.58, blue:0.98, alpha:1),
                 UIColor(red:0.47, green:0.478, blue:1, alpha:1)
  ]
  
  var randomColor: UIColor {
    return colors[Int(arc4random_uniform(UInt32(colors.count)))]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let recognizer = ForceTouchGestureRecognizer(target: self, action: "forceGestureRecognizerChanged:")
    recognizer.forceThreshold = 0.8
    blockView.addGestureRecognizer(recognizer)
  }

  func forceGestureRecognizerChanged(sender: ForceTouchGestureRecognizer) {
    switch sender.state {
    case .Changed:
      let inverse = 1 - sender.normalizedForce
      let scaleFactor = 0.5 + (0.5 * inverse)
      
      UIView.animateWithDuration(0.1) {
        self.blockView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
      }
    case .Ended:
      UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [], animations: {
        self.blockView.backgroundColor = self.randomColor
        self.blockView.transform = CGAffineTransformIdentity
        }, completion: nil)
    case .Cancelled:
      UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: [], animations: {
        self.blockView.transform = CGAffineTransformIdentity
        }, completion: nil)
    default: break
    }
  }
}

