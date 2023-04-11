import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/core/ui/extensions/size_screen_extension.dart';
import 'package:tmdb/app/core/ui/widgets/custom_default_button.dart';
import 'package:tmdb/app/core/ui/widgets/custom_textform_field.dart';
import 'package:validatorless/validatorless.dart';

import 'package:tmdb/app/modules/auth/login/login_controller.dart';

part 'widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                    SizedBox(height: 50.h),
                    Center(
                      child: Image.asset('assets/img/logo.png', width: 225.w),
                    ),
                    const SizedBox(height: 50),
                    const _LoginForm(),
                  ]))),
        ));
  }
}
