import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/AddQuoteScreen/add_quote_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/QuotesScreen/quoteModel/quotesApi.dart';
import 'package:quickcash/Screens/InvoicesScreen/QuotesScreen/quoteModel/quotesModel.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final QuoteApi _quoteApi = QuoteApi();

  List<QuoteData> quotesList = [];
  bool isLoading = false;
  String? errorMessage;


  @override
  void initState() {
    mQuote();
    super.initState();
  }

  Future<void> mQuote() async{
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final response = await _quoteApi.quoteApi();

      if(response.quoteList !=null && response.quoteList!.isNotEmpty){
        setState(() {
          isLoading = false;
          errorMessage = null;
          quotesList = response.quoteList!;
        });
      }else{
        setState(() {
          isLoading = false;
          errorMessage = 'No Quote List';
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
                height: largePadding,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quotesList.length,
                itemBuilder: (context, index) {
                  final quotes = quotesList[index];
                  return Padding(
                    padding: const EdgeInsets.all(0),
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quote Number:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                quotes.quoteNumber ?? 'N/A',
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quote Date:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                formatDate(quotes.invoiceDate),
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Due Date:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                formatDate(quotes.dueDate),
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Amount:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                '${quotes.currencyText} ${quotes.total}',
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Status:',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                (quotes.status != null && quotes.status!.isNotEmpty)
                                    ? quotes.status![0].toUpperCase() + quotes.status!.substring(1)
                                    : '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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
