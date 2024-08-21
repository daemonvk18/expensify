import 'package:expensify_app/app/modules/addnew/controllers/addnew_controller.dart';
import 'package:get/get.dart';

class AddcategoryController extends GetxController {
  var categoryName = ''.obs;
  var selectedIcon = ''.obs;
  var isTapped = false.obs;
  final AddnewController addnewController = Get.find<AddnewController>();

  //get the data from the addnew controller
  List<Map<String, String>> get combinedData => [
        ...addnewController.categories,
        ...addnewController.incomecategories,
      ];

  //update the categoryname
  void updateCategoryName(String name) {
    categoryName.value = name;
  }

  //update the image path
  void updateImagePath(String path) {
    selectedIcon.value = path;
    isTapped.value = false;
  }

  //check whether both categoryname and selectedicon
  bool get isformValid => categoryName.isNotEmpty && selectedIcon.isNotEmpty;

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
