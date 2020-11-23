/// Handles all the configuration that is passed into the build via command
/// line
class EnvironmentConfig {
  /// Tells the app if it is run for an Integration test
  static const isFlutterDriveRun =
      bool.fromEnvironment('IS_FLUTTER_DRIVE_RUN', defaultValue: false);

  /// Holds the secret key for the LTA Datamart API
  static const ltaDatamallApiKey = String.fromEnvironment(
      'LTA_DATAMALL_API_KEY',
      defaultValue: '<useYourOwnKey>');
}
