import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/TaxScreen/AddTaxScreen/AddTaxScreen.dart';

import '../../../../constants.dart';

class TaxScreen extends StatefulWidget{
  const TaxScreen({super.key});

  @override
  State<TaxScreen> createState() => _TaxScreen();

}

class _TaxScreen extends State<TaxScreen>{

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
                  width: 150,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTaxScreen()),
                      );
                    },
                    backgroundColor: kPrimaryColor,
                    label: const Text(
                      'Add Tax',
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