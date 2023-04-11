import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:asuka/asuka.dart';
import 'package:tmdb/app/core/ui/ui_config.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/auth/');
    Modular.setObservers([Asuka.asukaHeroController]);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_,__) => MaterialApp.router(
        title: UiConfig.title,
        debugShowCheckedModeBanner: false,
        theme: UiConfig.theme,
        builder: Asuka.builder,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
