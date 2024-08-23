import 'package:get/get.dart';

import '../controllers/managecategory_controller.dart';

class ManagecategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagecategoryController>(
      () => ManagecategoryController(),
    );
  }
}
