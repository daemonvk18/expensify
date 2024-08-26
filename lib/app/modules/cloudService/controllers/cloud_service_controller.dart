import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensify_app/app/modules/cloudService/models/categorumodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class CloudServiceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var expenseCategories = <Category>[].obs;
  var incomeCategories = <Category>[].obs;

  Future<void> loadUserCategories() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    //load expense categories
    var expensecategorysnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('expensecategories')
        .get();
    for (var doc in expensecategorysnapshot.docs) {
      var category = Category.fromFirestore(doc);
      String downloadUrl =
          await _storage.ref(category.logoPath).getDownloadURL();
      expenseCategories
          .add(Category(name: category.name, logoPath: downloadUrl));
    }

    // Load Income Categories
    var incomeCategoriesSnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('incomeCategories')
        .get();
    for (var doc in incomeCategoriesSnapshot.docs) {
      var category = Category.fromFirestore(doc);
      String downloadUrl =
          await _storage.ref(category.logoPath).getDownloadURL();
      incomeCategories
          .add(Category(name: category.name, logoPath: downloadUrl));
    }
  }

  //adding the additional categories by custom method by the user
  void addNewCategory(String uid, Map<String, dynamic> newCategoryData,
      String categoryType) async {
    String collectionPath =
        categoryType == 'expense' ? 'expenseCategories' : 'incomeCategories';
    await _firestore
        .collection('users')
        .doc(uid)
        .collection(collectionPath)
        .add(newCategoryData);
  }

  //updating the category
  void updateCategory(
      String uid, String categoryId, Map<String, dynamic> updatedData) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('expenseCategories')
        .doc(categoryId)
        .update(updatedData);
  }

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
