//
//  VerificationViewController.swift
//  DemoNight
//
//  Created by Willie Johnson on 11/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit

/// Phone number verification step.
class VerificationViewController: UIViewController {
  @IBOutlet weak var verificationCodeTextField: SpacedFontTextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    addHideKeyboardGesture()
    verificationCodeTextField.doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
    verificationCodeTextField.addDoneButtonOnKeyboard()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Button actions
extension VerificationViewController {
  @objc func doneButtonAction() {
    let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    present(storyboard.instantiateViewController(withIdentifier: "PermissionViewController"), animated: true, completion: nil)
  }
}
