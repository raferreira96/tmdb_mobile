import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  Environments._();

  static String? param(String paramName) {
    return dotenv.env[paramName];
  }

  static Future<void> loadsEnv() async {
    await dotenv.load(fileName: '.env');
  }
}
