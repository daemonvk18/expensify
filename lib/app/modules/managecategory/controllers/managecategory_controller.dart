import 'package:expensify_app/app/modules/addnew/controllers/addnew_controller.dart';
import 'package:get/get.dart';

class ManagecategoryController extends GetxController {
  final AddnewController addnewController = Get.find<AddnewController>();
  List<Map<String, dynamic>> get combinedList => [
        ...addnewController.expenseCategories,
        ...addnewController.incomeCategories
      ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
