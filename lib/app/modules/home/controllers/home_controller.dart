import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  RxList<Map<String, dynamic>> todayTransactions = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> yesterdayTransactions =
      <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> monthTransactions = <Map<String, dynamic>>[].obs;

  RxDouble totalExpense = 0.0.obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble balanceAmount = 0.0.obs;
  //the varaiable to store the date picked
  var selectedDate = DateTime.now().obs;
  final box = GetStorage();
  var dateSelected = false.obs;

  //method to update the selected date
  void updateDate(DateTime date) {
    selectedDate.value = date;
  }

  List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String getMonth() {
    DateTime date =
        DateTime.parse(DateFormat('yyyyMMdd').format(selectedDate.value));
    int month = date.month;
    String monthName = monthNames[month - 1];
    return monthName;
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

  // Method to load today's and yesterday's transactions (both expenses and incomes)
  Future<void> loadTodayAndYesterdaysTransactions() async {
    try {
      double expenseSum = 0.0;
      double incomeSum = 0.0;

      final today = DateFormat('yyyyMMdd').format(DateTime.now());
      print(today);
      final yesterday = DateFormat('yyyyMMdd')
          .format(DateTime.now().subtract(Duration(days: 1)));

      List<Map<String, dynamic>> todayList = [];
      List<Map<String, dynamic>> yesterdayList = [];

      // Fetch expenses
      QuerySnapshot expenseSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Expense')
          .get();

      for (var doc in expenseSnapshot.docs) {
        String expenseDate = doc['data'];
        double expenseamount = double.tryParse(doc['amount'].toString()) ?? 0.0;
        if (expenseDate == today) {
          todayList.add({
            ...doc.data() as Map<String, dynamic>, // Spread the existing map
            'isExpense': true, // Add the new key-value pair
          });
        } else if (expenseDate == yesterday) {
          yesterdayList.add({
            ...doc.data() as Map<String, dynamic>, // Spread the existing map
            'isExpense': true, // Add the new key-value pair
          });
        }
        expenseSum += expenseamount;
      }
      // Fetch incomes
      QuerySnapshot incomeSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Income')
          .get();

      for (var doc in incomeSnapshot.docs) {
        String incomeDate = doc['data'];
        double incomeamount = double.tryParse(doc['amount'].toString()) ?? 0.0;
        if (incomeDate == today) {
          todayList.add({
            ...doc.data() as Map<String, dynamic>, // Spread the existing map
            'isExpense': false, // Add the new key-value pair
          });
        } else if (incomeDate == yesterday) {
          yesterdayList.add({
            ...doc.data() as Map<String, dynamic>, // Spread the existing map
            'isExpense': false, // Add the new key-value pair
          });
        }

        incomeSum += incomeamount;
      }

      // Update the lists and totals
      todayTransactions.value = todayList;
      yesterdayTransactions.value = yesterdayList;

      totalExpense.value = expenseSum;
      totalIncome.value = incomeSum;
      balanceAmount.value = totalIncome.value - totalExpense.value;
      update();
    } catch (e) {
      print("Error fetching expenses and incomes: $e");
    }
  }

  //load a monthdata when selected a particular date
  Future<void> loadamonthTransactions(String date) async {
    print(date.substring(0, 6));
    try {
      List<Map<String, dynamic>> transactions = [];
      // Fetch expenses for the selected month
      QuerySnapshot expenseSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Expense')
          .get();

      for (var doc in expenseSnapshot.docs) {
        String expenseDate = doc['data'];
        if (expenseDate.substring(0, 6) == date.substring(0, 6)) {
          transactions.add(doc.data() as Map<String, dynamic>);
        }
      }

      // Fetch incomes for the selected month
      QuerySnapshot incomeSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Income')
          .get();

      for (var doc in incomeSnapshot.docs) {
        String incomeDate = doc['data'];
        if (incomeDate == date.substring(0, 6)) {
          transactions.add(doc.data() as Map<String, dynamic>);
        }
      }

      // Update the list of transactions for the selected month
      monthTransactions.value = transactions;
    } catch (e) {
      print("Error loading transactions for the month: $e");
    }
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await loadTodayAndYesterdaysTransactions();
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
