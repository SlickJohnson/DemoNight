//
//  CustomButton.swift
//  DemoNight
//
//  Created by Willie Johnson on 11/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.layer.cornerRadius = 4
  }
}
