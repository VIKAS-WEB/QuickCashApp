// add_money_screen_logic.dart
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/AddPaymentSuccessModel/addPaymentSuccessApi.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/AddPaymentSuccessModel/addPaymentSuccessModel.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/AddPaymentSuccessScreen/addPaymentSuccessScreen.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/Add_Money_Provider.dart/AddMoneyProvider.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/PayRecipientsScree/exchangeCurrencyModel/CurrencyExchangeModel.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/PayRecipientsScree/exchangeCurrencyModel/NewCurrencyExchangeAPI.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/PayRecipientsScree/exchangeCurrencyModel/exchangeCurrencyModel.dart';
import 'package:quickcash/Screens/HomeScreen/home_screen.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/model/currencyApiModel/Model/currencyModel.dart';
import 'package:quickcash/model/currencyApiModel/Services/currencyApi.dart';
import 'package:quickcash/util/auth_manager.dart';
import 'package:quickcash/util/customSnackBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddMoneyScreenLogic {
  final Razorpay _razorpay = Razorpay();
  final AddPaymentSuccessApi _addPaymentSuccessApi = AddPaymentSuccessApi();
  final CurrencyApi _currencyApi = CurrencyApi();
  final ExchangeCurrencyApiNew _exchangeCurrencyApi = ExchangeCurrencyApiNew();
  String apiUrl = "https://quickcash.oyefin.com/api/v1/stripe/create-intent";
  final TextEditingController mAmountController = TextEditingController();
  List<CurrencyListsData> currency = [];
  bool isAddLoading = false;

  // From Account ---
  String? mFromAccountId;
  String? mFromCountry;
  String? mFromCurrency;
  String? mFromAccountName;
  String? mFromIban;
  bool? mFromStatus;
  double? mFromAmount;
  String? mFromCurrencySymbol;

  AddMoneyScreenLogic({
    String? accountId,
    String? accountName,
    String? country,
    String? currency,
    String? iban,
    bool? status,
    double? amount,
  }) {
    mFromAccountId = accountId;
    mFromCountry = country;
    mFromCurrency = currency;
    mFromAccountName = accountName;
    mFromIban = iban;
    mFromStatus = status;
    mFromAmount = amount;
    init();
  }

  void init() {
    mSetDefaultAccountData();
    mGetCurrency();
    Stripe.publishableKey = stripePublishableKey;
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    //_razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
    mAmountController.dispose();
  }

  // Add a public method to set up the payment error handler
  void setupPaymentErrorHandler(Function(PaymentFailureResponse) handler) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handler);
  }

  Future<void> mSetDefaultAccountData() async {
    mFromCurrencySymbol = getCurrencySymbol(mFromCurrency!);
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

  Future<void> mExchangeMoneyApi(BuildContext context) async {
    final provider = Provider.of<AddMoneyProvider>(context, listen: false);
    if (provider.selectedSendCurrency == null) {
      print('mExchangeMoneyApi: No currency selected');
      CustomSnackBar.showSnackBar(
        context: context,
        message: "Please select a currency.",
        color: kPrimaryColor,
      );
      return;
    }

    // Check if amount is empty before proceeding
    if (mAmountController.text.isEmpty) {
      print('mExchangeMoneyApi: Amount is empty, resetting fields');
      provider.resetAllFields();
      return;
    }

   provider.setIsLoading(true);
    if (context.mounted) {
      (context as Element).markNeedsBuild();
    }
    try {
      double inputAmount = double.tryParse(mAmountController.text) ?? 0.0;
      print('mExchangeMoneyApi: Processing amount: $inputAmount');

      if (inputAmount <= 0) {
        print('mExchangeMoneyApi: Invalid amount (<= 0), resetting');
        provider.setIsLoading(false);
        provider.resetAllFields();
        if (context.mounted) {
          CustomSnackBar.showSnackBar(
            context: context,
            message: "Please enter a valid amount.",
            color: kPrimaryColor,
          );
        }
        return;
      }

      final exchangeRequest = ExchangeCurrencyRequestnew(
        toCurrency: mFromCurrency!,
        fromCurrency: provider.selectedSendCurrency!,
        amount: inputAmount,
      );
print('mExchangeMoneyApi: Calling API with amount: $inputAmount');
      final response =
          await _exchangeCurrencyApi.exchangeCurrencyApiNew(exchangeRequest);

          // Check again after API call to ensure amount hasn't been cleared
      if (mAmountController.text.isEmpty) {
        print('mExchangeMoneyApi: Amount cleared during API call, resetting');
        provider.resetAllFields();
        provider.setIsLoading(false);
        return;
      }

      if (response.success) {
        print('mExchangeMoneyApi: Success - '
            'convertedAmount: ${response.result.convertedAmount}');
        provider.setDepositFees(23);
        provider.setConversionAmount(
            response.result.convertedAmount.toStringAsFixed(2));
        provider.setAmountCharge((inputAmount + 23).toStringAsFixed(2));
        provider.setToCurrencySymbol(
            getCurrencySymbol(provider.selectedSendCurrency!));
        provider.setIsLoading(false);
      } else {
        print('mExchangeMoneyApi: API failed');
      if (context.mounted) {
          CustomSnackBar.showSnackBar(
            context: context,
            message: "We are facing some issues!",
            color: kPrimaryColor,
          );
        }
      }
    } catch (error) {
      print('mExchangeMoneyApi: Error - $error');
      provider.setIsLoading(false);
      if (context.mounted) {
        CustomSnackBar.showSnackBar(
          context: context,
          message: error.toString(),
          color: kPrimaryColor,
        );
      }
    }// Ensure rebuild after API call
    if (context.mounted) {
      (context as Element).markNeedsBuild();
    }

  }

  Future<void> handleStripePayment(
      BuildContext context, GlobalKey<FormState> formKey) async {
    final provider = Provider.of<AddMoneyProvider>(context, listen: false);

    if (!formKey.currentState!.validate()) return;

    isAddLoading = true;
    // Force rebuild to show loading state
    if (context.mounted) {
      (context as Element).markNeedsBuild();
    }

    try {
      Dio dio = Dio();
      String token = AuthManager.getToken();

      Map<String, dynamic> data = {
        "amount": double.tryParse(provider.amountCharge!) ?? 0.0,
        "account": mFromAccountId ?? "",
        "user": AuthManager.getUserId() ?? "",
        "convertedAmount": double.tryParse(provider.conversionAmount!) ?? 0.0,
        "fee": provider.depositFees ?? 0.0,
        "currency": provider.selectedSendCurrency?.toLowerCase() ?? "",
        "from_currency": mFromCurrency ?? "",
        "to_currency": provider.toCurrencySymbol ?? "",
      };

      Response response = await dio.post(
        apiUrl,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200 && response.data != null) {
        var responseBody = response.data;

        if (responseBody["status"] == 201 && responseBody["data"] != null) {
          var responseData = responseBody["data"];

          if (responseData.containsKey("client_secret")) {
            String clientSecret = responseData["client_secret"];

            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: clientSecret,
                merchantDisplayName: "QuickCash",
                style: ThemeMode.light,
              ),
            );

            await Stripe.instance.presentPaymentSheet();

            String transactionId = responseData["id"];
            String status = "succeeded";

            Map<String, dynamic> completeAddMoneyData = {
              "user": AuthManager.getUserId() ?? "",
              "status": status,
              "orderDetails": transactionId,
              "userData": mFromAccountName,
              "account": mFromAccountId ?? "",
              "amount": double.tryParse(mAmountController.text) ?? 0.0,
              "fee": provider.depositFees ?? 0.0,
              "amountText":
                  "$mFromCurrencySymbol${double.tryParse(mAmountController.text) ?? 0.0}",
              "from_currency": mFromCurrency ?? "",
              "to_currency": provider.selectedSendCurrency ?? "",
              "convertedAmount":
                  double.tryParse(provider.conversionAmount!) ?? 0.0,
              "conversionAmountText":
                  "$mFromCurrencySymbol${double.tryParse(provider.conversionAmount!) ?? 0.0}",
            };

            Response completeResponse = await dio.post(
              "https://quickcash.oyefin.com/api/v1/stripe/complete-addmoney",
              data: completeAddMoneyData,
              options: Options(headers: {"Authorization": "Bearer $token"}),
            );

            if (completeResponse.statusCode == 200) {
              CustomSnackBar.showSnackBar(
                context: context,
                message: "Payment and add money completed successfully!",
                color: Colors.green,
              );

              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => HomeScreen()),
                );
              }
            } else {
              throw Exception("Failed to complete add money.");
            }
          } else {
            throw Exception("Failed to retrieve client secret.");
          }
        } else {
          throw Exception("Failed to retrieve client secret.");
        }
      } else {
        throw Exception("Failed to retrieve client secret.");
      }
    } on StripeException catch (e) {
      CustomSnackBar.showSnackBar(
        context: context,
        message: "Stripe Error: ${e.error.localizedMessage}",
        color: Colors.red,
      );
    } catch (error) {
      CustomSnackBar.showSnackBar(
        context: context,
        message: "Payment Failed: $error",
        color: Colors.red,
      );
    } finally {
      isAddLoading = false;
      if (context.mounted) {
        (context as Element).markNeedsBuild();
      }
    }
  }

  Future<void> openRazorpay(BuildContext context) async {
    final provider = Provider.of<AddMoneyProvider>(context, listen: false);
    double amountInDouble =
        double.tryParse(provider.amountCharge ?? '0.0') ?? 0.0;
    int amount = (amountInDouble * 100).toInt();

    try {
      var options = {
        'key': 'rzp_test_TR6pZnguGgK8hQ',
        'amount': amount,
        'name': 'QuickCash',
        'method': 'upi',
        'theme': {'color': "#6F35A5"},
      };
      _razorpay.open(options);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    mAddPaymentSuccess(null, response.paymentId, "succeeded", "Razorpay");
  }

  void _handlePaymentError(
      BuildContext context, PaymentFailureResponse response) {
    // Since this needs context for popup, we'll handle it in UI
    mAddPaymentSuccess(context, " ", "cancelled", "Razorpay");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  Future<void> mAddPaymentSuccess(
      BuildContext?
          context, // Made context optional since success case doesn't need it
      String? paymentId,
      String status,
      String paymentGateway) async {
    final provider = context != null
        ? Provider.of<AddMoneyProvider>(context, listen: false)
        : null;

    isAddLoading = true;
    if (context != null && context.mounted) {
      (context as Element).markNeedsBuild();
    }

    try {
      String amountText = provider != null
          ? '${provider.toCurrencySymbol} ${mAmountController.text}'
          : mAmountController.text;
      String conversionAmountText = provider != null
          ? '$mFromCurrencySymbol ${provider.conversionAmount!}'
          : '';

      final request = AddPaymentSuccessRequest(
          userId: AuthManager.getUserId(),
          status: status,
          paymentId: paymentId!,
          paymentGateway: paymentGateway,
          amount: mAmountController.text,
          fee: provider?.depositFees.toString() ?? "0.0",
          amountText: amountText,
          fromCurrency: provider?.selectedSendCurrency ?? "",
          toCurrency: mFromCurrency!,
          conversionAmount: provider?.conversionAmount ?? "0.0",
          conversionAmountText: conversionAmountText);

      final response =
          await _addPaymentSuccessApi.addPaymentSuccessApi(request);

      if (response.message == "Payment has been done Successfully !!!" &&
          context != null) {
        if (status == 'succeeded' && context.mounted) {
          String totalAmount = provider != null
              ? '${provider.toCurrencySymbol} ${provider.amountCharge}'
              : mAmountController.text;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPaymentSuccessScreen(
                  transactionId: paymentId, amount: totalAmount),
            ),
          );
        }
      }
    } catch (error) {
      if (context != null && context.mounted) {
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Something went wrong!",
            color: kRedColor);
      }
    } finally {
      isAddLoading = false;
      if (context != null && context.mounted) {
        (context as Element).markNeedsBuild();
      }
    }
  }
}
