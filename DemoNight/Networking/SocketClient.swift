//
//  Networking.swift
//  DemoNight
//
//  Created by Willie Johnson on 10/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import SocketIO

/// Handle communication between server and client.
class SocketClient {
  let manager: SocketManager!
  /// daaank server socket.
  let socket: SocketIOClient!

  /// Server connect event handler.
  let connect: NormalCallback = {data, ack in
    print("Socket connect")
  }

  /// User verified event handler.
  let verifyUser: NormalCallback = {data, ack in
    print("User verified")
  }

  /// Test server event handler.
  let message: NormalCallback = {data, ack in
    print("Message")
  }

  /// Test server event handler.
  let user: NormalCallback = {data, ack in
    print(data)
  }

  /// Initalize SocketManager and setup event handlers.
  init() {
    manager = SocketManager(socketURL: URL(string: SocketVariables.url)!,
                            config:[.path(SocketVariables.path), .log(SocketVariables.debug), .compress])
    socket = manager.defaultSocket

    setupEventHandlers()
    socket.connect()
  }
}

// MARK: - Helper functions
extension SocketClient {
  /**
   Connect all client events.
   */
  func setupEventHandlers() {
    socket.on(clientEvent: .connect, callback: connect)
    socket.on("user", callback: user)
  }

  /**
   Send an event to the server to create a new user.

   - parameter user: A user object created using the inputed phone number.
   */
  func signupUser(phoneNumber: String) {
    socket.emit("phone-number", with: [phoneNumber])
  }
}
