import Foundation
import RealmSwift
import CoreLocation

class User: Object {
  var visits = List<Visit>()
}

class Visit: Object {
  // New visit created when user checks in
  @objc dynamic var date = Date()
  var positions = List<Position>()
}

class Position: Object {
  // Position created when user location information is updated
  @objc dynamic var time = Date()
  @objc dynamic var latitude = 0.0
  @objc dynamic var longitude = 0.0

  // Realm doesn't support CLLocationCoordinate2D, so use this instead
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
