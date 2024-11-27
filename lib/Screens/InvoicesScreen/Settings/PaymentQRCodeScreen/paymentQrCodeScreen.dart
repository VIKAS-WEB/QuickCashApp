import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/PaymentQRCodeScreen/AddPaymentQRCodeScreen/addPaymentQRCodeScreen.dart';

import '../../../../constants.dart';

class PaymentQRCodeScreen extends StatefulWidget{
  const PaymentQRCodeScreen({super.key});

  @override
  State<PaymentQRCodeScreen> createState() => _PaymentQRCodeScreen();
}

class _PaymentQRCodeScreen extends State<PaymentQRCodeScreen>{

  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: isLoading ? const Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ) : SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 180,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddPaymentQRCodeScreen()),
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
                ),],
            ),),
        )
    );
  }
}