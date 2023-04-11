import 'package:flutter_modular/flutter_modular.dart';

mixin ControllerLifeCycle implements Disposable {
  void onInit([Map<String,dynamic>? params]){}
  void onReady(){}
  @override
  void dispose() {}
}
