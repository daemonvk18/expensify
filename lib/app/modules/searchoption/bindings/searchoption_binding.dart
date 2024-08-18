import 'package:get/get.dart';

import '../controllers/searchoption_controller.dart';

class SearchoptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchoptionController>(
      () => SearchoptionController(),
    );
  }
}
