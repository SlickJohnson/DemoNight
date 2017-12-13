//
//  Location.swift
//  DemoNight
//
//  Created by Willie Johnson on 13/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation

/// Protocol that allows NSObjects to recieve location data.
protocol LocationServiceDelegate: class {
  /**
   Recieves updated location data of user from LocationSingleton.

   - parameter currentLocation: User's current CLLocation.
   */
  func update(_ currentLocation: CLLocation)
}

final class LocationSingleton: NSObject {
  /// Shared instance of LocationSingleton.
  static let shared = LocationSingleton()
  /// CLLocationManager to handle location updates.
  var locationManager: CLLocationManager?
  /// CLLocation to keep track of the user's last known location.
  var lastLocation: CLLocation?
  /// LocationServiceDelegate that will use the location data.
  weak var delegate: LocationServiceDelegate?
  /// Bool that shows whether or not the location services are activated on the shared locationManager instance.
  var isLocationUpdating = false

  override init() {
    super.init()
    self.locationManager = CLLocationManager()
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationSingleton: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }

    lastLocation = location
    updateLocation(currentLocation: location)
  }
}

// MARK: - CLLocationManager convenince methods.
extension LocationSingleton {
  /**
   Turns on locationManager location tracking.
   */
  func startUpdatingLocation() {
    isLocationUpdating = true
    locationManager?.startUpdatingLocation()
  }

  /**
   Turns off locationManager location tracking.
   */
  func stopUpdatingLocation() {
    isLocationUpdating = false
    locationManager?.stopUpdatingLocation()
  }

  /**
   Toggles between updating and not updating location.
   */
  func toggleLocationUpdates() {
    if isLocationUpdating {
      stopUpdatingLocation()
    } else {
      startUpdatingLocation()
    }
  }

  /**
   Setup location manager used to track user location.
   */
  func configureForLiveTracking() {
    guard let locationManager = locationManager else { return }

    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.pausesLocationUpdatesAutomatically = false
  }
}

// MARK: - Helper functions
private extension LocationSingleton {
  /**
   Sends user's current CLLocation to the LocationServiceDelegate.

   - parameter currentLocation: Current CLLocation of user.
   */
  func updateLocation(currentLocation: CLLocation) {
    guard let delegate = self.delegate else { return }

    delegate.update(currentLocation)
  }
}

