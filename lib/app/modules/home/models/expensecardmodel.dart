class ExpenseDetails {
  ExpenseDetails(
      {required this.expenseCategorylogo,
      required this.amount,
      this.expenseDescription = "",
      required this.expenseTitle});
  final String expenseCategorylogo;
  final String expenseTitle;
  final String expenseDescription;
  final String amount;
}

List<ExpenseDetails> detailsdata = [];
