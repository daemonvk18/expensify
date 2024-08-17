import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportController extends GetxController {
  //the varaiable to store the date picked
  var selectedDate = DateTime.now().obs;

  //method to update the selected date
  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  //updating the dateformat to the required condition(may,2021)
  String get formattedDate =>
      DateFormat('MMMM, yyyy').format(selectedDate.value);

  //percentages for each category
  var transportationPercentage = 0.32.obs;
  var healthPercentage = 0.31.obs;
  var personalPercentage = 0.23.obs;
  var giftsPercentage = 0.14.obs;
  var electronicsPercentage = 0.08.obs;
  var cafePercentage = 0.02.obs;

  // Function to update the percentages (if needed)
  void updatePercentages(double transportation, double health, double personal,
      double gifts, double electronics, double cafe) {
    transportationPercentage.value = transportation;
    healthPercentage.value = health;
    personalPercentage.value = personal;
    giftsPercentage.value = gifts;
    electronicsPercentage.value = electronics;
    cafePercentage.value = cafe;
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
