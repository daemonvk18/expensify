import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensify_app/app/modules/home/controllers/home_controller.dart';
import 'package:expensify_app/app/modules/report/controllers/report_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddnewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  var selectedType = 'Expense'.obs;
  var categoryName = ''.obs;
  var amount = ''.obs;
  var title = ''.obs;

  // RxList to store the fetched categories
  var expenseCategories = <Map<String, dynamic>>[].obs;
  var incomeCategories = <Map<String, dynamic>>[].obs;

  //load the categories data from the firestore
  Future<void> loadDataCategory() async {
    try {
      //load the users expense categories
      QuerySnapshot userExpenseSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('expenseCategories')
          .get();

      //if the user had logged in for the first time
      if (userExpenseSnapshot.docs.isEmpty) {
        QuerySnapshot defaultexpenseSnapshot =
            await _firestore.collection('defaultexpenseCategories').get();
        expenseCategories.assignAll(defaultexpenseSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
      } else {
        expenseCategories.assignAll(userExpenseSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
      }

      // Load user's income categories
      QuerySnapshot userIncomeSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('incomeCategories')
          .get();

      // If no custom categories exist, load default categories
      if (userIncomeSnapshot.docs.isEmpty) {
        QuerySnapshot defaultIncomeSnapshot =
            await _firestore.collection('defaultIncomeCategories').get();
        incomeCategories.assignAll(
          defaultIncomeSnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList(),
        );
      } else {
        incomeCategories.assignAll(
          userIncomeSnapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList(),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
    }
  }

  //adding a new expense to the users list
  Future<void> addTransaction(String collectionPath, String category,
      String amount, String title) async {
    //fetch the category logo
    String categoryLogo =
        await fetchCategoryLogo(type: collectionPath, categoryName: category);

    final collectionRef =
        _firestore.collection('users').doc(userId).collection(collectionPath);

    //checking if the collection already exist or not
    final collectionSnapshot = await collectionRef.limit(1).get();
    final isFirstTransaction = collectionSnapshot.size == 0;

    if (isFirstTransaction) {
      //creating the collection
      final intialTransaction = {
        'category': category,
        'iconUrl': categoryLogo,
        'amount': amount,
        'title': title,
        'data': DateFormat('yyyyMMdd').format(DateTime.now()),
      };
      await collectionRef.add(intialTransaction);
      print(
          'Created the $collectionPath collection and added the first transaction.');
    } else {
      //adding the transaction to the existing collection
      final newTransaction = {
        'category': category,
        'iconUrl': categoryLogo,
        'amount': amount,
        'title': title,
        'data': DateFormat('yyyyMMdd').format(DateTime.now()),
      };
      await collectionRef.add(newTransaction);
      print('Added transaction to the existing $collectionPath collection.');
      await Get.find<HomeController>().loadTodayAndYesterdaysTransactions();
      await Get.find<ReportController>().loadTodayExpenses();
    }
  }

  //fetch the category logo function
  Future<String> fetchCategoryLogo(
      {required String type, required String categoryName}) async {
    try {
      // Determine the collection path for categories
      String collectionPath =
          type == 'Expense' ? 'expenseCategories' : 'incomeCategories';
      // Fetch the document from Firestore
      QuerySnapshot<Map<String, dynamic>> categoryDoc = await _firestore
          .collection('users')
          .doc(userId)
          .collection(collectionPath)
          .where('name', isEqualTo: categoryName)
          .limit(1)
          .get();

      if (categoryDoc.docs.isNotEmpty) {
        // Extract the document data
        Map<String, dynamic> data = categoryDoc.docs.first.data();

        // Check if the 'iconUrl' field exists
        if (data.containsKey('iconUrl')) {
          return data['iconUrl'] as String;
        } else {
          print(
              "Error: 'iconUrl' field not found for category '$categoryName'.");
        }
      } else {
        print("Error: No document found for category '$categoryName'.");
      }
    } catch (e) {
      print("Error fetching category logo: $e");
    }
    return "";
  }

  // final List<Map<String, String>> categories = [
  //   {'name': 'Grocery', 'icon': 'assets/images/Groceries.svg'},
  //   {'name': 'Gifts', 'icon': 'assets/images/Gifts.svg'},
  //   {'name': 'Bar & Cafe', 'icon': 'assets/images/Cafe.svg'},
  //   {'name': 'Health', 'icon': 'assets/images/Health.svg'},
  //   {'name': 'Commute', 'icon': 'assets/images/Transportation.svg'},
  //   {'name': 'Electronics', 'icon': 'assets/images/Electronics.svg'},
  //   {'name': 'Laundry', 'icon': 'assets/images/Laundry.svg'},
  //   {'name': 'Liquor', 'icon': 'assets/images/Liquor.svg'},
  //   {'name': 'Restaurant', 'icon': 'assets/images/Restaurant.svg'},
  // ];

  // final List<Map<String, String>> incomecategories = [
  //   {'name': 'Salary', 'icon': 'assets/images/Money.svg'},
  //   {'name': 'Gifts', 'icon': 'assets/images/Gifts.svg'},
  //   {'name': 'Wages', 'icon': 'assets/images/Donate.svg'},
  //   {'name': 'Interest', 'icon': 'assets/images/Institute.svg'},
  //   {'name': 'Savings', 'icon': 'assets/images/Savings.svg'},
  //   {'name': 'Allowance', 'icon': 'assets/images/allowance.svg'},
  // ];

  void updateCategory(String category) async {
    categoryName.value = await category;
  }

  void updateIncomeCategory(String category) async {
    categoryName.value = await category;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadDataCategory();
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
