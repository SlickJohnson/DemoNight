//
//  SignupViewController.swift
//  DemoNight
//
//  Created by Willie Johnson on 09/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit
import RealmSwift

/// Create's User realm object with phone number and location data
class SignupViewController: UIViewController {
  /// Input for User's phone number
  @IBOutlet weak var phoneNumberTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  /// Done button action on signup screen
  @IBAction func submitNumber(_ sender: UIButton) {
    createUser()
    goToMainView()
  }
}

// MARK: - Helper methods
extension SignupViewController {
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
