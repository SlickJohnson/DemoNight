//
//  PermissionViewController.swift
//  DemoNight
//
//  Created by Willie Johnson on 12/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit

class PermissionViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - IBActions
  @IBAction func allowAccessAction(_ sender: UIButton) {
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      
    }
  }
}
