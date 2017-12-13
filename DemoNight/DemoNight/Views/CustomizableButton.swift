//
//  CustomizableButton.swift
//  DemoNight
//
//  Created by Willie Johnson on 11/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit

/// A UIButton with methods to help create a custom design.
class CustomizableButton: UIButton {
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: - Button customization methods
extension CustomizableButton {
  /**
   Set the corner radius of the button.

   - parameter radius: Radius size for button corner as a Float.
   */
  func setRadius(to radius: CGFloat) {
    self.layer.cornerRadius = radius
  }

  /**
   Add a drop shadow to the button.

   - parameter:
      - color: UIColor of drop shadow.
      - opacity: Float describing shadow opacity.
      - offset: CGSize for shadow translation.
      - radius: CGFloat of shadow blur size.
      - scale: Bool for shouldRasterize.
   */
  func addDropShadow(color: UIColor, opacity: Float = 0.5, offset: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    self.layer.masksToBounds = false
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOpacity = opacity
    self.layer.shadowOffset = offset
    self.layer.shadowRadius = radius

    self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    self.layer.shouldRasterize = true
    self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
