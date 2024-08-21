import 'package:expensify_app/app/modules/home/controllers/home_controller.dart';
import 'package:expensify_app/app/modules/home/models/expensecardmodel.dart';
import 'package:get/get.dart';

class SearchoptionController extends GetxController {
  final count = 0.obs;

  var searchText = ''.obs;
  var selectedCategory = <String>[].obs;

  //accessing the home controller to get the expenses data here
  final HomeController homeController = Get.find<HomeController>();
  //get the data and return the filtered data
  List<ExpenseDetails> get filteredExpenses {
    //if the searchtext ans the selectedcategory is empty show nothing
    if (searchText.isEmpty && selectedCategory.isEmpty) {
      return [];
    }

    List<ExpenseDetails> allExpenses = [
      ...homeController.todaydetailsdata,
      ...homeController.yesterdaydetailsdata
    ];

    return allExpenses.where((expenses) {
      final matchesSearchText = expenses.expenseTitle
          .toLowerCase()
          .contains(searchText.value.toLowerCase());
      final matchesCategory = selectedCategory.isEmpty ||
          selectedCategory.contains(expenses.expenseCategory);
      return matchesSearchText && matchesCategory;
    }).toList();
  }

  //update the searchText
  void updateSeachText(String text) {
    searchText.value = text;
  }

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
