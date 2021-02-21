/// Class to store all global constant values
class Constants {
  /// The key that is stored in the local storage for the favorite bus stops
  static const String favoriteBusStopsKey = 'favouriteBusStopsKey';

  /// Indicates the current version number of the app. This should be the same
  /// as defined in the pubspec.yaml file
  static const String currentVersion = '1.5.0';

  /// Used to read if the user's last selection in Bus section was either
  /// "Nearby" or "Favorites"
  static const String bottomBarIndexKey = 'bottomBarIndex';
}
