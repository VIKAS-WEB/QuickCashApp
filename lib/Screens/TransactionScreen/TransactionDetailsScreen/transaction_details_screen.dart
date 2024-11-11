import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/TransactionScreen/TransactionDetailsScreen/model/transactionDetailsApi.dart';
import 'package:quickcash/constants.dart';

class TransactionDetailPage extends StatefulWidget {
  final String? transactionId;
  const TransactionDetailPage({super.key, this.transactionId});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  final TransactionDetailsListApi _transactionDetailsListApi = TransactionDetailsListApi();

  String? transactionId;
  String? requestDate;
  int? fee;
  int? billAmount;
  String? transactionType;
  String? extraType;

  String? senderName;
  String? senderAccountNo;
  String? senderAddress;

  String? receiverName;
  String? receiverAccountNo;
  String? receiverAddress;
  String? status;

  String? transactionAmount;

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mTransactionDetails();
  }

  Future<void> mTransactionDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _transactionDetailsListApi.transactionDetailsListApi(widget.transactionId!);

      setState(() {
        isLoading = false;


        transactionId = response.trx;
        fee = response.fee;
        billAmount = (response.billAmount! + fee!);
        transactionType = response.transactionType;
        extraType = response.extraType;


        senderName = response.senderDetail?.first.senderName;
        senderAccountNo = response.senderDetail?.first.senderAccountNumber;
        senderAddress = response.senderDetail?.first.senderAddress;

        receiverName = response.receiverDetail?.first.receiverName;
        receiverAccountNo = response.receiverDetail?.first.receiverAccountNumber;
        receiverAddress = response.receiverDetail?.first.receiverAddress;

        status = response.status;


        // Convert the input date string to a DateTime object
        DateTime dateTime = DateTime.parse(response.requestedDate!);

        // Format the DateTime object into the desired string format
        requestDate = DateFormat('yyyy-MM-dd hh:mm:ss:a').format(dateTime);
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        // Change back button color here
        title: const Text(
          "Transaction Details",
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
        // Added ScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),

              if (errorMessage != null)
                Text(errorMessage!,
                    style: const TextStyle(color: Colors.red)),

              const SizedBox(
                height: defaultPadding,
              ),

              Card(
                color: kPrimaryColor,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Transaction Details",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Trans ID:", style: TextStyle(color: Colors.white)),
                          Text(transactionId ?? " ", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Requested Date:", style: TextStyle(color: Colors.white)),
                          Text(requestDate ?? " ", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Fee:", style: TextStyle(color: Colors.white)),
                          Text((fee ?? 0).toString(), style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Bill Amount:", style: TextStyle(color: Colors.white)),
                          Text((billAmount ?? 0).toString(), style: const TextStyle(color: Colors.white)),

                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Type:", style: TextStyle(color: Colors.white)),
                          Text('${extraType!} - ${transactionType!}', style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: kPrimaryColor,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: <Widget>[
                      const Center(
                        child: Text(
                          "Sender Information",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Sender Name:", style: TextStyle(color: Colors.white)),
                          Text(senderName ?? "", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Account No:", style: TextStyle(color: Colors.white)),
                          Text(senderAccountNo ?? "", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Sender Address:", style: TextStyle(color: Colors.white)),
                          Text(senderAddress ?? "", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: kPrimaryColor,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Receiver Information",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Receiver Name:", style: TextStyle(color: Colors.white)),
                          Text(receiverName!, style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Account Number:", style: TextStyle(color: Colors.white)),
                          Text(receiverAccountNo!, style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Receiver Address:", style: TextStyle(color: Colors.white)),
                          Text(receiverAddress!, style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Status:", style: TextStyle(color: Colors.white)),
                          FilledButton.tonal(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child:  Text(status!, style: const TextStyle(color: Colors.green)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                color: kPrimaryColor,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "Bank Status",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Bank TransID:", style: TextStyle(color: Colors.white)),
                          Text(transactionId ?? " ", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trans Amt:", style: TextStyle(color: Colors.white)),
                          Text("₹800", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Settlement Date:", style: TextStyle(color: Colors.white)),
                          Text(requestDate ?? "", style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Transaction Status:", style: TextStyle(color: Colors.white)),
                          FilledButton.tonal(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                            ),
                            child: Text(status!, style: const TextStyle(color: Colors.green)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
