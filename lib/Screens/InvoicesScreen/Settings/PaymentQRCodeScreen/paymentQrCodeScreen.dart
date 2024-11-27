import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/PaymentQRCodeScreen/AddPaymentQRCodeScreen/addPaymentQRCodeScreen.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/PaymentQRCodeScreen/PaymentQRCodeDetailsModel/paymentQRCodeDetailModel.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/PaymentQRCodeScreen/PaymentQRCodeDetailsModel/paymentQRCodeDetailsApi.dart';

import '../../../../constants.dart';
import '../../../../util/apiConstants.dart';
import '../../../../util/customSnackBar.dart';

class PaymentQRCodeScreen extends StatefulWidget {
  const PaymentQRCodeScreen({super.key});

  @override
  State<PaymentQRCodeScreen> createState() => _PaymentQRCodeScreen();
}

class _PaymentQRCodeScreen extends State<PaymentQRCodeScreen> {
  final QRCodeDetailsApi _qrCodeDetailsApi = QRCodeDetailsApi();
  List<QRCodeDetailsItem> qrCodeDetailsList = [];

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    mQRCodeDetails("Yes");
    super.initState();
  }

  Future<void> mQRCodeDetails(String s) async {
    setState(() {
      if (s == "Yes") {
        isLoading = true;
        errorMessage = null;
      }
    });

    try {
      final response = await _qrCodeDetailsApi.qrCodeDetailsApi();

      if (response.qrCodeDetailsList != null &&
          response.qrCodeDetailsList!.isNotEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          qrCodeDetailsList = response.qrCodeDetailsList!;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No QR-Code List';
          CustomSnackBar.showSnackBar(
              context: context, message: "No Tax List", color: kPrimaryColor);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
        CustomSnackBar.showSnackBar(
            context: context, message: errorMessage!, color: kRedColor);
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
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 180,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddPaymentQRCodeScreen()),
                      );
                    },
                    backgroundColor: kPrimaryColor,
                    label: const Text(
                      'Add QR Code',
                      style: TextStyle(color: kWhiteColor, fontSize: 15),
                    ),
                    icon: const Icon(Icons.add, color: kWhiteColor),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: qrCodeDetailsList.length,
                    itemBuilder: (context, index) {
                      final qrCodeDetails = qrCodeDetailsList[index];
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
                                  const Text(
                                    'Date:',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Text(formatDate(qrCodeDetails.createdAt),
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: smallPadding),
                              const Divider(color: kPrimaryLightColor),
                              const SizedBox(height: smallPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Name:',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Text(qrCodeDetails.title!,
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: smallPadding),
                              const Divider(color: kPrimaryLightColor),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Image:',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  ClipOval(
                                    child: Image.network('${ApiConstants.baseQRCodeImageUrl}${qrCodeDetails.image}',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover, // Ensure the image fills the circle
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: kPrimaryLightColor),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Default:',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Switch(
                                    value: qrCodeDetails.isDefaultSwitch, // Use the updated value
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        qrCodeDetails.isDefaultSwitch = newValue; // Update the switch state for this specific item
                                      });
                                    },
                                    activeColor: kPurpleColor,
                                  ),
                                ],
                              ),

                              const Divider(color: kPrimaryLightColor),

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
                                             /* Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateTaxScreen(taxId: taxDetails.id,taxName: taxDetails.name, taxValue: taxDetails.taxValue, taxType: taxDetails.isDefault)),
                                              );*/
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
                                              Icons.delete_outline,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                            //  mDeleteTaxDialog(taxDetails.id);
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
                                        width: defaultPadding,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    ));
  }
}
