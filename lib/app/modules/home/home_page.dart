import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tmdb/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:tmdb/app/core/ui/extensions/size_screen_extension.dart';
import 'package:tmdb/app/core/ui/extensions/theme_extension.dart';
import 'package:tmdb/app/core/ui/widgets/custom_default_button.dart';
import 'package:tmdb/app/models/movie_model.dart';
import 'package:tmdb/app/modules/home/home_controller.dart';
import 'package:tmdb/app/modules/home/widgets/home_appbar.dart';
part 'widgets/home_title.dart';
part 'widgets/home_movie_tab.dart';
part 'widgets/page_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              HomeAppBar(controller),
              const SliverToBoxAdapter(
                child: _HomeTitle(),
              )
            ];
          },
          body: _HomeMovieTab(homeController: controller),
        ),
        // bottomNavigationBar: controller.hasMore? CustomDefaultButton(
        //     label: 'Carregar mais',
        //     onPressed: () {
        //       controller.moreLoading();
        //     }) : CustomDefaultButton(label: 'Não há mais Filmes para Carregar', onPressed: (){})
        bottomNavigationBar: PageButtons(homeController: controller)
        // child: CustomDefaultButton(label: 'Sair', onPressed: () async {
        //   await controller.logout();
        // }),
        );
  }
}
