//
//  Networking.swift
//  DemoNight
//
//  Created by Willie Johnson on 10/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import SocketIO

class Client {
  let manager: SocketManager!
  let socket: SocketIOClient!

  /// Socket connectionq
  let socketConnect: NormalCallback = {data, ack in
    print("Socket connect")
  }

  init() {
    manager = SocketManager(socketURL: URL(string: "daaank.io")!, config: [.log(true), .compress])
    socket = manager.defaultSocket

    connectSockets()
  }
}

// MARK: - Helper functions
extension Client {
  func connectSockets() {
    socket.on(clientEvent: .connect, callback: socketConnect)
  }
}
