import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:tmdb/app/core/local_storage/local_storage.dart';
import 'package:tmdb/app/core/local_storage/shared_preferences/shared_preferences_local_storage_impl.dart';
import 'package:tmdb/app/core/logger/app_logger.dart';
import 'package:tmdb/app/core/logger/logger_app_logger_impl.dart';
import 'package:tmdb/app/core/rest/dio/dio_rest_client.dart';
import 'package:tmdb/app/core/rest/rest_client.dart';
import 'package:tmdb/app/modules/core/auth/auth_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthStore(localStorage: i()), export: true),
    Bind.lazySingleton<RestClient>((i) => DioRestClient(localStorage: i(), localSecureStorage: i(), authStore: i(), log: i()), export: true),
    Bind.lazySingleton<AppLogger>((i) => LoggerAppLoggerImpl(), export: true),
    Bind.lazySingleton<LocalStorage>((i) => SharedPreferencesLocalStorageImpl(), export: true),
    Bind.lazySingleton<LocalSecureStorage>((i) => FlutterSecureStorageLocalStorageImpl(), export: true)
  ];
}
