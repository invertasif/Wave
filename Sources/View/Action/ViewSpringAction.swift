//
//  ViewSpringAction.swift
//  Wave
//
//  Created by Khoa Pham on 27/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import UIKit

public extension View {

  public struct SpringAction {

    let animation = View.SpringAnimation()
  }
}

extension View.SpringAction: Action {

  public func run(nextActions: [Action]) {
    UIView.animateWithDuration(animation.duration, delay: animation.delay,
                               usingSpringWithDamping: animation.damping, initialSpringVelocity: animation.velocity,
                               options: animation.options, animations:
      {
        if let replay = self.animation.replay {
          UIView.setAnimationRepeatCount(Float(replay))
        }

        self.animation.block?()
      }, completion: { _ in
        Wave.run(nextActions)
    })
  }
}