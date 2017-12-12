//
//  GlobalVariables.swift
//  DemoNight
//
//  Created by Willie Johnson on 12/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation

/// All variables needed to setup the daaank iOS socket client
struct SocketVariables {
  /// Global instance of the Daaank socket io client.
  static let socket = SocketClient()
  /// Url for the Daaank server.
  static let url = "https://23760fec.ngrok.io/"
  /// Path to the server socket.
  static let path = "/demonight/socket"
  /// Bool to show or hide debug log for socket client.
  static let debug = true
}

