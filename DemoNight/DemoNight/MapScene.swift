//
//  MapScene.swift
//  DemoNight
//
//  Created by Willie Johnson on 09/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreLocation
import MapKit

class MapScene: SKScene {
  /// SKSpriteNode just for fun :)
  private var daaankFace: SKSpriteNode?
  /// SKSpriteNode that represents the daaank booth on the map.
  private var daaankBooth: SKSpriteNode?

  var mapView: MKMapView!
  var geoFence: Geofence!

  /// Shared instance of LocationSingleton.
  var locationSingleton: LocationSingleton!

  override func didMove(to view: SKView) {
    setupLocationServices()
    setupEasterEgg()
    setupMapNodes()
    setupGeofence()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { touchDown(atPoint: t.location(in: self)) }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { touchMoved(toPoint: t.location(in: self)) }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { touchUp(atPoint: t.location(in: self)) }
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { touchUp(atPoint: t.location(in: self)) }
  }
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
}

// MARK: - UITouch Events
extension MapScene {
  func touchDown(atPoint pos : CGPoint) {
    if let n = daaankFace?.copy() as! SKSpriteNode? {
      n.position = pos

      addChild(n)
    }
  }

  func touchMoved(toPoint pos : CGPoint) {
    if let n = daaankFace?.copy() as! SKSpriteNode? {
      n.position = pos

      addChild(n)
    }
  }

  func touchUp(atPoint pos : CGPoint) {
    if let n = daaankFace?.copy() as! SKSpriteNode? {
      n.position = pos

      addChild(n)
    }
  }

}

// MARK: - Helper methods
private extension MapScene {
  /**
   Setup the required nodes for the map.
   */
  func setupMapNodes() {
    daaankBooth = SKSpriteNode(imageNamed: "daaank-booth-legend-icon")

    // TODO: Request booth location.
    daaankBooth?.position = CGPoint(x: 67, y: 64)
  }
  /**
   Creates a fun little touch responsive spinny daaank icon.
   */
  func setupEasterEgg() {
    daaankFace = SKSpriteNode(imageNamed: "daaank-tiny-face")

    if let daaankFace = daaankFace {
      daaankFace.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
      daaankFace.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                        SKAction.fadeOut(withDuration: 0.5),
                                        SKAction.removeFromParent()]))
    }
  }

  /**
   Setup Geofence to handle user location information.
   */
  func setupGeofence() {
    let cornerPoints = { () -> [CLLocationCoordinate2D] in
      let topLeftCorner = CLLocationCoordinate2D(latitude: 37.7733989339674, longitude: -122.417796319465)
      let topRightCorner = CLLocationCoordinate2D(latitude: 37.773298895953, longitude: -122.417796319465)
      let bottomLeftCorner = CLLocationCoordinate2D(latitude: 37.7733989339674, longitude: -122.417789531023)
      let bottomRightCorner = CLLocationCoordinate2D(latitude: 37.773298895953, longitude: -122.417789531023)
      
      return [topLeftCorner, topRightCorner, bottomLeftCorner, bottomRightCorner]
    }()
    
    geoFence = Geofence(cornerPoints: cornerPoints, sceneSize: size)
  }

  /**
   Uses the LocationSingleton to setup the CLLocationManager for live tracking.
  */
  func setupLocationServices() {
    locationSingleton = LocationSingleton.shared
    locationSingleton.delegate = self
    locationSingleton.configureForLiveTracking()
  }
}

// MARK: - CLLocationManagerDelegate
extension MapScene: LocationServiceDelegate {
  func update(_ currentLocation: CLLocation) {
    let locationCoord: CLLocationCoordinate2D = currentLocation.coordinate

    let position = Position()
    position.latitude = locationCoord.latitude
    position.longitude = locationCoord.longitude

    if let daaankFace = daaankFace?.copy() as! SKSpriteNode? {
      if let nodePosition = geoFence.getCGPoint(for: position.coordinate) {
        daaankFace.position = nodePosition
        addChild(daaankFace)
      }
    }
  }
}
