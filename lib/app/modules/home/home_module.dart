import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/modules/auth/login/login_controller.dart';
import 'package:tmdb/app/modules/core/movie/movie_core_module.dart';
import 'package:tmdb/app/modules/home/home_controller.dart';
import 'package:tmdb/app/modules/home/home_page.dart';
import 'package:tmdb/app/repositories/user/user_repository.dart';
import 'package:tmdb/app/repositories/user/user_repository_impl.dart';
import 'package:tmdb/app/services/user/user_service.dart';
import 'package:tmdb/app/services/user/user_service_impl.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginController(userService: i(), log: i())),
    Bind.lazySingleton<UserRepository>(
        (i) => UserRepositoryImpl(restClient: i(), log: i())),
    Bind.lazySingleton<UserService>((i) => UserServiceImpl(
        userRepository: i(),
        localStorage: i(),
        localSecureStorage: i())),
    Bind.lazySingleton((i) => HomeController(movieService: i(), userService: i()))
  ];

  @override
  List<Module> get imports => [
    MovieCoreModule()
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const HomePage())
  ];
}
