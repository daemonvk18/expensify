class DetailsModel {
  DetailsModel(
      {required this.expenseTitle,
      required this.iconUrl,
      required this.percent,
      required this.totalAmount,
      required this.totalTransactions});
  final String expenseTitle;
  final String totalTransactions;
  final String totalAmount;
  final String percent;
  final String iconUrl;
}

List<DetailsModel> details = [
  DetailsModel(
      expenseTitle: "Transportation",
      iconUrl: "assets/images/Transportation.svg",
      percent: "32",
      totalAmount: "5300",
      totalTransactions: "36"),
  DetailsModel(
      expenseTitle: "Transportation",
      iconUrl: "assets/images/Transportation.svg",
      percent: "32",
      totalAmount: "5300",
      totalTransactions: "36"),
  DetailsModel(
      expenseTitle: "Transportation",
      iconUrl: "assets/images/Transportation.svg",
      percent: "32",
      totalAmount: "5300",
      totalTransactions: "36"),
  DetailsModel(
      expenseTitle: "Transportation",
      iconUrl: "assets/images/Transportation.svg",
      percent: "32",
      totalAmount: "5300",
      totalTransactions: "36"),
  DetailsModel(
      expenseTitle: "Transportation",
      iconUrl: "assets/images/Transportation.svg",
      percent: "32",
      totalAmount: "5300",
      totalTransactions: "36"),
  DetailsModel(
      expenseTitle: "Transportation",
      iconUrl: "assets/images/Transportation.svg",
      percent: "32",
      totalAmount: "5300",
      totalTransactions: "36")
];
