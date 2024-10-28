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

  bool _isAdded = false;

  void _toggleButton() {
    setState(() {
      _isAdded = !_isAdded;
    });
  }

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


  List<Map<String, dynamic>> productList = [
    {"selectedProduct": 'Select Product', "quantity": "", "price": ""}
  ];

  void addProduct() {
    setState(() {
      productList.add(
          {"selectedProduct": 'Select Product', "quantity": "", "price": ""});
    });
  }

  void removeProduct(int index) {
    if (productList.length > 1) {
      setState(() {
        productList.removeAt(index);
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

                items: [
                  'Select Status',
                  'Paid',
                  'Unpaid',
                  'Partially Paid',
                  'Overdue',
                  'Processing'
                ].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role, style: const TextStyle(
                        color: kPrimaryColor, fontSize: 16),),
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

                items: [
                  'Default',
                  'New York',
                  'Toronto',
                  'Rio',
                  'London',
                  'Istanbul',
                  'Mumbai',
                  'Hong Kong',
                  'Tokyo',
                  'Paris'
                ].map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role, style: const TextStyle(
                        color: kPrimaryColor, fontSize: 16),),
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
                    child: Text(role, style: const TextStyle(
                        color: kPrimaryColor, fontSize: 16),),
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

                items: ['Select Currency', 'USD', 'INR', 'EUR'].map((
                    String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role, style: const TextStyle(
                        color: kPrimaryColor, fontSize: 16),),
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

                items: ['Day', 'Weekly', 'Monthly', 'Half Yearly', 'Yearly']
                    .map((String role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role, style: const TextStyle(
                        color: kPrimaryColor, fontSize: 16),),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedRecurringCycle = newValue!;
                  });
                },
              ),

              const SizedBox(height: largePadding,),

              // Container for product list
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
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // Prevent scrolling
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: smallPadding),
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.white60,
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
                                const SizedBox(height: largePadding,),
                                DropdownButtonFormField<String>(
                                  value: productList[index]['selectedProduct'],
                                  style: const TextStyle(color: kPrimaryColor),
                                  decoration: InputDecoration(
                                    labelText: 'Product',
                                    labelStyle: const TextStyle(
                                        color: kPrimaryColor),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(),
                                    ),
                                  ),
                                  items: [
                                    'Select Product',
                                    'Product 1',
                                    'Product 2'
                                  ].map((String role) {
                                    return DropdownMenuItem(
                                      value: role,
                                      child: Text(role, style: const TextStyle(
                                          color: kPrimaryColor, fontSize: 16)),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      productList[index]['selectedProduct'] =
                                      newValue!;
                                    });
                                  },
                                ),
                                const SizedBox(height: largePadding),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Quantity",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      productList[index]['quantity'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: largePadding),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Price",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      productList[index]['price'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: largePadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const Text("Total", style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                    Padding(padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                      child: Text(
                                        "${(double.tryParse(
                                            productList[index]['quantity'] ??
                                                '0') ?? 0) * (double.tryParse(
                                            productList[index]['price'] ??
                                                '0') ?? 0)}",
                                        style: const TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),

                                  ],
                                ),
                                const SizedBox(height: smallPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const Text("Action", style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.delete, color: Colors.red),
                                      onPressed: () => removeProduct(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            addProduct();
                          },
                          child: const Icon(Icons.add, color: kPrimaryColor,),
                        ),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
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
                                borderRadius: BorderRadius.circular(
                                    defaultPadding),
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

                          items: ['Select Discount', 'Fixed', 'Percentage']
                              .map((String role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role, style: const TextStyle(
                                  color: kPrimaryColor, fontSize: 16),),
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
                          child: Text(role, style: const TextStyle(
                              color: kPrimaryColor, fontSize: 16),),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTax = newValue!;
                        });
                      },
                    ),

                    const SizedBox(height: 35,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total:", style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                          child: Text("100.00", style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount:", style: TextStyle(color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                          child: Text("0.00", style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tax:", style: TextStyle(color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                          child: Text("0.00", style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: defaultPadding,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total:", style: TextStyle(color: kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),
                        Padding(padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                          child: Text("0.00", style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),),),
                      ],
                    ),

                    const SizedBox(height: largePadding,),
                    Center(child: SizedBox(
                      width: 220,
                      height: 47.0,
                      child: FloatingActionButton.extended(
                        onPressed: _toggleButton,
                        label: Text(
                          _isAdded ? 'Remove Note & Terms' : 'Add Note & Terms',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        icon: Icon(
                          _isAdded ? Icons.remove : Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: _isAdded ? Colors.red : kPrimaryColor,
                      ),
                    ),
                    ),

                    const SizedBox(height: largePadding,),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: largePadding,),

                        // Draft Button
                        SizedBox(
                          width: 145,
                          height: 47.0,
                          child: FloatingActionButton.extended(
                            onPressed: () {

                            },
                            label: const Text(
                              'Save as Draft',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),

                        const SizedBox(width: defaultPadding,),

                        // Save Button
                        SizedBox(
                          width: 145,
                          height: 47.0,
                          child: FloatingActionButton.extended(
                            onPressed: () {

                            },
                            label: const Text(
                              'Save & Send',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),

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
