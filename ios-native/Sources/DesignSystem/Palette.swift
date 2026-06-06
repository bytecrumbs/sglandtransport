import SwiftUI

/// Color palette ported 1:1 from the Flutter app's `lib/src/palette.dart`.
enum Palette {
    /// Dark navy — app bar, primary text, buttons. (`#25304D`)
    static let primary = Color(hex: 0x25304D)
    /// Gray — secondary text, route connectors. (`#969CAE`)
    static let secondary = Color(hex: 0x969CAE)
    /// Red — active tabs, highlights. (`#EF3340`)
    static let accent = Color(hex: 0xEF3340)
    /// Light blue — main background. (`#E2EFF5`)
    static let background = Color(hex: 0xE2EFF5)
    /// White — bottom bar background.
    static let bottomBar = Color.white
}

/// Bus crowding (Load) levels and their colors, ported from `kBusLoadColors`.
///
/// Note: the Flutter app keyed "Limited Standing" as `LDS`, but the LTA API returns `LSD`,
/// so the original silently fell back to the green color. We use the correct `LSD` key here
/// (fixes that bug, per the migration plan).
enum BusLoad: String {
    case seatsAvailable = "SEA"
    case standingAvailable = "SDA"
    case limitedStanding = "LSD"

    /// Semi-transparent underline color (~15% opacity, matching the `0x26` alpha in Flutter).
    var color: Color {
        switch self {
        case .seatsAvailable: Color(hex: 0x009B60).opacity(0.15)
        case .standingAvailable: Color(hex: 0xFA6B00).opacity(0.15)
        case .limitedStanding: Color(hex: 0xFF0000).opacity(0.15)
        }
    }

    var legendLabel: String {
        switch self {
        case .seatsAvailable: "Seats Avail."
        case .standingAvailable: "Standing Avail."
        case .limitedStanding: "Limited Standing"
        }
    }
}

extension Color {
    /// Creates a color from a 24-bit RGB hex value, e.g. `0x25304D`.
    init(hex: UInt32, opacity: Double = 1) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: opacity)
    }
}
