class ExpenseDetails {
  ExpenseDetails(
      {required this.expenseCategorylogo,
      required this.amount,
      this.expenseCategory = "",
      required this.expenseTitle});
  final String expenseCategorylogo;
  final String expenseTitle;
  final String expenseCategory;
  final String amount;
}

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
