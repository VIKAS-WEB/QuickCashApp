import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class ReviewExchangeMoneyScreen extends StatefulWidget {
  // From Data
  final String? fromAccountId;
  final String? fromCountry;
  final String? fromCurrency;
  final String? fromIban;
  final double? fromAmount;
  final String? fromCurrencySymbol;
  final double? fromTotalFees;

  // To Data
  final String? toAccountId;
  final String? toCountry;
  final String? toCurrency;
  final String? toIban;
  final double? toAmount;
  final String? toCurrencySymbol;

  const ReviewExchangeMoneyScreen({super.key,
    this.fromAccountId,
    this.fromCountry,
    this.fromCurrency,
    this.fromIban,
    this.fromAmount,
    this.fromCurrencySymbol,
    this.fromTotalFees,
    this.toAccountId,
    this.toCountry,
    this.toCurrency,
    this.toIban,
    this.toAmount,
    this.toCurrencySymbol});

  @override
  State<ReviewExchangeMoneyScreen> createState() =>
      _ReviewExchangeMoneyScreen();
}

class _ReviewExchangeMoneyScreen extends State<ReviewExchangeMoneyScreen> {

  // From Data
  String? mFromAccountId;
  String? mFromCountry;
  String? mFromCurrency;
  String? mFromIban;
  double? mFromAmount;
  String? mFromCurrencySymbol;
  double? mFromTotalFees;

  // To Data
  String? mToAccountId;
  String? mToCountry;
  String? mToCurrency;
  String? mToIban;
  double? mToAmount;
  String? mToCurrencySymbol;

  @override
  void initState() {
    mSetReviewData();
    super.initState();
  }

  Future<void> mSetReviewData() async {
    // From Data
    mFromAccountId = widget.fromAccountId;
    mFromCountry = widget.fromCountry;
    mFromCurrency = widget.fromCurrency;
    mFromIban = widget.fromIban;
    mFromAmount = widget.fromAmount;
    mFromCurrencySymbol = widget.fromCurrencySymbol;
    mFromTotalFees = widget.fromTotalFees;

    // To Data
    mToAccountId = widget.toAccountId;
    mToCountry = widget.toCountry;
    mToCurrency = widget.toCurrency;
    mToIban = widget.toIban;
    mToAmount = widget.toAmount;
    mToCurrencySymbol = widget.toCurrencySymbol;

    print('FromAccountId: $mFromAccountId, FromCountry: $mFromCountry, FromCurrency: $mFromCurrency, FromIban: $mFromIban, FromAmount: $mFromAmount, FromCurrencySymbol: $mFromCurrencySymbol, FromTotalFees: $mFromTotalFees');
    print('ToAccountId: $mToAccountId, ToCountry: $mToCountry, ToCurrency: $mToCurrency, ToIban: $mToIban, ToAmount: $mToAmount, ToCurrencySymbol: $mToCurrencySymbol');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Review Exchange Money",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Card(
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exchange",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "\$1.0",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: kPrimaryLightColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rate",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "\$1.0",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: kPrimaryLightColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fee",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "\$1.0",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: kPrimaryLightColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Charge",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "\$1.0",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: kPrimaryLightColor,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Will get Exactly",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "\$1.0",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Source Account",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      const SizedBox(height: defaultPadding),
                      Card(
                        elevation: 1.0,
                        color: kPrimaryLightColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                width: 55,
                                height: 55,
                                mFromCountry!,
                                shape: const Circle(),
                              ),
                              const SizedBox(width: defaultPadding),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$mFromCurrency Account',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                     Text(
                                      mFromIban!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                       maxLines: 2,
                                    ),
                                    Text(
                                      "$mFromCurrencySymbol ${mFromAmount?.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //Something here
                  },
                  child: const Text('Exchange',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
