import XCTest

/// Smoke test for the M1 skeleton: the app launches under stub mode and the
/// shell chrome (tabs, drawer, search) is present and switchable.
///
/// Feature-specific UI tests with manual parity sign-off are added from M5 onward.
final class SmokeUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-uiTestStubMode"]
        app.launch()
    }

    func testLaunchesToNearbyTab() throws {
        XCTAssertTrue(app.staticTexts["screen.nearby"].waitForExistence(timeout: 10))
    }

    func testSwitchToFavoritesTab() throws {
        app.buttons["tab.favorites"].tap()
        XCTAssertTrue(app.staticTexts["screen.favorites"].waitForExistence(timeout: 5))
    }

    func testOpensDrawer() throws {
        app.buttons["nav.drawer"].tap()
        XCTAssertTrue(app.buttons["drawer.about"].waitForExistence(timeout: 5))
    }

    func testOpensSearch() throws {
        app.buttons["nav.search"].tap()
        XCTAssertTrue(app.staticTexts["screen.search"].waitForExistence(timeout: 5))
    }
}
