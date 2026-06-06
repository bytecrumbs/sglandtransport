import Foundation

/// The two primary sections of the home screen, matching the Flutter bottom bar
/// (`main_bottom_app_bar.dart`): Nearby Stops and Favorite Buses.
///
/// Raw values match the legacy `bottomBarIndex` (0 = Nearby, 1 = Favorites) so the
/// persisted selection migrates cleanly from the Flutter app.
enum MainTab: Int, CaseIterable, Identifiable {
    case nearby = 0
    case favorites = 1

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .nearby: "Nearby Stops"
        case .favorites: "Favorite Buses"
        }
    }

    var systemImage: String {
        switch self {
        case .nearby: "location"
        case .favorites: "heart.fill"
        }
    }

    var accessibilityIdentifier: String {
        switch self {
        case .nearby: "tab.nearby"
        case .favorites: "tab.favorites"
        }
    }
}
