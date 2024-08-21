import 'package:expensify_app/app/modules/home/models/expensecardmodel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //the varaiable to store the date picked
  var selectedDate = DateTime.now().obs;
  final box = GetStorage();
  //expenses
  var expenses = '12,000'.obs;
  //balance
  var balance = '48,000'.obs;
  //income
  var income = '70,000'.obs;
  //today expense amount
  var todayEXpenseAmount = '1125'.obs;
  //yesterdays expense amount
  var yesterdayExpenseAmount = '1225'.obs;

  //method to update the selected date
  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  String firstLetter = '';
  //first letter of the email for profile
  void firstLetterEmail() {
    // ignore: unused_local_variable
    String firstLetter = box.read('email').toString().substring(0, 1);
  }

  //updating the dateformat to the required condition(may,2021)
  String get formattedDate =>
      DateFormat('MMMM, yyyy').format(selectedDate.value);

  final List<ExpenseDetails> todaydetailsdata = [
    ExpenseDetails(
        expenseCategorylogo: "",
        amount: '1125',
        expenseTitle: "T O D A Y",
        expenseCategory: ''),
    ExpenseDetails(
        expenseCategorylogo: "assets/images/Groceries.svg",
        amount: '500',
        expenseTitle: "Eggs & Vegetables",
        expenseCategory: 'Groceries'),
    ExpenseDetails(
        expenseCategorylogo: "assets/images/Health.svg",
        amount: '352',
        expenseTitle: "Health",
        expenseCategory: ''),
    ExpenseDetails(
        expenseCategorylogo: "assets/images/Cafe.svg",
        amount: '352',
        expenseTitle: "Hangouts with Rohan",
        expenseCategory: 'Bar & Cafe'),
  ];

  final List<ExpenseDetails> yesterdaydetailsdata = [
    ExpenseDetails(
        expenseCategorylogo: "",
        amount: '1125',
        expenseTitle: "Y E S T E R D A Y",
        expenseCategory: ''),
    ExpenseDetails(
        expenseCategorylogo: "assets/images/Maintenance.svg",
        amount: '500',
        expenseTitle: "Eggs & Veggies",
        expenseCategory: 'Groceries'),
    ExpenseDetails(
        expenseCategorylogo: "assets/images/Health.svg",
        amount: '352',
        expenseTitle: "Health",
        expenseCategory: ''),
    ExpenseDetails(
        expenseCategorylogo: "assets/images/Laundry.svg",
        amount: '352',
        expenseTitle: "Hangouts with Upendra",
        expenseCategory: 'Bar & Cafe'),
  ];

  //getter function to get the whole expenses data
  List<ExpenseDetails> get allExpenses =>
      todaydetailsdata + yesterdaydetailsdata;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    firstLetterEmail();
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
