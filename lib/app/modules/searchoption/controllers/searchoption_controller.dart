import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensify_app/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchoptionController extends GetxController {
  final count = 0.obs;

  var searchText = ''.obs;
  var selectedCategory = <String>[].obs;

  //accessing the home controller to get the expenses data here
  final HomeController homeController = Get.find<HomeController>();
  //get the data and return the filtered data
  // List<ExpenseDetails> get filteredExpenses {
  //   //if the searchtext ans the selectedcategory is empty show nothing
  //   if (searchText.isEmpty && selectedCategory.isEmpty) {
  //     return [];
  //   }

  //   // List<ExpenseDetails> allExpenses = [
  //   //   ...homeController.todaydetailsdata,
  //   //   ...homeController.yesterdaydetailsdata
  //   // ];

  //   return allExpenses.where((expenses) {
  //     final matchesSearchText = expenses.expenseTitle
  //         .toLowerCase()
  //         .contains(searchText.value.toLowerCase());
  //     final matchesCategory = selectedCategory.isEmpty ||
  //         selectedCategory.contains(expenses.expenseCategory);
  //     return matchesSearchText && matchesCategory;
  //   }).toList();
  // }

  // //update the searchText
  // void updateSeachText(String text) {
  //   searchText.value = text;
  // }

  //update the selected category
  void updateSelectedCategory(String category) {
    if (selectedCategory.contains(category)) {
      selectedCategory.remove(category);
    } else {
      selectedCategory.add(category);
    }
  }

  List categories = [
    ['Groceries', 'assets/images/Groceries.svg'],
    ['Health', 'assets/images/Health.svg'],
    ['Gifts', 'assets/images/Gifts.svg'],
    ['Bar & Cafe', 'assets/images/Cafe.svg'],
    ['Electronics', 'assets/images/Electronics.svg'],
    ['Liquor', 'assets/images/Liquor.svg'],
    ['Restaurant', 'assets/images/Restaurant.svg'],
    ['Laundry', 'assets/images/Liquor.svg'],
    ['Salary', 'assets/images/Money.svg'],
    ['Wages', 'assets/images/Donate.svg'],
    ['Interest', 'assets/images/Institute.svg'],
    ['Savings', 'assets/images/Savings.svg']
  ];

  RxList<Map<String, dynamic>> allExpenses =
      <Map<String, dynamic>>[].obs; // All expenses
  RxList<Map<String, dynamic>> filteredexpenses =
      <Map<String, dynamic>>[].obs; // Filtered expenses
  RxList<String> selectedcategories =
      <String>[].obs; // Currently selected category
  RxString searchtext = ''.obs; // Search text from TextField
  String userid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> loadUsersExpenses() async {
    try {
      // Fetch expenses from Firestore (this is just an example; update with your Firestore structure)
      final userExpensesSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userid) // Replace 'userId' with the appropriate user ID
          .collection('Expense')
          .get();

      allExpenses.clear(); // Clear previous data

      for (var doc in userExpensesSnapshot.docs) {
        allExpenses.add(doc.data() as Map<String, dynamic>);
      }

      filterExpenses(); // Filter expenses after loading them
    } catch (e) {
      print('Error loading user expenses: $e');
    }
  }

  // Method to filter expenses based on selected categories and search text
  void filterExpenses() {
    if (selectedcategories.isEmpty && searchText.isEmpty) {
      filteredexpenses.clear();
      return; // If no filter, show no expenses
    } else {
      filteredexpenses.assignAll(allExpenses.where((expense) {
        final matchesCategory = selectedcategories.isEmpty ||
            selectedcategories.contains(expense['category']);
        final matchesText = searchtext.isEmpty ||
            expense['title']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            expense['category']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase());

        return matchesCategory &&
            matchesText; // Show only expenses that match both filters
      }).toList());
    }
  }

  // Method to add or remove a selected category
  void toggleCategory(String category) {
    if (selectedcategories.contains(category)) {
      selectedcategories.remove(category);
    } else {
      selectedcategories.add(category);
    }
    filterExpenses(); // Apply filter when category is toggled
  }

  // Method to update the search text
  void updateSearchText(String text) {
    searchtext.value = text;
    filterExpenses(); // Apply filter when search text is updated
  }

  @override
  void onInit() {
    super.onInit();
    loadUsersExpenses();
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
