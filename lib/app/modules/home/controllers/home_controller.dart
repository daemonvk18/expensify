import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //the varaiable to store the date picked
  var selectedDate = DateTime.now().obs;
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

  //updating the dateformat to the required condition(may,2021)
  String get formattedDate =>
      DateFormat('MMMM, yyyy').format(selectedDate.value);

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
