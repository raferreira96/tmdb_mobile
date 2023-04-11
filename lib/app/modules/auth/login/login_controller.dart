// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb/app/core/logger/app_logger.dart';
import 'package:tmdb/app/core/ui/widgets/loader.dart';
import 'package:tmdb/app/core/ui/widgets/messages.dart';

import 'package:tmdb/app/services/user/user_service.dart';

import '../../../core/exceptions/failure.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;
  LoginControllerBase(
      {required UserService userService, required AppLogger log})
      : _userService = userService,
        _log = log;

  Future<void> login(String username, String password) async {
    try {
      Loader.show();
      await _userService.login(username, password);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e) {
      final errorMessage = e.message ?? 'Erro ao realizar o login!';
      _log.error(errorMessage);
      Loader.hide();
      Messages.alert(errorMessage);
    }
  }

  Future<void> logout() async {
    try {
      Loader.show();
      await _userService.logout();
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e) {
      final errorMessage = e.message ?? 'Erro ao realizar o logout!';
      _log.error(errorMessage);
      Loader.hide();
      Messages.alert(errorMessage);
    }
  }
}
