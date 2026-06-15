import 'package:get/get.dart';

import 'controllers/tutorial_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.put(SettingsController(), permanent: true);
  }
}
