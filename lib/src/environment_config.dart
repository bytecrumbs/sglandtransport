const ltaDatamallApi = 'http://datamall2.mytransport.sg/ltaodataservice';

/// Handles all the configuration that is passed into the build via command
/// line
class EnvironmentConfig {
  /// Holds the secret key for the LTA Datamart API
  static const ltaDatamallApiKey = String.fromEnvironment(
    'LTA_DATAMALL_API_KEY',
    defaultValue: '<useYourOwnKey>',
  );
  static const buildName =
      String.fromEnvironment('BUILD_NAME', defaultValue: '<0.0.0>');
}
