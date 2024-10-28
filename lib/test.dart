import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:quickcash/constants.dart';

class AddInvoiceScreen extends StatefulWidget {
  const AddInvoiceScreen({super.key});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  String? selectedValue;
  DateTime? selectedDate; // Variable to hold selected date
  String selectedStatus = 'Select Status';
  String selectedInvoiceTemplate = 'Default';
  String selectedPaymentQR = 'Payment QR Code';
  String selectedRecurringCycle = 'Day';
  String selectedCurrency = 'Select Currency';
  String selectedProduct = 'Select Product';
  String selectedDiscount = 'Select Discount';
  String selectedTax = 'Select Tax';

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
          "Add Invoice",
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
                      labelText: "Invoice Date*",
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

              // Status
              const SizedBox(height: largePadding),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: 'Status',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),

                items: ['Select Status','Paid', 'Unpaid', 'Partially Paid', 'Overdue', 'Processing'].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedStatus = newValue!;
                  });
                },
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


              // Payment QR Code
              const SizedBox(height: largePadding),
              DropdownButtonFormField<String>(
                value: selectedPaymentQR,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: 'Payment QR Code',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),

                items: ['Payment QR Code',].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedPaymentQR = newValue!;
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

              const SizedBox(height: largePadding),
              const Text(
                "Recurring",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Radio<String>(
                    value: 'yes',
                    groupValue: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  const Text('Yes', style: TextStyle(color: kPrimaryColor)),
                  Radio<String>(
                    value: 'no',
                    groupValue: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  const Text('No', style: TextStyle(color: kPrimaryColor)),
                ],
              ),

              // Recurring Cycle
              const SizedBox(height: largePadding),
              DropdownButtonFormField<String>(
                value: selectedRecurringCycle,
                style: const TextStyle(color: kPrimaryColor),

                decoration: InputDecoration(
                  labelText: 'Recurring Cycle',
                  labelStyle: const TextStyle(color: kPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                ),

                items: ['Day', 'Weekly', 'Monthly', 'Half Yearly', 'Yearly'].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedRecurringCycle = newValue!;
                  });
                },
              ),

              // Update Button
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
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

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
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


                    const SizedBox(height: defaultPadding,),
                    // Recurring Cycle
                    const SizedBox(height: largePadding),
                    DropdownButtonFormField<String>(
                      value: selectedProduct,
                      style: const TextStyle(color: kPrimaryColor),

                      decoration: InputDecoration(
                        labelText: 'Product',
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),

                      items: ['Select Product', 'Test Product',].map((String role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedProduct = newValue!;
                        });
                      },
                    ),


                    const SizedBox(height: largePadding,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: "Enter Quantity",
                        labelStyle:
                        const TextStyle(color: kPrimaryColor, fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),

                    const SizedBox(height: largePadding,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: true,
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: "Enter Price",
                        labelStyle:
                        const TextStyle(color: kPrimaryColor, fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),

                    const SizedBox(height: largePadding,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SizedBox(
                          width: 100, // Set your desired fixed width here
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: kPrimaryColor),
                            onSaved: (value) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(defaultPadding),
                                borderSide: const BorderSide(),
                              ),
                              hintText: "0",
                              hintStyle: const TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ),


                        const SizedBox(width: defaultPadding,),
                        Expanded(child: DropdownButtonFormField<String>(
                          value: selectedDiscount,
                          style: const TextStyle(color: kPrimaryColor),

                          decoration: InputDecoration(
                            labelText: 'Discount',
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),

                          items: ['Select Discount', 'Fixed', 'Percentage'].map((String role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedDiscount = newValue!;
                            });
                          },
                        ),
                        ),
                      ],
                    ),

                    const SizedBox(height: largePadding),
                    DropdownButtonFormField<String>(
                      value: selectedTax,
                      style: const TextStyle(color: kPrimaryColor),

                      decoration: InputDecoration(
                        labelText: 'Tax',
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),

                      items: ['Select Tax', 'Test Product',].map((String role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role,style: const TextStyle(color: kPrimaryColor,fontSize: 16),),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTax = newValue!;
                        });
                      },
                    ),

                    const SizedBox(height: largePadding,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Action", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red,),
                          onPressed: () {

                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Text("0", style: TextStyle(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total:", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Text("100.00", style: TextStyle(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount:", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Text("0.00", style: TextStyle(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax:", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Text("0.00", style: TextStyle(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total:", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: Text("0.00", style: TextStyle(color: kPrimaryColor,fontSize: 18,fontWeight: FontWeight.bold),),),
                      ],
                    ),


                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

}
