class EnvironmentConfig {
  static const is_flutter_drive_run =
      bool.hasEnvironment('IS_FLUTTER_DRIVE_RUN')
          ? String.fromEnvironment('IS_FLUTTER_DRIVE_RUN') == 'TRUE'
          : false;
}
