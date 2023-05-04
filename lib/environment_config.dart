const ltaDatamallApi = 'http://datamall2.mytransport.sg/ltaodataservice';
const ltaDatamallApiKeyName = 'LTA_DATAMALL_API_KEY';

/// Handles all the configuration that is passed into the build via command
/// line
class EnvironmentConfig {
  static const buildName =
      String.fromEnvironment('BUILD_NAME', defaultValue: '<0.0.0>');
}
