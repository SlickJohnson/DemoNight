//
//  PermissionViewController.swift
//  DemoNight
//
//  Created by Willie Johnson on 12/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit
import CoreLocation

class PermissionViewController: UIViewController {
  @IBOutlet weak var allowAccesButton: CustomizableButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    allowAccesButton.setRadius(to: 4)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - IBActions
  @IBAction func allowAccessAction(_ sender: UIButton) {
    guard let locationManager = LocationSingleton.shared.locationManager else { return }

    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      present(storyboard.instantiateInitialViewController()!, animated: true, completion: nil)
    }
  }
}
