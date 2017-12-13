//
//  RealtimeLocationViewController.swift
//  DemoNight
//
//  Created by Willie Johnson on 09/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class RealtimeLocationViewController: UIViewController {
  /// SKView for the location tracking view.
  @IBOutlet weak var gameSceneView: SKView!

  @IBOutlet weak var toggleLocationTrackingButton: CustomizableButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // MARK: - UISetup
    gameSceneView.layer.borderWidth = 1
    gameSceneView.layer.borderColor = UIColor.black.cgColor

    toggleLocationTrackingButton.addDropShadow(color: .black, opacity: 0.09, offset: CGSize(width: 0, height: -2), radius: 28, scale: true)
    
    loadGameScene()
    
  }

  override var shouldAutorotate: Bool {
    return true
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }

  /// Turns on/off user location tracking.
  @IBAction func toggleLocationTracking(_ sender: Any) {

  }
}

// MARK: - Helper methods
extension RealtimeLocationViewController {
  /**
   Load the scene where the user location tracking will be displayed.
   */
  func loadGameScene() {
    // Load the SKScene from 'GameScene.sks'
    if let scene = SKScene(fileNamed: "GameScene") {
      // Set the scale mode to scale to fit the window
      scene.scaleMode = .aspectFill

      // Present the scene
      gameSceneView.presentScene(scene)

      gameSceneView.ignoresSiblingOrder = true

      gameSceneView.showsFPS = true
      gameSceneView.showsNodeCount = true
    }
  }
}
