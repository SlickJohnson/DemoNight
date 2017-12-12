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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addHideKeyboardGesture()
    phoneNumberTextField.doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
    phoneNumberTextField.addDoneButtonOnKeyboard()
    phoneNumberTextField.delegate = self
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
   Triggers 'scrollToNextPage' for the SignupPageDelegate.
   */
  @objc func doneButtonAction() {
    createUser()
    goToMainView()
  }
}

// MARK: - Helper methods
extension PhoneNumberViewController {
  /// Create a user with given phone number.
  func createUser() {
    guard let phoneNumber = phoneNumberTextField.text else { return }

    let user = User()
    user.phoneNumber = phoneNumber
    user.save()

    socketClient.signupUser(phoneNumber: phoneNumber)
  }

  /// Set ViewController to GameViewController (main screen).
  @objc func goToMainView() {
    let storyboard = UIStoryboard(name: "OnBoarding", bundle: nil)
    present(storyboard.instantiateViewController(withIdentifier: "VerificationViewController"), animated: true, completion: nil)
  }
}

// MARK: - UITextFieldDelegate
extension PhoneNumberViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
    let currentCharacterCount = textField.text?.count ?? 0
    if (range.length + range.location > currentCharacterCount){
      return false
    }
    let newLength = currentCharacterCount + string.count - range.length
    return newLength <= 25
  }
}
