class AppLogger {
  AppLogger._();

  static const String _tag = '[NikitaApp]';

  static void debug(String msg) {
    print('$_tag [DEBUG] $msg');
  }

  static void info(String msg) {
    print('$_tag [INFO] $msg');
  }

  static void error(String msg, [Object? e]) {
    print('$_tag [ERROR] $msg');
    if (e != null) {
      print('$_tag [ERROR DETAILS] $e');
    }
  }
}
