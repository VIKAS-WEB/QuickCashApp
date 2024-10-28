import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({super.key});

  @override
  State<AddQuoteScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  String? selectedValue;
  DateTime? selectedDate; // Variable to hold selected date
  String selectedInvoiceTemplate = 'Default';
  String selectedCurrency = 'Select Currency';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Quote",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: largePadding),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: false,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Invoice #",
                  labelStyle:
                  const TextStyle(color: kPrimaryColor, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: largePadding),
              const Text(
                "Select Type",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio<String>(
                    value: 'member',
                    groupValue: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  const Text('Member', style: TextStyle(color: kPrimaryColor)),
                  Radio<String>(
                    value: 'other',
                    groupValue: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  const Text('Other', style: TextStyle(color: kPrimaryColor)),
                ],
              ),
              const SizedBox(height: largePadding),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: false,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Receiver Name",
                  labelStyle:
                  const TextStyle(color: kPrimaryColor, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: largePadding),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: false,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Receiver Email",
                  labelStyle:
                  const TextStyle(color: kPrimaryColor, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: largePadding),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: false,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Receiver Address",
                  labelStyle:
                  const TextStyle(color: kPrimaryColor, fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: largePadding),
              GestureDetector(
                onTap: () => _selectDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  // Prevent keyboard from appearing
                  child: TextFormField(
                    controller: TextEditingController(
                      text: selectedDate == null
                          ? ''
                          : DateFormat('dd-MM-yyyy').format(selectedDate!),
                    ),
                    decoration: InputDecoration(
                      labelText: "Quote Date*",
                      labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: kPrimaryColor,
                      ), // Add calendar icon here
                    ),
                  ),
                ),
              ),


              const SizedBox(height: largePadding),
              GestureDetector(
                onTap: () => _selectDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  // Prevent keyboard from appearing
                  child: TextFormField(
                    controller: TextEditingController(
                      text: selectedDate == null
                          ? ''
                          : DateFormat('dd-MM-yyyy').format(selectedDate!),
                    ),
                    decoration: InputDecoration(
                      labelText: "Due Date*",
                      labelStyle:
                      const TextStyle(color: kPrimaryColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        color: kPrimaryColor,
                      ), // Add calendar icon here
                    ),
                  ),
                ),
              ),

              // Invoice Template
              const SizedBox(height: largePadding),
              DropdownButtonFormField<String>(
                value: selectedInvoiceTemplate,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: 'Invoice Template',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),

                items: ['Default','New York', 'Toronto', 'Rio', 'London', 'Istanbul', 'Mumbai', 'Hong Kong', 'Tokyo', 'Paris'].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedInvoiceTemplate = newValue!;
                  });
                },
              ),



              // Select Currency
              const SizedBox(height: largePadding),
              DropdownButtonFormField<String>(
                value: selectedCurrency,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: 'Select Currency',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),

                items: ['Select Currency', 'USD', 'INR', 'EUR'].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                  });
                },
              ),



              // Update Button
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

                  },
                  child: const Text('Add', style: TextStyle(color: Colors.white,fontSize: 16)),
                ),
              ),

              const SizedBox(height: 35),

            ],
          ),
        ),
      ),
    );
  }

}
