import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tmdb/app/core/life_cycle/controller_life_cycle.dart';

abstract class PageLifeCycleState<C extends ControllerLifeCycle,
    P extends StatefulWidget> extends State<P> {
  final controller = Modular.get<C>();
  Map<String, dynamic>? get params => null;

  @override
  void initState() {
    super.initState();
    controller.onInit(params);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.onReady());
  }
}
