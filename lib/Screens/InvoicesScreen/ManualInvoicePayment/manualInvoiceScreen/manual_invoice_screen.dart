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

class _ManualInvoiceScreenState extends State<ManualInvoiceScreen> {
  final ManualInvoicesApi _manualInvoicesApi = ManualInvoicesApi();
  final DeleteInvoiceApi _deleteInvoiceApi = DeleteInvoiceApi();
  List<ManualInvoiceData> manualInvoiceList =[];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    mManualInvoice("Yes");
    super.initState();
  }

  Future<void> mManualInvoice(String s) async {
    setState(() {
      if(s == "Yes"){
        isLoading = true;
        errorMessage = null;
      }else{
        isLoading = false;
        errorMessage = null;
      }
    });

    try{
      final response = await _manualInvoicesApi.manualInvoiceApi();

      if(response.manualInvoiceList !=null && response.manualInvoiceList!.isNotEmpty){
        setState(() {
          isLoading = false;
          errorMessage = null;
          manualInvoiceList = response.manualInvoiceList!;
        });
      } else{
        setState(() {
          isLoading = false;
          errorMessage = 'No Manual Invoices List';
          CustomSnackBar.showSnackBar(context: context, message: "No Invoices List", color: kPrimaryColor);
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
        CustomSnackBar.showSnackBar(context: context, message: errorMessage!, color: kRedColor);
      });
    }
  }

  // Manual Invoice Delete Api ------------------
  Future<void> mManualInvoiceDelete(String? manualInvoiceId) async{
    try{

      final response = await _deleteInvoiceApi.deleteInvoiceApi(manualInvoiceId!);

      if(response.message == ""){
        setState(() {
          Navigator.of(context).pop(true);
          mManualInvoice("No");
          CustomSnackBar.showSnackBar(context: context, message: "Payment deleted successfully!", color: kGreenColor);
        });
      }else{
        setState(() {
          Navigator.of(context).pop(true); // Yes
          CustomSnackBar.showSnackBar(context: context, message: "We are facing some issue!", color: kGreenColor);
        });
      }

    }catch (error) {
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
        child: Padding(padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

               /* Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kHintColor,

                    onSaved: (value){

                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultPadding),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Search",
                      hintStyle: const TextStyle(color: kHintColor),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.search,color: kHintColor,),
                      ),
                    ),
                  ),
                ),*/

                const SizedBox(width: defaultPadding,),

                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddManualPaymentScreen()),
                    );
                  },
                  child: const Icon(Icons.add,color: kPrimaryColor,),
                ),
              ],
            ),

            const SizedBox(height: largePadding,),

            isLoading ? const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ) :ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: manualInvoiceList.length,
              itemBuilder: (context, index) {
                final manualInvoice = manualInvoiceList[index];

                // Accessing clientInfo with null and empty checks
                String clientName = 'Unknown';
                if (manualInvoice.clientInfo != null && manualInvoice.clientInfo!.isNotEmpty) {
                  clientName = manualInvoice.clientInfo![0].name ?? 'Unknown';
                }

                // Accessing invoiceDetails with null and empty checks
                String invoiceNumber = 'Unknown';
                if (manualInvoice.invoiceDetails != null && manualInvoice.invoiceDetails!.isNotEmpty) {
                  invoiceNumber = manualInvoice.invoiceDetails![0].invoiceNumber ?? 'Unknown';
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding), // Add spacing
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
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                mDeleteManualInvoiceDialog(manualInvoice.id);
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
        ),),
      ),
    );
  }

  Future<bool> mDeleteManualInvoiceDialog(String? manualInvoiceId) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Payment"),
        content: const Text("Do you really want to delete this invoice?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              mManualInvoiceDelete(manualInvoiceId);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ?? false;
  }

}

void mViewPayments(BuildContext context, ManualInvoiceData manualInvoice) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ViewPayments(manualInvoice: manualInvoice); // Pass the selected invoice
    },
  );
}

class ViewPayments extends StatefulWidget {
  final ManualInvoiceData manualInvoice;

  const ViewPayments({super.key, required this.manualInvoice});

  @override
  State<ViewPayments> createState() => _ViewPaymentsState();
}

class _ViewPaymentsState extends State<ViewPayments> {
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
    final manualInvoice = widget.manualInvoice; // Access the passed invoice data

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transaction Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: kPrimaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Display Client Name
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),
              initialValue: manualInvoice.clientInfo?.first.name ?? 'N/A',
              decoration: InputDecoration(
                labelText: "Name",
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

            // Display Client Email
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),
              initialValue: manualInvoice.clientInfo?.first.email ?? 'N/A',
              decoration: InputDecoration(
                labelText: "Email",
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

            // Display Payment Amount
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),
              initialValue: '${manualInvoice.amountCurrencyText} ${manualInvoice.amount ?? 'N/A'}',
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
            ),
            const SizedBox(height: defaultPadding),

            // Display Payment Date
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),
              initialValue: formatDate(manualInvoice.paymentDate),
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

            // Display Notes
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              readOnly: true,
              maxLines: 12,
              minLines: 6,
              style: const TextStyle(color: kPrimaryColor),
              initialValue: manualInvoice.notes ?? 'N/A',
              decoration: InputDecoration(
                labelText: "Notes",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}



