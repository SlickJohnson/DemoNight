import Foundation
import RealmSwift
import CoreLocation

/// Holds the user's phonenumber and visit data (created at signup).
class User: Object {
  var phoneNumber: String = ""
  var visits = List<Visit>()
}

/// Holds the date of check-in date and user location data (updated every visit).
class Visit: Object {
  /// Date of check-in
  @objc dynamic var date = Date()
  /// Location data of visit
  var positions = List<Position>()
}

/// Holds the position and time of the user (updated every second).
class Position: Object {
  /// Poisition's time stamp.
  @objc dynamic var time = Date()
  /// Position's latitude, defaults to "0.0".
  @objc dynamic var latitude = 0.0
  /// Position's longitude, defaults to "0.0".
  @objc dynamic var longitude = 0.0

  // Convenient CLLocationCoordate2D of the position's latitude and longitude. Not represented in Realm.
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}
