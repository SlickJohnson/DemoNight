//
//  Object+Extensions.swift
//  DemoNight
//
//  Created by Willie Johnson on 09/12/2017.
//  Copyright © 2017 Willie Johnson. All rights reserved.
//

import Foundation
import RealmSwift

// MARK - RealmObject helper methods.
extension Object {
  /**
   Save Object to realm.
 */
  func save() {
    do {
      let realm = try Realm()
      try realm.write {
        realm.add(self)
      }
    } catch let error as NSError {
      fatalError(error.localizedDescription)
    }
  }
}
