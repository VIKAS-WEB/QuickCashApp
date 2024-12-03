import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/reviewExchangeMoneyScreen/addExchangeModel/addExchangeMoneyModel.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../util/customSnackBar.dart';
import '../../../HomeScreen/home_screen.dart';
import 'addExchangeModel/addExchangeApi.dart';

class ReviewExchangeMoneyScreen extends StatefulWidget {
  // From Data
  final String? fromAccountId;
  final String? fromCountry;
  final String? fromCurrency;
  final String? fromIban;
  final double? fromAmount;
  final String? fromCurrencySymbol;
  final double? fromTotalFees;
  final double? fromRate;
  final String? fromExchangeAmount;

  // To Data
  final String? toAccountId;
  final String? toCountry;
  final String? toCurrency;
  final String? toIban;
  final double? toAmount;
  final String? toCurrencySymbol;
  final String? toExchangedAmount;


  const ReviewExchangeMoneyScreen({super.key,
    this.fromAccountId,
    this.fromCountry,
    this.fromCurrency,
    this.fromIban,
    this.fromAmount,
    this.fromCurrencySymbol,
    this.fromTotalFees,
    this.fromRate,
    this.fromExchangeAmount,
    this.toAccountId,
    this.toCountry,
    this.toCurrency,
    this.toIban,
    this.toAmount,
    this.toCurrencySymbol,
    this.toExchangedAmount});

  @override
  State<ReviewExchangeMoneyScreen> createState() =>
      _ReviewExchangeMoneyScreen();
}

class _ReviewExchangeMoneyScreen extends State<ReviewExchangeMoneyScreen> {
  final AddExchangeApi _addExchangeApi = AddExchangeApi();
  bool isLoading = false;

  // From Data
  String? mFromAccountId;
  String? mFromCountry;
  String? mFromCurrency;
  String? mFromIban;
  double? mFromAmount;
  String? mFromCurrencySymbol;
  double? mFromTotalFees;
  double? mFromRate;
  String? mExchangeAmount;
  double? mTotalCharge;

  // To Data
  String? mToAccountId;
  String? mToCountry;
  String? mToCurrency;
  String? mToIban;
  double? mToAmount;
  String? mToCurrencySymbol;
  double? mToRate;
  String? mToExchangedAmount;

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
    mFromRate = widget.fromRate;
    mExchangeAmount = widget.fromExchangeAmount;


    if (mExchangeAmount != null && mFromTotalFees != null) {
      double exchangeAmount = double.tryParse(mExchangeAmount!) ?? 0.0;  // Default to 0.0 if parse fails
      mTotalCharge = exchangeAmount + (mFromTotalFees ?? 0.0);
    }

    // To Data
    mToAccountId = widget.toAccountId;
    mToCountry = widget.toCountry;
    mToCurrency = widget.toCurrency;
    mToIban = widget.toIban;
    mToAmount = widget.toAmount;
    mToCurrencySymbol = widget.toCurrencySymbol;
    mToExchangedAmount = widget.toExchangedAmount;
  }


  // Add Exchange api ************************
  Future<void> mAddExchangeApi() async {
    setState(() {
      isLoading = true;
    });

    try{

      String info = 'Convert $mFromCurrency to $mToCurrency';
      String amountText = '$mToCurrencySymbol $mToExchangedAmount';

      final request = AddExchangeRequest(userId: AuthManager.getUserId(), sourceAccount: mToAccountId!, transferAccount: mFromAccountId!, transType: "Exchange", fee: mFromTotalFees!, info: info, country: mToCountry!, fromAmount: mFromAmount!, amount: mToExchangedAmount!, amountText: amountText, fromAmountText: mFromAmount!.toStringAsFixed(2), fromCurrency: mFromCurrency!, toCurrency: mToCurrency!, status: "Success");
      final response = await _addExchangeApi.addExchangeApi(request);

      if(response.message == "Transaction is added Successfully!!!"){
        setState(() {
          isLoading = false;
          CustomSnackBar.showSnackBar(context: context, message: "Exchange has been done Successfully", color: kPrimaryColor);
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        });
      }else{
        setState(() {
          isLoading = false;
          CustomSnackBar.showSnackBar(context: context, message: "We are facing some issue!", color: kPrimaryColor);
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Something went wrong!",
            color: kPrimaryColor);
      });
    }

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
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Exchange",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "$mFromCurrencySymbol $mExchangeAmount",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: kPrimaryLightColor,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Rate",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "1$mFromCurrencySymbol = ${mFromRate?.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: kPrimaryLightColor,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Fee",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "$mFromCurrencySymbol $mFromTotalFees",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: kPrimaryLightColor,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Charge",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "$mFromCurrencySymbol $mTotalCharge",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: kPrimaryLightColor,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Will get Exactly",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          Text(
                            "$mToCurrencySymbol $mToExchangedAmount",
                            style: const TextStyle(
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

              const SizedBox(height: largePadding,),
              if (isLoading) const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ), // Show loading indicator


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
                  onPressed: isLoading ? null : mAddExchangeApi,
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
