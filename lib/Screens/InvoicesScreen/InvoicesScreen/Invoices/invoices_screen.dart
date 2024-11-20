import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoicesScreen/UpdateInvoiceScreen/update_invoice_screen.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

import 'model/invoicesApi.dart';
import 'model/invoicesModel.dart';


class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final InvoicesApi _invoicesApi = InvoicesApi();
  List<InvoicesData> invoiceList = [];
  
  bool isLoading = true;
  String? errorMessage;

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
      case 'paid':
        return kGreenColor;
      case 'Unpaid':
      case 'unpaid':
        return kRedColor;
      case 'Partial':
      case 'partial':
        return Colors.purpleAccent;
      default:
        return kPrimaryColor;
    }
  }
  
  @override
  void initState() {
    mInvoicesApi();
    super.initState();
  }
  
  
  // Invoices Api -------
  Future<void> mInvoicesApi() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    
    try{
      
      final response = await _invoicesApi.invoicesApi();
      
      if(response.invoicesList !=null && response.invoicesList!.isNotEmpty){
        setState(() {
          isLoading = false;
          errorMessage = null;
          invoiceList = response.invoicesList!;
        });
      }else{
        setState(() {
          isLoading = false;
          errorMessage = 'No Invoices List';
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
          "Invoices",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      ) : SingleChildScrollView(
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
                                invoiceLists.invoiceNumber!,
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
                                formatDate(invoiceLists.createdAt),
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
                                formatDate(invoiceLists.dueDate),
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
                              Text("${invoiceLists.currencyText} ${invoiceLists.total}",
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
                              Text("${invoiceLists.currencyText} ${invoiceLists.paidAmount}",
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
                                  backgroundColor: WidgetStateProperty.all(_getStatusColor(invoiceLists.status!)),
                                  elevation: WidgetStateProperty.resolveWith<double>((states) {
                                    if (states.contains(WidgetState.pressed)) {
                                      return 4; // Higher elevation when pressed
                                    }
                                    return 4; // Default elevation
                                  }),
                                ),
                                child: Text(
                                  '${invoiceLists.status![0].toUpperCase()}${invoiceLists.status!.substring(1)}',
                                  style: const TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              )

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
                              // IconButton with text
                            Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Conditionally show the Edit icon based on status
                              if (invoiceLists.status == 'Unpaid' || invoiceLists.status == 'unpaid') ...[
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const UpdateInvoiceScreen()),
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Edit',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: smallPadding,),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Deleted!')),
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],

                              const SizedBox(width: smallPadding,),

                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.link,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Invoice URL Copied!')),
                                      );
                                    },
                                  ),
                                  const Text(
                                    'Invoice URL',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(width: smallPadding,),
                              Column(
                                children: [
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
                                  const Text(
                                    'Reminder',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(width: smallPadding,),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.auto_mode,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _startRecurringDialog();
                                    },
                                  ),
                                  const Text(
                                    'Start Recurring',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(width: smallPadding,),
                            ],
                          ),

                            ],
                          )

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
