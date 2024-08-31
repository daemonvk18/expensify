import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensify_app/app/modules/home/models/expensecardmodel.dart';
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
      print(todayTransactions);

      totalExpense.value = expenseSum;
      totalIncome.value = incomeSum;
      balanceAmount.value = totalIncome.value - totalExpense.value;
      update();
    } catch (e) {
      print("Error fetching expenses and incomes: $e");
    }
  }

  // // Helper function to parse 'yyyymmdd' formatted date strings to DateTime
  // DateTime _parseDate(String yyyymmdd) {
  //   int year = int.parse(yyyymmdd.substring(0, 4));
  //   int month = int.parse(yyyymmdd.substring(4, 6));
  //   int day = int.parse(yyyymmdd.substring(6, 8));
  //   return DateTime(year, month, day);
  // }

  // bool _isSameDate(DateTime date1, DateTime date2) {
  //   return date1.year == date2.year &&
  //       date1.month == date2.month &&
  //       date1.day == date2.day;
  // }

  //load a monthdata when selected a particular date
  Future<void> loadamonthTransactions(String date) async {
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
        if (expenseDate == date.substring(0, 6)) {
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
