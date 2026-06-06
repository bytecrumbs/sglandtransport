import Foundation

/// App-wide configuration sourced from the build (Info.plist values injected from `.xcconfig`).
///
/// Mirrors the Flutter `environment_config.dart` contract: the LTA Datamall API key must be
/// supplied at build time. If it is missing we fail loudly (parity with the Flutter
/// `AssertionError`) rather than making doomed, keyless API calls.
enum AppConfig {
    /// Base URL for the LTA Datamall OData service.
    static let ltaDatamallBaseURL = URL(string: "https://datamall2.mytransport.sg/ltaodataservice")!

    /// The LTA Datamall API key, sent as the `AccountKey` header on every request.
    static var ltaDatamallAPIKey: String {
        guard let key = infoString("LTADatamallAPIKey"), !key.isEmpty else {
            fatalError(
                """
                Missing LTA_DATAMALL_API_KEY. Copy Configs/Secrets.example.xcconfig to \
                Configs/Secrets.local.xcconfig and set your key. See ios-native/README.md.
                """
            )
        }
        return key
    }

    /// Human-facing build name shown on the About screen.
    static var buildName: String {
        infoString("BuildName").flatMap { $0.isEmpty ? nil : $0 } ?? "0.0.0"
    }

    private static func infoString(_ key: String) -> String? {
        Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
}
