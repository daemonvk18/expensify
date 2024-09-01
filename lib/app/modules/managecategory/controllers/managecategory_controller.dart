import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensify_app/app/modules/managecategory/widgets/categorymodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ManagecategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxList<CategoryModel> combinedCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> expenseCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> incomeCategories = RxList<CategoryModel>();
  String _userId = FirebaseAuth.instance.currentUser!.uid;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadUserCategories();
  }

  Future<void> loadUserCategories() async {
    try {
      // Load expense categories
      QuerySnapshot expenseSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('expenseCategories')
          .get();
      // Loading expense categories
      expenseCategories.value = expenseSnapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();

      // Load income categories
      QuerySnapshot incomeSnapshot = await _firestore
          .collection('users')
          .doc(_userId)
          .collection('incomeCategories')
          .get();
      // Loading income categories
      incomeCategories.value = incomeSnapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();

      // Combining both lists
      combinedCategories.value = [...expenseCategories, ...incomeCategories];
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
    }
  }

  //edit a category name
  Future<void> editCategory(
      String categoryId, String newName, bool isExpense) async {
    try {
      String collectionPath =
          isExpense ? 'expenseCategories' : 'incomeCategories';

      await _firestore
          .collection('users')
          .doc(_userId)
          .collection(collectionPath)
          .doc(categoryId)
          .update({'name': newName});

      // Update in local list (to reflect immediately on the UI)
      CategoryModel? categoryToUpdate = combinedCategories
          .firstWhereOrNull((category) => category.id == categoryId);
      if (categoryToUpdate != null) {
        categoryToUpdate.name = newName;
      }
      Get.snackbar("Success", "Category name updated successfully");
      loadUserCategories();
    } catch (e) {
      Get.snackbar("Error", "Failed to update category name: $e");
    }
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
