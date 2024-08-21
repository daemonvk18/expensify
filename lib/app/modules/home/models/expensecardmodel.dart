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
