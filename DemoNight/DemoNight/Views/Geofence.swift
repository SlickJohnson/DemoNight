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
    let distance = cornerPoints[0].distance(to: cornerPoints[1])
    print("Width: \(distance)")
    return distance
  }
  // Width of the Geofence
  var height: CLLocationDegrees {
    let distance = cornerPoints[1].distance(to: cornerPoints[3])
    print("Height: \(distance)")
    return distance
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
  init(cornerPoints: [CLLocationCoordinate2D], sceneSize: CGSize) {
    self.init(cornerPoints: cornerPoints, xRatio: nil, yRatio: nil)
    setupCGPointRatios(to: sceneSize)
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
    return CGPoint(x: coord.latitude * xRatio, y: coord.longitude * yRatio)
  }

  /**
   Setup the ratios to properly convert the user's CLLocationCoordinate2D into a useable CGPoint.
   */
  mutating func setupCGPointRatios(to sceneSize: CGSize) {
    xRatio = width / Double(sceneSize.width)
    yRatio = height / Double(sceneSize.height)
  }
}

