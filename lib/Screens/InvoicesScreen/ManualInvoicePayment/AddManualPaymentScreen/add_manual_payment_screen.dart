import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/AddManualPaymentScreen/getManualPaymentDataModel/getManualPaymentApi.dart';
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/AddManualPaymentScreen/getManualPaymentDataModel/getManualPaymentModel.dart';
import 'package:quickcash/constants.dart';

import '../../../../util/customSnackBar.dart';

class AddManualPaymentScreen extends StatefulWidget {
  const AddManualPaymentScreen({super.key});

  @override
  State<AddManualPaymentScreen> createState() => _AddManualPaymentScreenState();
}

class _AddManualPaymentScreenState extends State<AddManualPaymentScreen> {
  final GetManualPaymentApi _getManualPaymentApi = GetManualPaymentApi();
  final TextEditingController _dateController = TextEditingController();
  String? selectedInvoice = 'Select Invoice'; // Default value

  List<GetManualPaymentData> manualPaymentDetailsList = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mGetManualPaymentDetails();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> mGetManualPaymentDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _getManualPaymentApi.getManualPaymentDetailsApi();

      if (response.getManualPaymentList != null && response.getManualPaymentList!.isNotEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          manualPaymentDetailsList = response.getManualPaymentList!;
          // No need to change selectedInvoice as 'Select Invoice' should be the default
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No data';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Manual Payment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: largePadding),
              DropdownButtonFormField<String?>(
                value: selectedInvoice,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: 'Invoice',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                items: [
                  'Select Invoice', // Default value
                  ...manualPaymentDetailsList
                      .map((payment) => payment.invoiceNumber)
                ].map((String? invoice) {
                  return DropdownMenuItem<String?>(
                    value: invoice,
                    child: Text(invoice ?? '', style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedInvoice = newValue;
                  });
                },
                validator: (value) {
                  if (value == 'Select Invoice') {
                    return 'Please select an invoice';
                  }
                  return null;
                },
              ),

              const SizedBox(height: defaultPadding),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Due Amount",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Paid Amount",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: largePadding),
              TextFormField(
                controller: _dateController, // Use the controller here
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Payment Date",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: defaultPadding),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Payment Mode",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                initialValue: 'CASH', // Replace this with actual dynamic value if available
              ),
              const SizedBox(height: largePadding),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                minLines: 6,
                maxLines: 12,
                decoration: InputDecoration(
                  labelText: "Notes",
                  labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a note';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Implement your logic for the Pay button here
                  },
                  child: const Text('Pay', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}
