import 'package:get/get.dart';

import '../auth_controller.dart';
import '../user_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);

    Get.put<UserController>(UserController(), permanent: true);
  }
}
