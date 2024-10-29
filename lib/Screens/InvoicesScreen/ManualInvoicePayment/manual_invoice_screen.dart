import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/AddManualPaymentScreen/add_manual_payment_screen.dart';
import 'package:quickcash/constants.dart';

class ManualInvoiceScreen extends StatefulWidget {
  const ManualInvoiceScreen({super.key});

  @override
  State<ManualInvoiceScreen> createState() => _ManualInvoiceScreenState();
}

class _ManualInvoiceScreenState extends State<ManualInvoiceScreen> {

  final List<Map<String, String>> clientsList = [
    {
      'invoices': 'Ganesh ITIOXX9X9O18958',
      'paymentDate': '2024-10-20',
      'amount': '1008',
    },
    {
      'invoices': 'Ganesh ITIOXX9X9O1895558',
      'paymentDate': '2024-10-22',
      'amount': '108',
    },
    // You can add more card entries here
  ];

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

                Expanded(
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
                ),

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

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: clientsList.length,
              itemBuilder: (context, index) {
                final card = clientsList[index];
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
                            const Text('Invoices:', style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['invoices']}', style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Payment Date:',style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['paymentDate']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Amount:',style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text('${card['amount']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                          ],
                        ),

                        const SizedBox(height: smallPadding,),
                        const Divider(color: kPrimaryLightColor,),
                        const SizedBox(height: smallPadding,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Expanded(child: Text("Action:",style: TextStyle(color: Colors.white, fontSize: 16))),

                            IconButton(
                              icon: const Icon(Icons.remove_red_eye, color: Colors.white,),
                              onPressed: () {
                                mViewPayments(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                _showDeleteClientDialog();
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

  Future<bool> _showDeleteClientDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Payment"),
        content: const Text("Do you really want to delete this payment?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Yes
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Payment deleted successfully!"),
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ?? false;
  }

}

void mViewPayments(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const ViewPayments(); // Use the new StatefulWidget
    },
  );
}


class ViewPayments extends StatefulWidget {
  const ViewPayments({super.key});

  @override
  State<ViewPayments>  createState() => _ViewPaymentsState();
}

class _ViewPaymentsState extends State<ViewPayments> {

  @override
  Widget build(BuildContext context) {
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
                  'View Product',
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

            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (value){},
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),

              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide()
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: defaultPadding),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (value) {},
              readOnly: true,
              style: const TextStyle(color: kPrimaryColor),

              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide()
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: defaultPadding),
            TextFormField(
              keyboardType: TextInputType.text,
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
                    borderSide: const BorderSide()
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: defaultPadding),
            TextFormField(
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
                    borderSide: const BorderSide()
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),

            const SizedBox(height: defaultPadding),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (value) {},
              readOnly: true,
              maxLines: 12,
              minLines: 6,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "Notes",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide()
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



