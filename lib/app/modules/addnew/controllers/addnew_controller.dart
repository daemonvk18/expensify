import 'package:get/get.dart';

class AddnewController extends GetxController {
  var selectedType = 'Expense'.obs;
  var categoryName = ''.obs;
  var amount = ''.obs;
  final List<Map<String, String>> categories = [
    {'name': 'Grocery', 'icon': 'assets/images/Groceries.svg'},
    {'name': 'Gifts', 'icon': 'assets/images/Gifts.svg'},
    {'name': 'Bar & Cafe', 'icon': 'assets/images/Cafe.svg'},
    {'name': 'Health', 'icon': 'assets/images/Health.svg'},
    {'name': 'Commute', 'icon': 'assets/images/Transportation.svg'},
    {'name': 'Electronics', 'icon': 'assets/images/Electronics.svg'},
    {'name': 'Laundry', 'icon': 'assets/images/Laundry.svg'},
    {'name': 'Liquor', 'icon': 'assets/images/Liquor.svg'},
    {'name': 'Restaurant', 'icon': 'assets/images/Restaurant.svg'},
  ];

  final List<Map<String, String>> incomecategories = [
    {'name': 'Salary', 'icon': 'assets/images/Money.svg'},
    {'name': 'Gifts', 'icon': 'assets/images/Gifts.svg'},
    {'name': 'Wages', 'icon': 'assets/images/Donate.svg'},
    {'name': 'Interest', 'icon': 'assets/images/Institute.svg'},
    {'name': 'Savings', 'icon': 'assets/images/Savings.svg'},
    {'name': 'Allowance', 'icon': 'assets/images/allowance.svg'},
  ];

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
