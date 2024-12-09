import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/model/productApi.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/model/productModel.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';
import 'package:quickcash/model/taxApi/taxApi.dart';
import 'package:quickcash/model/taxApi/taxApiModel.dart';

class TestCodeScreen extends StatefulWidget {
  const TestCodeScreen({super.key});

  @override
  State<TestCodeScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<TestCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProductApi _productApi = ProductApi();
  final TaxApi _taxApi = TaxApi();

  List<ProductData> productLists = [];
  List<TaxData> taxList = [];
  List<String> selectedTaxes = [];
  List<String> selectedTaxesCalculate = [];

  final TextEditingController discount = TextEditingController();
  String selectedDiscount = 'Select Discount';
  String selectedTax = 'Select Tax';
  ProductData? selectedProduct;
  String subTotal = "0.00";
  String showDiscount = "0.00";
  String showTaxes = "0.00";
  String showTotalAmount = "0.00";
  double totalTaxValue = 0;

  bool isLoading = false;
  String? errorMessage;

  // Product list holding the product entries
  List<ProductEntry> productList = [ProductEntry()];

  @override
  void initState() {
    mProduct();
    mTaxes();
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

  Future<void> mTaxes() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _taxApi.taxesApi();
      if (response.taxesList != null && response.taxesList!.isNotEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          taxList = response.taxesList!;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Tax List';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  // Function to add a new product entry
  void addProduct() {
    if (productList.length < productLists.length) {
      final selectedProduct = productLists[productList.length];

      if (selectedProduct.productName != null && selectedProduct.unitPrice != null) {
        setState(() {
          productList.add(ProductEntry(productId: selectedProduct.id));
        });
        print("Updated productList: $productList");
      } else {
        CustomSnackBar.showSnackBar(
          context: context,
          message: 'Selected product is incomplete.',
          color: kPrimaryColor,
        );
      }
    } else {
      CustomSnackBar.showSnackBar(
        context: context,
        message: 'You cannot add more products.',
        color: kPrimaryColor,
      );
    }
  }

  // Function to remove a product from the list
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
                                    value: productList[index].productId != null
                                        ? productLists.firstWhere((product) => product.id == productList[index].productId)
                                        : null,
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
                                          product.productName ?? 'Unnamed Product',
                                          style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        if (newValue != null) {
                                          productList[index].productId = newValue.id;
                                          productList[index].productName = newValue.productName ?? '';
                                          productList[index].price = newValue.unitPrice?.toString() ?? '';
                                          productList[index].quantity = "1"; // Default quantity
                                          productList[index].amount = (newValue.unitPrice! * 1).toStringAsFixed(2); // Calculate amount based on quantity
                                        } else {
                                          productList[index].productName = "";
                                          productList[index].price = "";
                                          productList[index].quantity = "0";
                                          productList[index].amount = "0.00";
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(height: largePadding),
                                  // Quantity Field
                                  TextFormField(
                                    controller: TextEditingController(
                                      text: productList[index].quantity,
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
                                        productList[index].quantity = value;
                                        double price = double.tryParse(productList[index].price) ?? 0;
                                        int quantity = int.tryParse(value) ?? 0;
                                        productList[index].amount = (price * quantity).toStringAsFixed(2);
                                      });
                                    },
                                  ),
                                  const SizedBox(height: largePadding),
                                  // Price Field (read-only)
                                  TextFormField(
                                    controller: TextEditingController(
                                      text: productList[index].price,
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
                                        productList[index].price = value;
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
                                          productList[index].amount,
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
                                        onPressed: () {
                                          setState(() {
                                            removeProduct(index);
                                          });
                                        },
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
                            onPressed: addProduct,
                            child: const Icon(Icons.add, color: kPrimaryColor),
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
      ),
    );
  }
}

// ProductEntry class to manage product data
class ProductEntry {
  String? productId;
  String? productName;
  String quantity;
  String price;
  String amount;

  ProductEntry({
    this.productId,
    this.productName,
    this.quantity = "1",
    this.price = "",
    this.amount = "0.00",
  });

  @override
  String toString() {
    return 'ProductEntry{productId: $productId,productName: $productName, quantity: $quantity, price: $price, amount: $amount,tax: 0, taxValue: 0}';
  }
}
