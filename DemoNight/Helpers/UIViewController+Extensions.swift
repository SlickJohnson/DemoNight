//
//  UIViewController+Extensions.swift
//  Daaank
//
//  Created by Willie Johnson on 12/6/17.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  /**
   Add tap gesture to ViewController's view to trigger keyboard dismissing.
   */
  func addHideKeyboardGesture() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  /**
   Dismisses keyboard by calling the view's endEditing method
   */
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  /**
   Dismiss current ViewController
   */
  @objc func cancelButtonAction() {
    navigationController?.popViewController(animated: true)
  }
}
