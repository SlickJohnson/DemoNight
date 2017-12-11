//
//  Geofence.swift
//  DemoNight
//
//  Created by Willie Johnson on 11/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

/// Geofence object used to track user location within a certain area.
struct Geofence {
  // The locations that make up the border of the Geofence.
  let cornerPoints: [CLLocationCoordinate2D]!
  // The UIView that the cornerPoints will be mapped to.
  let view: UIView!
  // Used to convert the CLLocationCoordinate to a CGPoint useable by SCNNodes.
  let xRatio, yRatio: Double!
}

// MARK: - Helper functions
extension Geofence {
  /**
   Converts a CLLocationCoordinate2D into a CGPoint.

   - parameter coord: CLLocationCoord2D of location within the Geofence

   - returns: CGPoint of CLLocationCoordinate2D converted.
   */
  func getCGPoint(for coord: CLLocationCoordinate2D) -> CGPoint {
    return CGPoint(x: coord.latitude * xRatio, y: coord.longitude * yRatio)
  }
}
