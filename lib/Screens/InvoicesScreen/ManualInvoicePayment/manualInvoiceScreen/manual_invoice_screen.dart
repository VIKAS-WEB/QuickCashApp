import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoicesScreen/Invoices/invoiceDeleteModel/invoiceDeleteApi.dart';
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/AddManualPaymentScreen/add_manual_payment_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/manualInvoiceScreen/model/manualInvoiceModel.dart';
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/manualInvoiceScreen/model/manualinvoiceApi.dart';
import 'package:quickcash/constants.dart';

import '../../../../util/customSnackBar.dart';

class ManualInvoiceScreen extends StatefulWidget {
  const ManualInvoiceScreen({super.key});

  @override
  State<ManualInvoiceScreen> createState() => _ManualInvoiceScreenState();
}

class _ManualInvoiceScreenState extends State<ManualInvoiceScreen> with WidgetsBindingObserver {
  final ManualInvoicesApi _manualInvoicesApi = ManualInvoicesApi();
  final DeleteInvoiceApi _deleteInvoiceApi = DeleteInvoiceApi();
  List<ManualInvoiceData> manualInvoiceList = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mManualInvoice("Yes");

    // Add the lifecycle observer
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the lifecycle observer when the widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    print("object1");
    super.dispose();
  }

 /* // Lifecycle state change handler
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // The app is resumed (similar to onResume in Android)
      print("App resumed");
      mManualInvoice("Yes"); // You can refresh your data here if needed
    }
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // The app has moved to the background (similar to `onPause()` in Android)
      print("ScreenA: App is in background");
    } else if (state == AppLifecycleState.resumed) {
      // The app has come back to the foreground (similar to `onResume()` in Android)
      print("ScreenA: App is in foreground");
    }
  }

  Future<void> mManualInvoice(String s) async {
    setState(() {
      if (s == "Yes") {
        isLoading = true;
        errorMessage = null;
      } else {
        isLoading = false;
        errorMessage = null;
      }
    });

    try {
      final response = await _manualInvoicesApi.manualInvoiceApi();

      if (response.manualInvoiceList != null && response.manualInvoiceList!.isNotEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          manualInvoiceList = response.manualInvoiceList!;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Manual Invoices List';
          CustomSnackBar.showSnackBar(context: context, message: "No Invoices List", color: kPrimaryColor);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
        CustomSnackBar.showSnackBar(context: context, message: errorMessage!, color: kRedColor);
      });
    }
  }

  // Manual Invoice Delete Api ------------------
  Future<void> mManualInvoiceDelete(String? manualInvoiceId) async {
    try {
      final response = await _deleteInvoiceApi.deleteInvoiceApi(manualInvoiceId!);

      if (response.message == "") {
        setState(() {
          Navigator.of(context).pop(true);
          mManualInvoice("No");
          CustomSnackBar.showSnackBar(context: context, message: "Payment deleted successfully!", color: kGreenColor);
        });
      } else {
        setState(() {
          Navigator.of(context).pop(true); // Yes
          CustomSnackBar.showSnackBar(context: context, message: "We are facing some issue!", color: kGreenColor);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
        CustomSnackBar.showSnackBar(context: context, message: errorMessage!, color: kRedColor);
      });
    }
  }

  // Function to format the date
  String formatDate(String? dateTime) {
    if (dateTime == null) {
      return 'Date not available';
    }
    DateTime date = DateTime.parse(dateTime);
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Manual Payment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: defaultPadding),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddManualPaymentScreen()),
                      );
                    },
                    child: const Icon(Icons.add, color: kPrimaryColor),
                  ),
                ],
              ),
              const SizedBox(height: largePadding),
              isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: manualInvoiceList.length,
                itemBuilder: (context, index) {
                  final manualInvoice = manualInvoiceList[index];

                  String clientName = 'Unknown';
                  if (manualInvoice.clientInfo != null && manualInvoice.clientInfo!.isNotEmpty) {
                    clientName = manualInvoice.clientInfo![0].name ?? 'Unknown';
                  }

                  String invoiceNumber = 'Unknown';
                  if (manualInvoice.invoiceDetails != null && manualInvoice.invoiceDetails!.isNotEmpty) {
                    invoiceNumber = manualInvoice.invoiceDetails![0].invoiceNumber ?? 'Unknown';
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Invoices:', style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text('$clientName $invoiceNumber', style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: smallPadding),
                          const Divider(color: kPrimaryLightColor),
                          const SizedBox(height: smallPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Payment Date:', style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text(formatDate(manualInvoice.paymentDate), style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: smallPadding),
                          const Divider(color: kPrimaryLightColor),
                          const SizedBox(height: smallPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Amount:', style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text('${manualInvoice.amountCurrencyText} ${manualInvoice.amount}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: smallPadding),
                          const Divider(color: kPrimaryLightColor),
                          const SizedBox(height: smallPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Expanded(child: Text("Action:", style: TextStyle(color: Colors.white, fontSize: 16))),
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                                onPressed: () {
                                  mViewPayments(context, manualInvoice);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> mViewPayments(BuildContext context, ManualInvoiceData manualInvoice) {
    // Implementation for viewing payments
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Do you want to delete this Invoice?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              mManualInvoiceDelete(manualInvoice.id);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
