import 'package:get/get.dart';

import '../controllers/addcategory_controller.dart';

class AddcategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddcategoryController>(
      () => AddcategoryController(),
    );
  }
}
