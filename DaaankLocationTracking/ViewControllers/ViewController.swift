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
  let locationManager = CLLocationManager()
  var realm = try! Realm()
  let user = User()
  
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

    let visit = Visit() // TODO: Move to user check-in flow

    user.visits.append(visit) 
  
    try! realm.write {
      realm.add(user) // TODO: Move to user signup flow
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
    try! realm.write {
      user.visits.last?.positions.append(position)
    }
  }
}

