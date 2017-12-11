//
//  GameScene.swift
//  DemoNight
//
//  Created by Willie Johnson on 09/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreLocation
import MapKit

class GameScene: SKScene {
  private var label: SKLabelNode?
  private var spinnyNode: SKShapeNode?

  var locationManager = CLLocationManager()
  var mapView: MKMapView!

  override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
    self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
    if let label = self.label {
      label.alpha = 0.0
      label.run(SKAction.fadeIn(withDuration: 2.0))
    }

    // Create shape node to use during mouse interaction
    let w = (self.size.width + self.size.height) * 0.05
    self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)

    if let spinnyNode = self.spinnyNode {
      spinnyNode.lineWidth = 2.5

      spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
      spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                        SKAction.fadeOut(withDuration: 0.5),
                                        SKAction.removeFromParent()]))
    }

    mapView = MKMapView()
    mapView.alpha = 0.2

//    let userCoords = locationManager.location?.coordinate
//
//    let latDelta: CLLocationDegrees = 5
//
//    let lonDelta: CLLocationDegrees = 5
//
//    let span = MKCoordinateSpanMake(latDelta, lonDelta)
//
//    let location = CLLocationCoordinate2DMake((userCoords?.latitude)!, (userCoords?.longitude)!)
//
//    let region = MKCoordinateRegionMake(location, span)

//    mapView.setRegion(region, animated: true)
    mapView.showsUserLocation = true
//    mapView.isScrollEnabled = false

    mapView.frame = CGRect(
        x: 0,
        y: 0,
        width: (self.view?.frame.size.width)!,
        height: (self.view?.frame.size.height)!)

    view.addSubview(mapView)

    setupLocationManager()
  }

  func touchDown(atPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      n.position = pos
      n.strokeColor = SKColor.green
      self.addChild(n)
    }
  }

  func touchMoved(toPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      n.position = pos
      n.strokeColor = SKColor.blue
      self.addChild(n)
    }
  }

  func touchUp(atPoint pos : CGPoint) {
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      n.position = pos
      n.strokeColor = SKColor.red
      self.addChild(n)
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let label = self.label {
      label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
    }

    for t in touches { self.touchDown(atPoint: t.location(in: self)) }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches { self.touchUp(atPoint: t.location(in: self)) }
  }

  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
}

// MARK: - Helper methods
private extension GameScene {
  func setupLocationManager() {
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
}

// MARK: - CLLocationManagerDelegate
extension GameScene: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue: CLLocationCoordinate2D = manager.location!.coordinate

    let position = Position()
    position.latitude = locValue.latitude
    position.longitude = locValue.longitude
    print(position)
    if let n = self.spinnyNode?.copy() as! SKShapeNode? {
      let nodePosition = mapView.convert(position.coordinate, toPointTo: view!)
      print(nodePosition)

      n.position = nodePosition
      n.strokeColor = SKColor.green
      self.addChild(n)
    }
  }
}
