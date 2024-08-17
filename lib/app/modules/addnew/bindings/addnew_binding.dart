import 'package:get/get.dart';

import '../controllers/addnew_controller.dart';

class AddnewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddnewController>(
      () => AddnewController(),
    );
  }
}
