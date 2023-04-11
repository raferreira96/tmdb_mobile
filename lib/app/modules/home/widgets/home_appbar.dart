import 'package:flutter/material.dart';
import 'package:tmdb/app/core/ui/extensions/size_screen_extension.dart';
import 'package:tmdb/app/modules/home/home_controller.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar(HomeController controller, {super.key})
      : super(
            expandedHeight: 75,
            collapsedHeight: 75,
            elevation: 0,
            flexibleSpace: _TmdbAppBar(homeController: controller),
            pinned: true);
}

class _TmdbAppBar extends StatelessWidget {
  final HomeController homeController;
  const _TmdbAppBar({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Image.asset('assets/img/logo.png', width: 150.w),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Sair'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Deseja realmente sair do App?')
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Não')),
                            TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await homeController.logout();
                                },
                                child: const Text('Sim'))
                          ]);
                    });
              },
              icon: const Icon(Icons.logout))
        ]);
  }
}
