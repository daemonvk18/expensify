import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AddcategoryController extends GetxController {
  var categoryName = ''.obs;
  var selectedIcon = ''.obs;
  var isexpense = true.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // //get the data from the addnew controller
  // List<Map<String, dynamic>> get combinedData => [
  //       ...addnewController.expenseCategories,
  //       ...addnewController.incomeCategories,
  //     ];

  //load the new categories from the storage
  Future<List<String>> loadAllCategoryLogo() async {
    try {
      final expenseLogos =
          await loadLogosFromStorage('icons/icons/newexpenseCategory');
      final incomeLogos =
          await loadLogosFromStorage('icons/icons/newincomeCategory');

      return [...expenseLogos, ...incomeLogos];
    } catch (e) {
      Get.snackbar("Error", "Failed to load logos: $e");
      return [];
    }
  }

  //load from storage function(helper function)
  Future<List<String>> loadLogosFromStorage(String folderPath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(folderPath);
      final ListResult result = await storageRef.listAll();

      List<String> imageUrls = [];
      for (var ref in result.items) {
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      }
      return imageUrls;
    } catch (e) {
      Get.snackbar("Error", "Failed to load logos: $e");
      return [];
    }
  }

  //adding the category to the users collection
  Future<void> addnewCategory(String categoryName, String logoUrl) async {
    try {
      final collection =
          isexpense == true ? 'expenseCategories' : 'incomeCategories';
      final usercollection =
          _firestore.collection('users').doc(userId).collection(collection);

      await usercollection.add({'name': categoryName, 'iconUrl': logoUrl});
      Get.snackbar("Success", "Category added successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to add category: $e");
    }
  }

  //update the categoryname
  void updateCategoryName(String name) {
    categoryName.value = name;
  }

  //update the image path
  void updateImagePath(String path) {
    selectedIcon.value = path;
  }

  //check whether both categoryname and selectedicon
  bool get isformValid => categoryName.isNotEmpty && selectedIcon.isNotEmpty;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadAllCategoryLogo();
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
