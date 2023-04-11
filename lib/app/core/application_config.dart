import 'package:tmdb/app/core/helpers/environments.dart';

class ApplicationConfig {
  Future<void> configureApp() async {
    await _loadEnvs();
  }

  Future<void> _loadEnvs() => Environments.loadsEnv();
}
