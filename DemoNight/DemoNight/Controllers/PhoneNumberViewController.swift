//
//  SignupViewController.swift
//  Daaank
//
//  Created by Willie Johnson on 11/28/17.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit

/// Gets user phone number
class PhoneNumberViewController: UIViewController {
  /// Textfield for user's phone number
  @IBOutlet weak var phoneNumberTextField: SpacedFontTextField!
  /// Delegate that handles page scrolling in UIPageViewControllers

  override func viewDidLoad() {
    super.viewDidLoad()
    addHideKeyboardGesture()
    addDoneButtonOnKeyboard()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

// MARK: - Keyboard
extension PhoneNumberViewController {
  /**
   Adds a simple 'Done' button to the top of the iOS keyboard.
   */
  func addDoneButtonOnKeyboard() {
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 350, height: 20))
    doneToolbar.barStyle = UIBarStyle.blackTranslucent

    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

    doneToolbar.items = [flexSpace, done]
    doneToolbar.sizeToFit()

    phoneNumberTextField.inputAccessoryView = doneToolbar
  }

  /**
   Triggers 'scrollToNextPage' for the SignupPageDelegate
   */
  @objc func doneButtonAction() {
    createUser()
    goToMainView()
  }
}

// MARK: - Helper methods
extension PhoneNumberViewController {
  /// Create a user with given phone number
  func createUser() {
    guard let phoneNumber = phoneNumberTextField.text else { return }

    let user = User()
    user.phoneNumber = phoneNumber
    user.save()
  }

  /// Set ViewController to GameViewController (main screen)
  func goToMainView() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    present(storyboard.instantiateInitialViewController()!, animated: true, completion: nil)
  }
}
