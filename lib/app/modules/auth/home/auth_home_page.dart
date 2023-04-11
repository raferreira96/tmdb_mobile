import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tmdb/app/core/ui/extensions/size_screen_extension.dart';
import 'package:tmdb/app/core/ui/extensions/theme_extension.dart';
import 'package:tmdb/app/models/user_model.dart';
import 'package:tmdb/app/modules/core/auth/auth_store.dart';

class AuthHomePage extends StatefulWidget {
  final AuthStore _authStore;

  const AuthHomePage({Key? key, required AuthStore authStore})
      : _authStore = authStore,
        super(key: key);

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  void initState() {
    super.initState();
    reaction<UserModel?>((_) => widget._authStore.userLogged, (userLogger) {
      if (userLogger != null && userLogger.username.isNotEmpty) {
        Modular.to.navigate('/home/');
      } else {
        Modular.to.navigate('/auth/login/');
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._authStore.loadUserLogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      body: Center(
          child: Image.asset(
        'assets/img/logo.png',
        width: 300.w,
        fit: BoxFit.contain,
      )),
    );
  }
}
