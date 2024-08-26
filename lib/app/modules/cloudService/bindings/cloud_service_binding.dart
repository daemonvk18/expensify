import 'package:get/get.dart';

import '../controllers/cloud_service_controller.dart';

class CloudServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CloudServiceController>(
      () => CloudServiceController(),
    );
  }
}
