//
//  GlobalVariables.swift
//  DemoNight
//
//  Created by Willie Johnson on 12/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import CoreLocation

/// Static instances shared throughtout the scope of the app.
struct GlobalInstances {
  /// Shared SocketClient instance.
  static let socketClient = SocketClient()
  /// Shared CLLocationManager instance.
  static let locationManager = CLLocationManager()
}

/// All variables needed to setup the daaank iOS socket client.
struct SocketVariables {
  /// Url for the Daaank server.
  static let url = "https://23760fec.ngrok.io/"
  /// Path to the server socket.
  static let path = "/demonight/socket"
  /// Bool to show or hide debug log for socket client.
  static let debug = true
}
