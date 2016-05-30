//
//  LayerCompoundAction.swift
//  Wave
//
//  Created by Khoa Pham on 29/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import UIKit

public extension Layer {

  public final class CompoundAction: LayerConfigurable {

    public var layer: CALayer?
    public var animations: [CAAnimation] = []

    public init() {

    }
  }
}

extension Layer.CompoundAction: Action {

  public func run(nextActions: [Action]) {
    CATransaction.begin()

    CATransaction.setCompletionBlock {
      Wave.run(nextActions)
    }

    animations.forEach {
      self.layer?.addAnimation($0, forKey: "")
    }

    CATransaction.commit()
  }
}

// MARK: - Configure

extension Chain where A: Layer.CompoundAction {

  public func add<T: LayerAnimationConfigurable>(chains: [Chain<T>]) -> Chain {
    return configure { (action: Layer.CompoundAction) in
      chains.forEach { chain in
        chain.actions.forEach { a in
          if let a = a as? LayerAnimationConfigurable {
            action.animations.append(a.animation)
          }
        }
      }
    }
  }

  public func add<T: LayerAnimationConfigurable>(chain: Chain<T>) -> Chain {
    return add([chain])
  }
}

// MARK: - Animate

extension Chain where A: Layer.CompoundAction {

  public func morph() -> Chain {
    let x = Chain<Layer.KeyframeAction>()
      .newAction()
      .keyPath("transform.scale.x")
      .values([1, 1.3, 0.7, 1.3, 1])
      .keyTimes([0, 0.2, 0.4, 0.6, 0.8, 1])

    let y = Chain<Layer.KeyframeAction>()
      .newAction()
      .keyPath("transform.scale.x")
      .values([1, 1.3, 0.7, 1.3, 1])
      .keyTimes([0, 0.2, 0.4, 0.6, 0.8, 1])

    return newAction()
      .add([x, y])
  }

  public func squeeze() -> Chain {
    let x = Chain<Layer.KeyframeAction>()
      .newAction()
      .keyPath("transform.scale.x")
      .values([1, 1.5, 0.5, 1.5, 1])
      .keyTimes([0, 0.2, 0.4, 0.6, 0.8, 1])

    let y = Chain<Layer.KeyframeAction>()
      .newAction()
      .keyPath("transform.scale.x")
      .values([1, 0.5, 1, 0.5, 1])
      .keyTimes([0, 0.2, 0.4, 0.6, 0.8, 1])

    return newAction()
      .add([x, y])
  }

  public func wobble() -> Chain {
    let rotate = Chain<Layer.KeyframeAction>()
      .newAction()
      .keyPath("transform.rotation")
      .values([0, 0.3, -0.3, 0.3, 0])
      .keyTimes([0, 0.2, 0.4, 0.6, 0.8, 1])

    let x = Chain<Layer.KeyframeAction>()
      .newAction()
      .keyPath("position.x")
      .values([0, 30, -30, 30, 0])
      .keyTimes([0, 0.2, 0.4, 0.6, 0.8, 1])

    return newAction()
      .add([rotate, x])
  }
}
