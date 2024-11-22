import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/AddQuoteScreen/add_quote_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

import '../InvoicesScreen/Invoices/invoiceModel/invoicesModel.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  //Temp
  List<InvoicesData> quotesList = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: kWhiteColor),
        title: const Text(
          "Quotes",
          style: TextStyle(color: kWhiteColor),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const AddQuoteScreen()),
                        );
                      },
                      backgroundColor: kPrimaryColor,
                      label: const Text(
                        'Add Quotes',
                        style:
                        TextStyle(color: kWhiteColor, fontSize: 15),
                      ),
                      icon: const Icon(Icons.add, color: kWhiteColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quotesList.length,
                itemBuilder: (context, index) {
                  final quotes = quotesList[index];
                  return Padding(
                    padding: const EdgeInsets.all(defaultPadding),
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
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quote Number:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '564512545112515',
                                style: TextStyle(
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
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quote Date:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '22-11-2024',
                                style: TextStyle(
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
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Due Date:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '23-11-2024',
                                style: TextStyle(
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
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Amount:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '545',
                                style: TextStyle(
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
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                'Created',
                                style: TextStyle(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // IconButton with text
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  // Conditionally show the Edit icon based on status
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          CustomSnackBar.showSnackBar(
                                              context: context,
                                              message: "Edit",
                                              color: kPrimaryColor);
                                        },
                                      ),
                                      const Text(
                                        'Edit',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    width: smallPadding,
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.link,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          copyQuoteUrl("url");
                                        },
                                      ),
                                      const Text(
                                        'Quote URL',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: smallPadding,
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          mDeleteInvoiceDialog("quoteId");
                                        },
                                      ),
                                      const Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    width: smallPadding,
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          CustomSnackBar.showSnackBar(
                                              context: context,
                                              message: "Reminder",
                                              color: kPrimaryColor);
                                        },
                                      ),
                                      const Text(
                                        'Reminder',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: smallPadding,
                                  ),
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

  Future<bool> mDeleteInvoiceDialog(String? quoteId) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Quote"),
        content: const Text("Do you really want to delete this quote?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
             // mDeleteInvoice(invoiceId);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ?? false;
  }

  void copyQuoteUrl(String? url) {
    if (url != null) {
      Clipboard.setData(ClipboardData(text: url)).then((_) {
        CustomSnackBar.showSnackBar(
          context: context,
          message: 'Quote URL Copied!',
          color: kPrimaryColor,
        );
      });
    } else {
      // Show an error or handle the case when referralLink is null
      CustomSnackBar.showSnackBar(
        context: context,
        message: 'Quote URL is not available!',
        color: Colors.red,
      );
    }
  }

}
