//
//  ViewController.swift
//  LiveLocationTrackingTest
//
//  Created by Willie Johnson on 11/25/17.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class ViewController: UIViewController {
  /// Handles location tracking
  let locationManager = CLLocationManager()
  /// Handles realm objects
  var realm = try! Realm()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
      locationManager.allowsBackgroundLocationUpdates = true
      locationManager.pausesLocationUpdatesAutomatically = false
      locationManager.startUpdatingLocation()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue: CLLocationCoordinate2D = manager.location!.coordinate

    let position = Position()
    position.latitude = locValue.latitude
    position.longitude = locValue.longitude

    print("\(position)")
  }
}

