//
//  ViewKeyframeChain.swift
//  Wave
//
//  Created by Khoa Pham on 27/05/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import UIKit

public extension View {

  public final class KeyframeChain: Chainable {

    public var actions: [Action] = []
    public var view: UIView?

    public init() {

    }
  }
}

// MARK: - Configure

extension View.KeyframeChain: ViewConfigurable {

}
