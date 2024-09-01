import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ReportController extends GetxController {
  //the varaiable to store the date picked
  var selectedDate = DateTime.now().obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  // Sample data (replace with your actual data)

  final RxList<Map<String, dynamic>> expenses = <Map<String, dynamic>>[
    {'category': 'Transportation', 'amount': 5300, 'transactions': 36},
    {'category': 'Health', 'amount': 3100, 'transactions': 10},
    {'category': 'Personal', 'amount': 2320, 'transactions': 12},
    {'category': 'Gifts', 'amount': 1440, 'transactions': 12},
    {'category': 'Electronics', 'amount': 800, 'transactions': 12},
    {'category': 'Caffe & Bar', 'amount': 240, 'transactions': 12},
  ].obs;

  Future<void> generateAndSavePDF() async {
    final pdf = pw.Document();

    final int totalAmount =
        expenses.fold(0, (int sum, item) => sum + (item['amount'] as int));

    String summaryText = "Summary of Expenses:\n\n";
    for (var expense in expenses) {
      summaryText += "- ${expense['category']}: ₹${expense['amount']}\n";
    }
    summaryText += "\nTotal Amount Spent: ₹$totalAmount";

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Expense Report', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text(summaryText,
                  style: pw.TextStyle(
                    fontSize: 18,
                  )),
              pw.SizedBox(height: 20),
              pw.Text('Detailed Expenses:', style: pw.TextStyle(fontSize: 18)),
              pw.ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 4),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(expense['category'],
                            style: pw.TextStyle(fontSize: 16)),
                        pw.Text('₹${expense['amount']}',
                            style: pw.TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    // Request storage permissions
    var status = await Permission.storage.request();
    if (status.isGranted) {
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDirectory = await getDownloadsDirectory();
      }

      if (downloadsDirectory != null) {
        final file = File('${downloadsDirectory.path}/Expense_Report.pdf');
        await file.writeAsBytes(await pdf.save());

        Get.snackbar('Success', 'PDF saved in ${downloadsDirectory.path}');
      } else {
        Get.snackbar('Error', 'Failed to find the downloads directory');
      }
    } else {
      Get.snackbar('Permission Denied',
          'Storage permission is required to save the PDF');
    }
  }

  //loading the data from the firestore
  var todayExpenses = <Map<String, dynamic>>[];
  String userId = FirebaseAuth.instance.currentUser!.uid;

  //load the todays expenses list
  Future<void> loadTodayExpenses() async {
    //get the data
    try {
      String todaysDate = DateFormat('yyyyMMdd').format(DateTime.now());
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('Expense')
          .where('data', isEqualTo: todaysDate)
          .get();

      //adding the fetched details
      for (var doc in snapshot.docs) {
        todayExpenses.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error loading today's expenses: $e");
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadTodayExpenses();
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
