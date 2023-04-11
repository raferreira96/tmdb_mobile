import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/modules/auth/login/login_module.dart';
import 'package:tmdb/app/repositories/user/user_repository.dart';
import 'package:tmdb/app/repositories/user/user_repository_impl.dart';
import 'package:tmdb/app/services/user/user_service.dart';
import 'package:tmdb/app/services/user/user_service_impl.dart';

import 'home/auth_home_page.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(restClient: i(), log: i())),
    Bind.lazySingleton<UserService>((i) => UserServiceImpl(userRepository: i(), localStorage: i(), localSecureStorage: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_,__)=> AuthHomePage(authStore: Modular.get())),
    ModuleRoute('/login', module: LoginModule())
  ];
}
