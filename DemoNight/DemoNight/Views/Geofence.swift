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
  // Used to convert the CLLocationCoordinate to a CGPoint useable by SCNNodes.
  var xRatio, yRatio: Double?
  // Length of the Geofence
  var width: CLLocationDegrees {
    print(cornerPoints[0].latitude - cornerPoints[1].latitude)
    return cornerPoints[0].latitude - cornerPoints[1].latitude
  }
  // Width of the Geofence
  var height: CLLocationDegrees {
    print(cornerPoints[1].longitude - cornerPoints[3].longitude)
    return cornerPoints[1].longitude - cornerPoints[3].longitude
  }
}

// MARK: - Custom init.
extension Geofence {
  /**
   Initialize Geofence with cornerpoints and an UIView.

   - parameters:
   - cornerPoints: A list of CLLocationCoordinate2D's that indicate the border of the Geofence to be created.
   - view: The view all converstions will be based from.
   */
  init(cornerPoints: [CLLocationCoordinate2D], view: UIView) {
    self.init(cornerPoints: cornerPoints, xRatio: nil, yRatio: nil)
    setupCGPointRatios(to: view)
  }
}

// MARK: - CGPoint functions
extension Geofence {
  /**
   Convert a CLLocationCoordinate2D into a CGPoint.

   - parameter coord: CLLocationCoord2D of location within the Geofence.

   - returns: CGPoint of CLLocationCoordinate2D converted.
   */
  func getCGPoint(for coord: CLLocationCoordinate2D) -> CGPoint? {
    guard let xRatio = xRatio, let yRatio = yRatio else { return nil}
    print(xRatio, yRatio)
    return CGPoint(x: coord.latitude / xRatio, y: coord.longitude / yRatio)
  }

  /**
   Setup the ratios to properly convert the user's CLLocationCoordinate2D into a useable CGPoint.
   */
  mutating func setupCGPointRatios(to view: UIView) {
    xRatio = Double(view.frame.size.width/2) / width
    yRatio = Double(view.frame.size.height/2) / height
  }
}

