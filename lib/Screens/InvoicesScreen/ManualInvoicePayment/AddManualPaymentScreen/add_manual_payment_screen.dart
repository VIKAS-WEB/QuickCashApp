import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this for date formatting
import 'package:quickcash/constants.dart';

class AddManualPaymentScreen extends StatefulWidget {
  const AddManualPaymentScreen({super.key});

  @override
  State<AddManualPaymentScreen> createState() => _AddManualPaymentScreenState();
}

class _AddManualPaymentScreenState extends State<AddManualPaymentScreen> {
  final TextEditingController _dateController = TextEditingController();
  String selectedInvoice = 'Select Invoice';

  @override
  void initState() {
    super.initState();
    // Set the current date in the TextEditingController
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _dateController.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Manual Payment",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: largePadding,),
              DropdownButtonFormField<String>(
                value: selectedInvoice,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: 'Invoice',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                items: [
                  'Select Invoice',
                  'ITIO5545555',
                  'ITIO336666666',
                ].map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category, style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedInvoice = newValue!;
                  });
                },
                validator: (value) {
                  if (value == 'Select Category') {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),


              const SizedBox(height: defaultPadding,),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: "Due Amount",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                initialValue: '₹1008',
              ),

              const SizedBox(height: defaultPadding,),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: "Paid Amount",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                initialValue: '₹10508',
              ),


              const SizedBox(height: largePadding),
              TextFormField(
                controller: _dateController, // Use the controller here
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
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),

              const SizedBox(height: defaultPadding,),
              TextFormField(
                keyboardType: TextInputType.number,
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

              const SizedBox(height: defaultPadding,),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: "Payment Mode",
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide()
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                initialValue: 'CASH',
              ),


              const SizedBox(height: largePadding),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                minLines: 6,
                maxLines: 12,
                decoration: InputDecoration(
                  labelText: "Notes",
                  labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a notes';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //....
                  },
                  child: const Text('Pay', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

              const SizedBox(height: defaultPadding,),

            ],
          ),
        ),
      ),
    );
  }
}
