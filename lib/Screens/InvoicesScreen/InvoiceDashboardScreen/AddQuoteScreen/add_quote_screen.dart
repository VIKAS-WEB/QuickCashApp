import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/model/productApi.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/model/productModel.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart'; //

import '../../../../model/currencyApiModel/currencyApi.dart';
import '../../../../model/currencyApiModel/currencyModel.dart';
import '../../../../util/customSnackBar.dart';
import '../../ClientsScreen/ClientsScreen/model/clientsApi.dart';
import '../../ClientsScreen/ClientsScreen/model/clientsModel.dart';

class AddQuoteScreen extends StatefulWidget {
  const AddQuoteScreen({super.key});

  @override
  State<AddQuoteScreen> createState() => _AddQuoteScreenState();
}

class _AddQuoteScreenState extends State<AddQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final CurrencyApi _currencyApi = CurrencyApi();
  final ClientsApi _clientsApi = ClientsApi();
  final ProductApi _productApi = ProductApi();
  List<ClientsData> clientsData = [];
  List<ProductData> productLists =[];

  String? selectedCurrency;
  List<CurrencyListsData> currency = [];

  final TextEditingController quoteNumber = TextEditingController();
  final TextEditingController receiverName = TextEditingController();
  final TextEditingController receiverEmail = TextEditingController();
  final TextEditingController receiverAddress = TextEditingController();
  final TextEditingController discount = TextEditingController();


  String? selectedType = "other";
  DateTime? quoteDate;
  DateTime? dueDate;
 // String? selectedMember;
  ClientsData? selectedMember;  // This will hold the full ClientsData object

  String selectedInvoiceTemplate = 'Default';
  String selectedDiscount = 'Select Discount';
  String selectedTax = 'Select Tax';

  bool _isAdded = false;
  bool isLoading = false;
  String? errorMessage;

  void _toggleButton() {
    setState(() {
      _isAdded = !_isAdded;
    });
  }

  List<Map<String, dynamic>> productList = [
    {"selectedProduct": 'Select Product', "quantity": "", "price": ""}
  ];


  @override
  void initState() {
    updateProductCode();
    mGetCurrency();
    mClientsApi();
    mProduct();
    super.initState();
  }

  // Currency Api ----
  Future<void> mGetCurrency() async {
    final response = await _currencyApi.currencyApi();
    if(response.currencyList !=null && response.currencyList!.isNotEmpty) {
      currency = response.currencyList!;
    }
  }

  // Clients Api ----
  Future<void> mClientsApi() async {
    setState(() {
      isLoading = false;
      errorMessage = null;
    });

    try{
      final response = await _clientsApi.clientsApi();
      if(response.clientsList !=null && response.clientsList!.isNotEmpty){
        setState(() {
          clientsData = response.clientsList!;
          isLoading = false;
        });
      }else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Clients List';
        });
      }
    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  Future<void> mProduct() async{
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final response = await _productApi.productApi();

      if(response.productsList !=null && response.productsList!.isNotEmpty){
        setState(() {
          isLoading = false;
          errorMessage = null;

          productLists = response.productsList!;

        });
      }else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Product List';
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }



// Function to generate a product code based on the current timestamp
  String generateCodeFromTimestamp() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String timestampStr = timestamp.toString();
    return timestampStr.substring(timestampStr.length - 10);
  }

  void updateProductCode() {
    setState(() {
      String newCode = generateCodeFromTimestamp();
      quoteNumber.text = newCode;
    });
  }


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

  Future<void> mQuoteDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: quoteDate ?? DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != quoteDate) {
      setState(() {
        quoteDate = picked;
      });
    }
  }

  Future<void> mDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate ?? DateTime.now(),
      firstDate: DateTime(1947),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dueDate) {
      setState(() {
        dueDate = picked;
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: largePadding),
              TextFormField(
                controller: quoteNumber,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (value) {},
                readOnly: true,
                style: const TextStyle(color: kPrimaryColor),
                decoration: InputDecoration(
                  labelText: "Quote #",
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
                    groupValue: selectedType,
                    onChanged: (String? value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  const Text('Member', style: TextStyle(color: kPrimaryColor)),
                  Radio<String>(
                    value: 'other',
                    groupValue: selectedType,
                    onChanged: (String? value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  const Text('Other', style: TextStyle(color: kPrimaryColor)),
                ],
              ),

              if (selectedType == "Member" || selectedType == "member") ...[
                // Selected Member
                const SizedBox(height: largePadding),
                DropdownButtonFormField<ClientsData>(
                  value: selectedMember,
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                    labelText: 'Select Member',
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  items: clientsData.map((ClientsData role) {
                    return DropdownMenuItem<ClientsData>(
                      value: role,
                      child: Text(
                        '${role.firstName} ${role.lastName}',
                        style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (ClientsData? newValue) {
                    setState(() {
                      selectedMember = newValue;
                      if (selectedMember != null) {
                        print('Selected Member: ${selectedMember?.firstName} ${selectedMember?.lastName}'); // Output full name
                      }
                    });
                  },
                ),

              ],

              if (selectedType == "Other" || selectedType == "other") ...[
                const SizedBox(height: largePadding),
                TextFormField(
                  controller: receiverName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter receiver name';
                    }
                    return null;
                  },
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
                ),
                const SizedBox(height: largePadding),
                TextFormField(
                  controller: receiverEmail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter receiver email';
                    }
                    return null;
                  },
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
                ),
                const SizedBox(height: largePadding),
                TextFormField(
                  controller: receiverAddress,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter receiver address';
                    }
                    return null;
                  },
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
                ),
              ],

              const SizedBox(height: largePadding),
              GestureDetector(
                onTap: () => mQuoteDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  // Prevent keyboard from appearing
                  child: TextFormField(
                    controller: TextEditingController(
                      text: quoteDate == null
                          ? ''
                          : DateFormat('dd-MM-yyyy').format(quoteDate!),
                    ),
                    style: const TextStyle(color: kPrimaryColor),
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
                onTap: () => mDueDate(context), // Open date picker on tap
                child: AbsorbPointer(
                  // Prevent keyboard from appearing
                  child: TextFormField(
                    controller: TextEditingController(
                      text: dueDate == null
                          ? ''
                          : DateFormat('dd-MM-yyyy').format(dueDate!),
                    ),
                    style: const TextStyle(color: kPrimaryColor),
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
              const SizedBox(height: defaultPadding),
              GestureDetector(
                onTap: () {
                  // Check if currency list is not empty before showing the menu
                  if (currency.isNotEmpty) {
                    RenderBox renderBox = context.findRenderObject() as RenderBox;
                    Offset offset = renderBox.localToGlobal(Offset.zero);

                    showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        offset.dx,
                        offset.dy + renderBox.size.height,
                        offset.dx + renderBox.size.width,
                        0.0,
                      ),
                      items: currency.map((CurrencyListsData currencyItem) {
                        return PopupMenuItem<String>(
                          value: currencyItem.currencyCode, // Use the appropriate property
                          child: Text(currencyItem.currencyCode!, style: const TextStyle(color: kPrimaryColor),), // Display the name or code of the currency
                        );
                      }).toList(),
                    ).then((String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedCurrency = newValue; // Update the selected coin
                        });
                      }
                    });
                  } else {
                  }
                },
                child: Material(
                  color: Colors.transparent, // Make the Material widget invisible
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedCurrency ?? "Select Currency", style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
                        const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                      ],
                    ),
                  ),
                ),
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
                                    });
                                  },
                                ),
                                const SizedBox(height: largePadding),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(color: kPrimaryColor),
                                  decoration: InputDecoration(
                                    labelText: "Price",
                                    labelStyle: const TextStyle(color: kPrimaryColor),
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
                    Center(
                      child: SizedBox(
                        width: 220,
                        height: 47.0,
                        child: FloatingActionButton.extended(
                          onPressed: _toggleButton,
                          label: Text(
                            _isAdded ? 'Remove Note & Terms' : 'Add Note & Terms',
                            style: const TextStyle(color: Colors.white, fontSize: 14),
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

                    if (_isAdded) ...[

                      Column(
                        children: [
                          const SizedBox(height: largePadding),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            onSaved: (value) {},
                            readOnly: false,
                            style: const TextStyle(color: kPrimaryColor),
                            maxLines: 5,
                            minLines: 1,
                            decoration: InputDecoration(
                              labelText: "Note",
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

                          const SizedBox(height: defaultPadding),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            onSaved: (value) {},
                            readOnly: false,
                            maxLines: 5,
                            minLines: 1,
                            style: const TextStyle(color: kPrimaryColor),
                            decoration: InputDecoration(
                              labelText: "Terms",
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


                        ],
                      ),

                      /*Column(
                        children: [
                          QuillToolbar.simple(
                            configurations: QuillSimpleToolbarConfigurations(
                              controller: _controller,
                              toolbarSize: 10,
                              sharedConfigurations: const QuillSharedConfigurations(
                                locale: Locale('de'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: QuillEditor.basic(
                              configurations: QuillEditorConfigurations(
                                placeholder: "Type here..",
                                controller: _controller,
                                autoFocus: true,
                                sharedConfigurations: const QuillSharedConfigurations(
                                  locale: Locale('de'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                    ],



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
                              if (_formKey.currentState?.validate() ?? false) {
                              }else if(selectedType!.isEmpty){
                                CustomSnackBar.showSnackBar(context: context, message: "Please select type", color: kRedColor);
                              }else if(quoteDate == null){
                                CustomSnackBar.showSnackBar(context: context, message: "Please select invoice date", color: kRedColor);
                              }else if(dueDate == null){
                                CustomSnackBar.showSnackBar(context: context, message: "Please select due date", color: kRedColor);
                              }else if(selectedInvoiceTemplate.isEmpty){
                                CustomSnackBar.showSnackBar(context: context, message: "Please select invoice template", color: kRedColor);
                              }else if(selectedCurrency!.isEmpty){
                                CustomSnackBar.showSnackBar(context: context, message: "Please select currency", color: kRedColor);
                              }else{
                                CustomSnackBar.showSnackBar(context: context, message: "Save", color: kRedColor);
                              }

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

              const SizedBox(height: 35),

            ],
          )),
        ),
      ),
    );
  }

}
