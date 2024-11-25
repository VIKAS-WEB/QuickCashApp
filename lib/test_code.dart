import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/model/productApi.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/model/productModel.dart';
import 'package:quickcash/constants.dart';

class TestCodeScreen extends StatefulWidget {
  const TestCodeScreen({super.key});

  @override
  State<TestCodeScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<TestCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductApi _productApi = ProductApi();
  List<ProductData> productLists =[];
  final TextEditingController discount = TextEditingController();
  String selectedDiscount = 'Select Discount';
  String selectedTax = 'Select Tax';
  ProductData? selectedProduct;
  String subTotal = "0.00";

  bool isLoading = false;
  String? errorMessage;

  List<Map<String, dynamic>> productList = [
    {"selectedProduct": null, "": "", "price": ""}
  ];

  @override
  void initState() {
    mProduct();
    super.initState();
  }

  Future<void> mProduct() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _productApi.productApi();
      if (response.productsList != null && response.productsList!.isNotEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          productLists = response.productsList!;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Product List';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  void addProduct() {
    setState(() {
      productList.add(
          {"selectedProduct": null, "quantity": "", "price": ""});
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
          "Add Quote",
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
              children: <Widget>[
                const SizedBox(height: largePadding),
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
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: smallPadding),
                            child: Container(
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
                                  const SizedBox(height: largePadding),
                                  // Product Dropdown
                                  DropdownButtonFormField<ProductData?>(
                                    value: productList[index]['selectedProduct'],
                                    style: const TextStyle(color: kPrimaryColor),
                                    decoration: InputDecoration(
                                      labelText: 'Product',
                                      labelStyle: const TextStyle(color: kPrimaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(),
                                      ),
                                    ),
                                    items: productLists.map((ProductData product) {
                                      return DropdownMenuItem<ProductData?>(
                                        value: product,
                                        child: Text(
                                          product.productName!,
                                          style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        productList[index]['selectedProduct'] = newValue;
                                        // Set the price when a product is selected
                                        if (newValue != null) {
                                          setState(() {
                                            productList[index]['price'] = newValue.unitPrice.toString();
                                            productList[index]['quantity'] = "1";
                                            calculateAmount(index);
                                          });
                                        } else {

                                          setState(() {
                                            productList[index]['price'] = "";
                                            productList[index]['quantity'] = "0";
                                            calculateAmount(index);
                                          });
                                        }

                                      });
                                    },
                                  ),
                                  const SizedBox(height: largePadding),
                                  // Quantity Field
                                  TextFormField(
                                    controller: TextEditingController(
                                      text: productList[index]['quantity'], // Default to '1' if null or empty
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: kPrimaryColor),
                                    decoration: InputDecoration(
                                      labelText: "Quantity",
                                      labelStyle: const TextStyle(color: kPrimaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        productList[index]['quantity'] = value;
                                        // Recalculate the amount when the quantity is changed
                                        calculateAmount(index);
                                      });
                                    },
                                  ),
                                  const SizedBox(height: largePadding),
                                  // Price Field
                                  TextFormField(
                                    controller: TextEditingController(
                                      text: productList[index]['price'], // Display the price here
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: kPrimaryColor),
                                    decoration: InputDecoration(
                                      labelText: "Price",
                                      labelStyle: const TextStyle(color: kPrimaryColor),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    readOnly: true,
                                    onChanged: (value) {
                                      setState(() {
                                        productList[index]['price'] = value; // User can manually update the price
                                        // Recalculate the amount when the price is changed
                                        calculateAmount(index);
                                      });
                                    },
                                  ),
                                  const SizedBox(height: largePadding),
                                  // Amount Calculation (Quantity * Price)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 14),
                                        child: Text(
                                          productList[index]['amount'] ?? "0.00", // Display the amount here
                                          style: const TextStyle(
                                              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: smallPadding),
                                  // Delete Button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Action", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
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
                      // Add Product Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              addProduct();
                            },
                            child: const Icon(Icons.add, color: kPrimaryColor),
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
                              keyboardType: TextInputType.number,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub Total:",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                            child: Text(
                              subTotal, // Dynamically updated value
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateTotalAmount() {
    double totalAmount = 0;

    // Iterate over all products and sum their amounts
    for (var product in productList) {
      final amount = double.tryParse(product['amount'] ?? '0') ?? 0;
      totalAmount += amount;
    }

    setState(() {
      // Update the Sub Total field with the calculated total amount
      subTotal = totalAmount.toStringAsFixed(2);
    });
  }

  void calculateAmount(int index) {
    final quantity = double.tryParse(productList[index]['quantity'] ?? '0') ?? 0;
    final price = double.tryParse(productList[index]['price'] ?? '0') ?? 0;

    if (quantity != 0) {
      final amount = quantity * price;
      setState(() {
        productList[index]['amount'] = amount.toStringAsFixed(2);
      });
    } else {
      setState(() {
        final amount = price;
        productList[index]['price'] = amount.toStringAsFixed(2);
      });
    }

    // Recalculate the total amount every time an individual amount changes
    calculateTotalAmount();
  }




}

