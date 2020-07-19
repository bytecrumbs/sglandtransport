class EnvironmentConfig {
  static const is_flutter_drive_run =
      String.fromEnvironment('IS_FLUTTER_DRIVE_RUN', defaultValue: 'false') ==
          'newValue';
}
