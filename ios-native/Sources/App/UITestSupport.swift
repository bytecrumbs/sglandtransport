import Foundation

/// Resets/seeds app state so UI tests are deterministic and independent of each other
/// and of any state left by a previous launch. No-op outside stub mode.
///
/// Grows as features land (seeded SwiftData store, stubbed favorites, fixed clock).
enum UITestSupport {
    static func prepareIfNeeded() {
        guard LaunchArguments.isUITestStubMode else { return }
        // Start every UI-test launch from a known tab.
        UserDefaults.standard.removeObject(forKey: "bottomBarIndex")
    }
}
