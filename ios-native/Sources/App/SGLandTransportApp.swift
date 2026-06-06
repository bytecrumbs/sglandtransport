import SwiftUI

@main
struct SGLandTransportApp: App {
    init() {
        UITestSupport.prepareIfNeeded()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
