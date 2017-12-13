//
//  SocketClient.swift
//  DemoNight
//
//  Created by Willie Johnson on 10/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import SocketIO

/// All variables needed to setup the daaank iOS socket client.
struct SocketVariables {
  /// Url for the Daaank server.
  static let url = "https://adcaa975.ngrok.io/"
  /// Path to the server socket.
  static let path = "/demonight/socket"
  /// Bool to show or hide debug log for socket client.
  static let debug = false
}

/// Handle communication between server and client.
final class SocketClient {
  /// Shared SocketClient instance.
  static let shared = SocketClient()
  /// Handles communication with server.
  let manager: SocketManager!
  /// Daaank server client.
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

  /// Code verification event handler.
  let codeVerification: NormalCallback = {data, act in
    print("USER VERIFIED")
  }

  /// Initalize SocketManager and setup event handlers.
  private init() {
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
    socket.on("verify-user", callback: verifyUser)
  }

  /**
   Send an event to the server to create a new user.

   - parameter user: A user object created using the inputed phone number.
   */
  func signupUser(with phoneNumber: String) {
    socket.emit("phone-number", phoneNumber)
  }

  /**
   Check the verification code typed by user.

   - parameter verificationCode: A string of the verification code.
   */
  func check(_ verificationCode: String) {
    socket.emit("verify-code", verificationCode)
  }
}
