class EnvironmentConfig {
  static const isFlutterDriveRun =
      bool.fromEnvironment('IS_FLUTTER_DRIVE_RUN', defaultValue: false);

  static const ltaDatamallApiKey = String.fromEnvironment(
      'LTA_DATAMALL_API_KEY',
      defaultValue: '<useYourOwnKey>');
}
