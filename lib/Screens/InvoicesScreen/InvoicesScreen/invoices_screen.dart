import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class Invoices {
  late final String invoicedNumber;
  late final String invoicedDate;
  late final String dueDate;
  late final String amount;
  late final String transaction;
  late final String status;

  Invoices({
    required this.invoicedNumber,
    required this.invoicedDate,
    required this.dueDate,
    required this.amount,
    required this.transaction,
    required this.status,
});

}

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final List<Invoices> invoiceList = [

    Invoices(
        invoicedNumber: 'ITIO912035585789',
        invoicedDate: '29-10-2024',
        dueDate: '22-11-2024',
        amount: '1008',
        transaction: '10008',
        status: 'Partial',
    ),
    Invoices(
      invoicedNumber: 'ITIO912035585789',
      invoicedDate: '30-10-2024',
      dueDate: '23-11-2024',
      amount: '100128',
      transaction: '1044008',
      status: 'Unpaid',
    ),


    // You can add more card entries here
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case 'Unpaid':
        return Colors.red;
      case 'Partial':
        return Colors.pink;
      default:
        return kPrimaryColor; // Default color if status is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Invoices",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: largePadding,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: invoiceList.length,
                itemBuilder: (context, index) {
                  final invoiceLists = invoiceList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding),
                    // Add spacing
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
                              const Text(
                                'Invoice Number:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                invoiceLists.invoicedNumber,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          const Divider(
                            color: kPrimaryLightColor,
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Invoice Date:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                invoiceLists.invoicedDate,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          const Divider(
                            color: kPrimaryLightColor,
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Due Date:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                invoiceLists.dueDate,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          const Divider(
                            color: kPrimaryLightColor,
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Amount:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                invoiceLists.amount,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: smallPadding,
                          ),
                          const Divider(
                            color: kPrimaryLightColor,
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Transaction:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                invoiceLists.transaction,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: smallPadding,
                          ),
                          const Divider(
                            color: kPrimaryLightColor,
                          ),
                          const SizedBox(
                            height: smallPadding,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Status:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              FilledButton.tonal(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(_getStatusColor(invoiceLists.status,)),
                                ),
                                child: Text(invoiceLists.status, style: const TextStyle(color: Colors.white,fontSize: 15)),
                              ),
                            ],
                          ),


                          const SizedBox(
                            height: smallPadding,
                          ),
                          const Divider(
                            color: kPrimaryLightColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Expanded(
                                  child: Text("Action:",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                              IconButton(
                                icon: const Icon(
                                  Icons.link,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Invoice URL Copied!')),
                                  );
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ViewProductScreen()),
                                  );*/
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.watch_later_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Reminder has been sent on email address')),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.auto_mode,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _startRecurringDialog();
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


  Future<void> _startRecurringDialog() async {

    String selectedRecurring = 'Select Recurring';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recurring'),
          content: Form( // Wrap in Form to enable validation
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: largePadding),
                DropdownButtonFormField<String>(
                  value: selectedRecurring,
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                    labelText: 'Recurring',
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  items: [
                    'Select Recurring',
                    'Day',
                    'Weekly',
                    'Monthly',
                    'Half Yearly',
                    'Yearly',
                  ].map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category, style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedRecurring = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == 'Select Category') {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {

                 if(selectedRecurring == "Select Recurring") {
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Please select a recurring option')));
                 }else{
                   ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Recurring Selected')));
                   Navigator.of(context).pop();
                 }

              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }





}
