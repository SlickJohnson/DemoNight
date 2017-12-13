//
//  CLLocationCoordinate2D+Extensions.swift
//  DemoNight
//
//  Created by Willie Johnson on 12/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Distance calculation.
extension CLLocationCoordinate2D {
  /**
   Get the the distance between to CLLocationCoordinate2Ds
   */
  func distance(to: CLLocationCoordinate2D) -> CLLocationDistance {
    let originLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
    let destinationLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)

    return originLocation.distance(from: destinationLocation)
  }
}
