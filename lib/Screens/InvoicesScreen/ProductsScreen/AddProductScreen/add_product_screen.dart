import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedCategory = 'Select Category';

  // Function to generate a random product code
  String generateRandomCode(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  }

  void _updateProductCode() {
    setState(() {
      String newCode = generateRandomCode(12); // Change 12 to any length you prefer
      _productCodeController.text = newCode; // Update the text controller
    });
  }

  @override
  void initState() {
    super.initState();
    _updateProductCode(); // Generate initial product code
  }

  @override
  void dispose() {
    _productCodeController.dispose(); // Dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Product",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: largePadding),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: largePadding),
                TextFormField(
                  controller: _productCodeController, // Use the controller
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Product Code",
                    labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    suffixIcon: GestureDetector(
                      onTap: _updateProductCode, // Call the function on tap
                      child: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.repeat),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: largePadding),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  items: [
                    'Select Category',
                    'Business',
                    'Others',
                  ].map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category, style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == 'Select Category') {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: largePadding),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    labelText: "Unit Price",
                    labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a unit price';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: largePadding),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  minLines: 6,
                  maxLines: 12,
                  decoration: InputDecoration(
                    labelText: "Description",
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
                      return 'Please enter a description';
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
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the form submission logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product saved successfully!')),
                        );
                      }
                    },
                    child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
