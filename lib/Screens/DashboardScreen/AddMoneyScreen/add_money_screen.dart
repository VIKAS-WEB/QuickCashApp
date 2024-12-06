import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/AddPaymentSuccessModel/addPaymentSuccessApi.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/AddPaymentSuccessModel/addPaymentSuccessModel.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/PayRecipientsScree/exchangeCurrencyModel/exchangeCurrencyApi.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/PayRecipientsScree/exchangeCurrencyModel/exchangeCurrencyModel.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/model/currencyApiModel/currencyModel.dart';
import 'package:quickcash/util/auth_manager.dart';
import 'package:quickcash/util/customSnackBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../model/currencyApiModel/currencyApi.dart';
import 'AddPaymentSuccessScreen/addPaymentSuccessScreen.dart';

class AddMoneyScreen extends StatefulWidget {
  final String? accountId;
  final String? country;
  final String? currency;
  final String? iban;
  final bool? status;
  final double? amount;

  const AddMoneyScreen(
      {super.key,
      this.accountId,
      this.country,
      this.currency,
      this.iban,
      this.status,
      this.amount});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreen();
}

class _AddMoneyScreen extends State<AddMoneyScreen> {
  bool isPaymentComplete = false;
  final Razorpay _razorpay = Razorpay();

  final AddPaymentSuccessApi _addPaymentSuccessApi = AddPaymentSuccessApi();
  final CurrencyApi _currencyApi = CurrencyApi();
  final ExchangeCurrencyApi _exchangeCurrencyApi = ExchangeCurrencyApi();

  String? selectedSendCurrency;
  String? selectedTransferType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mAmountController = TextEditingController();

  List<CurrencyListsData> currency = [];

  double? mDepositFees = 0.0;
  String? mAmountCharge = '0.0';
  String? mConversionAmount = '0.0';

  bool isLoading = false;
  bool isAddLoading = false;

  // From  Account ---
  String? mFromAccountId;
  String? mFromCountry;
  String? mFromCurrency;
  String? mFromIban;
  bool? mFromStatus;
  double? mFromAmount;
  String? mFromCurrencySymbol;

  // To Account ----
  String? mToCurrencySymbol = '';

  @override
  void initState() {
    mSetDefaultAccountData();
    mGetCurrency();
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  Future<void> mSetDefaultAccountData() async {
    setState(() {
      mFromAccountId = widget.accountId;
      mFromCountry = widget.country;
      mFromCurrency = widget.currency;
      mFromIban = widget.iban;
      mFromStatus = widget.status;
      mFromAmount = widget.amount;

      mFromCurrencySymbol = getCurrencySymbol(mFromCurrency!);
    });
  }

  Future<void> mGetCurrency() async {
    final response = await _currencyApi.currencyApi();
    if (response.currencyList != null && response.currencyList!.isNotEmpty) {
      currency = response.currencyList!;
    }
  }

  String getCurrencySymbol(String currencyCode) {
    var format = NumberFormat.simpleCurrency(name: currencyCode);
    return format.currencySymbol;
  }

  // Exchange Money Api **************
  Future<void> mExchangeMoneyApi() async {
    setState(() {
      isLoading = true;
    });

    try {
      final request = ExchangeCurrencyRequest(
          userId: AuthManager.getUserId(),
          amount: mAmountController.text,
          fromCurrency: selectedSendCurrency!,
          toCurrency: mFromCurrency!);
      final response = await _exchangeCurrencyApi.exchangeCurrencyApi(request);

      if (response.message == "Success") {
        setState(() {
          isLoading = false;
          mDepositFees = response.data.totalFees;
          mAmountCharge = response.data.totalCharge.toString();
          mConversionAmount = response.data.convertedAmount.toStringAsFixed(2);
        });
      } else {
        setState(() {
          isLoading = false;
          CustomSnackBar.showSnackBar(
              context: context,
              message: "We are facing some issue!",
              color: kPrimaryColor);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openRazorpay() async {
    double amountInDouble = double.tryParse(mAmountCharge ?? '0.0') ?? 0.0;
    int amount = (amountInDouble * 100).toInt();

    try {
      var options = {
        'key': 'rzp_test_TR6pZnguGgK8hQ',
        'amount': amount,
        'name': 'Quickcash',
        'method': 'upi',
        'theme': {
          'color': "#6F35A5",
        }
      };
      _razorpay.open(options);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    mAddPaymentSuccess(response.paymentId, "succeeded", "Razorpay");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPaymentPopupMessage(context, false, 'Payment Failed!');
    mAddPaymentSuccess("", "succeeded", "Razorpay");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  // Add Payment Success Api ****
  Future<void> mAddPaymentSuccess(
      String? paymentId, String status, String paymentGateway) async {
    setState(() {
      isAddLoading = true;
    });

    try {
      String amountText = '$mToCurrencySymbol ${mAmountController.text}';
      String conversionAmountText =
          '$mFromCurrencySymbol ${mConversionAmount!}';
      final request = AddPaymentSuccessRequest(
          userId: AuthManager.getUserId(),
          status: status,
          paymentId: paymentId!,
          paymentGateway: paymentGateway,
          amount: mAmountController.text,
          fee: mDepositFees.toString(),
          amountText: amountText,
          fromCurrency: mFromCurrency!,
          toCurrency: selectedSendCurrency!,
          conversionAmount: mConversionAmount!,
          conversionAmountText: conversionAmountText);
      final response =
          await _addPaymentSuccessApi.addPaymentSuccessApi(request);

      if (response.message == "Payment has been done Successfully !!!") {
        setState(() {
          String totalAmount = '$mToCurrencySymbol $mAmountCharge';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPaymentSuccessScreen(transactionId: paymentId, amount: totalAmount),
            ),
          );

          isAddLoading = false;
        });
      }else{
        isAddLoading = false;
      }
    } catch (error) {
      setState(() {
        isAddLoading = false;
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
          "Add Money",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isAddLoading ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding),
                GestureDetector(
                  onTap: () {
                    if (currency.isNotEmpty) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Select Currency',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: currency
                                    .map((CurrencyListsData currencyItem) {
                                  return ListTile(
                                    title: Text(
                                      currencyItem.currencyCode!,
                                      style: const TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.pop(
                                          context, currencyItem.currencyCode);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ).then((String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedSendCurrency = newValue;
                            mToCurrencySymbol =
                                getCurrencySymbol(selectedSendCurrency!);
                            mAmountController.clear();
                          });
                        }
                      });
                    }
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedSendCurrency ?? "Select Currency",
                            style: const TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down,
                              color: kPrimaryColor),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                GestureDetector(
                  onTap: () => _showTransferTypeDropDown(context, true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (selectedTransferType != null)
                              Image.asset(
                                _getImageForTransferType(selectedTransferType!),
                                height: 24,
                                width: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image,
                                      color: Colors.red);
                                },
                              ),
                            const SizedBox(width: 8.0),
                            Text(
                              selectedTransferType != null
                                  ? '$selectedTransferType ${_getFlagForTransferType(selectedTransferType!)}'
                                  : 'Transfer Type',
                              style: const TextStyle(color: kPrimaryColor),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: mAmountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a amount';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (selectedSendCurrency != null) {
                      if (mAmountController.text.isNotEmpty) {
                        if (double.parse(mAmountController.text) <=
                            mFromAmount!) {
                          mExchangeMoneyApi();
                        } else {
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message: "Please enter a valid amount",
                              color: kPrimaryColor);
                        }
                      } else {
                        CustomSnackBar.showSnackBar(
                            context: context,
                            message: "Please enter amount",
                            color: kPrimaryColor);
                      }
                    } else {
                      CustomSnackBar.showSnackBar(
                          context: context,
                          message: "Please select currency",
                          color: kPrimaryColor);
                    }
                  },
                ),
                const SizedBox(height: 45),
                if (isLoading)
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular button
                        Material(
                          elevation: 6.0,
                          shape: const CircleBorder(),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.arrow_downward,
                                      size: 30,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Deposit Fee:",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    Text("$mToCurrencySymbol $mDepositFees",
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: smallPadding),
                const Divider(),
                const SizedBox(height: smallPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Amount Charge:",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    Text("$mToCurrencySymbol $mAmountCharge",
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: smallPadding),
                const Divider(),
                const SizedBox(height: smallPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Conversion Amount:",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    Text("$mFromCurrencySymbol $mConversionAmount",
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 45),
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
                      if (_formKey.currentState!.validate()) {
                        if (selectedSendCurrency == null) {
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message: "Please select a currency",
                              color: kPrimaryColor);
                          return;
                        } else if (selectedTransferType == null) {
                          CustomSnackBar.showSnackBar(
                              context: context,
                              message: "Please select a transfer type",
                              color: kPrimaryColor);
                          return;
                        }

                        if (selectedTransferType ==
                            "UPI * Currently Support Only INR Currency") {
                          if (selectedSendCurrency == "INR") {
                            // Razor Pay
                            _openRazorpay();
                          } else {
                            CustomSnackBar.showSnackBar(
                                context: context,
                                message: "Currency is not supported!",
                                color: kPrimaryColor);
                          }
                        } else {}
                      }
                    },
                    child: const Text('Add Money',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFlagForTransferType(String transferType) {
    switch (transferType) {
      case "Stripe * Support Other Currencies":
        return 'Stripe';
      case "UPI * Currently Support Only INR Currency":
        return 'UPI';
      default:
        return '';
    }
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "Stripe * Support Other Currencies":
        return 'assets/icons/stripe.png';
      case "UPI * Currently Support Only INR Currency":
        return 'assets/icons/upi.png';
      default:
        return 'assets/icons/default.png';
    }
  }

  void _showTransferTypeDropDown(BuildContext context, bool isTransfer) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions(
              'Stripe * Support Other Currencies',
              'assets/icons/stripe.png',
              isTransfer,
            ),
            _buildTransferOptions(
              'UPI * Currently Support Only INR Currency',
              'assets/icons/upi.png',
              isTransfer,
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransferOptions(String type, String logoPath, bool isTransfer) {
    return ListTile(
      title: Row(
        children: [
          Image.asset(logoPath, height: 24),
          const SizedBox(width: 8.0),
          Text(type),
        ],
      ),
      onTap: () {
        setState(() {
          if (isTransfer) {
            selectedTransferType = type;
            mAmountController.clear();
          }
        });
        Navigator.pop(context);
      },
    );
  }

  void showPaymentPopupMessage(
      BuildContext ctx, bool isPaymentSuccess, String message) {
    showDialog<void>(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              isPaymentSuccess
                  ? const Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
              const SizedBox(
                width: 5,
              ),
              Text(
                isPaymentSuccess ? 'Payment Successful' : 'Payment Failed',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(message),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
