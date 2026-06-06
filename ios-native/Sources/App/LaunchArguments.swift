import Foundation

/// Launch-time flags used to put the app into a deterministic state for UI tests
/// (stubbed LTA responses, seeded store, fixed clock). Real runs ignore these.
///
/// See the "UI testing & feature-parity sign-off" section of the migration plan.
enum LaunchArguments {
    /// When present, the app should use bundled fixtures and a seeded store instead of
    /// hitting the live API / real GPS. Wired up further as features land (M2+).
    static let uiTestStubMode = "-uiTestStubMode"

    static var isUITestStubMode: Bool {
        ProcessInfo.processInfo.arguments.contains(uiTestStubMode)
    }
}
