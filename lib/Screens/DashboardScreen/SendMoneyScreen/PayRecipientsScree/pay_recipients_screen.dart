import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class PayRecipientsScreen extends StatefulWidget {
  const PayRecipientsScreen({super.key});

  @override
  State<PayRecipientsScreen> createState() => _PayRecipientsScreen();
}

class _PayRecipientsScreen extends State<PayRecipientsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedSendCurrency;
  String? selectedReceiveCurrency;

  void _showCurrencyDropdown(BuildContext context, bool isSend) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            _buildCurrencyOption('USD', '🇺🇸', isSend),
            _buildCurrencyOption('EUR', '🇪🇺', isSend),
            _buildCurrencyOption('GBP', '🇬🇧', isSend),
          ],
        );
      },
    );
  }

  Widget _buildCurrencyOption(String currency, String flagEmoji, bool isSend) {
    return ListTile(
      title: Row(
        children: [
          Text(flagEmoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8.0),
          Text(currency),
        ],
      ),
      onTap: () {
        setState(() {
          if (isSend) {
            selectedSendCurrency = currency;
          } else {
            selectedReceiveCurrency = currency;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process payment here
      // You can access the form values using _formKey.currentState
      // For example: _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Recipients",
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
                const SizedBox(height: defaultPadding),
                Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            "Payment Information",
                            style: TextStyle(color: kPrimaryColor, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Send',
                                  labelStyle: const TextStyle(color: kPrimaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                cursorColor: kPrimaryColor,
                                style: const TextStyle(color: kPrimaryColor),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () => _showCurrencyDropdown(context, true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: kPrimaryColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedSendCurrency != null
                                          ? '$selectedSendCurrency ${_getFlagForCurrency(selectedSendCurrency!)}'
                                          : 'Currency',
                                      style: const TextStyle(color: kPrimaryColor),
                                    ),
                                    const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Recipient will receive',
                                  labelStyle: const TextStyle(color: kPrimaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                cursorColor: kPrimaryColor,
                                style: const TextStyle(color: kPrimaryColor),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a receiving amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () => _showCurrencyDropdown(context, false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: kPrimaryColor),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedReceiveCurrency != null
                                          ? '$selectedReceiveCurrency ${_getFlagForCurrency(selectedReceiveCurrency!)}'
                                          : 'Currency',
                                      style: const TextStyle(color: kPrimaryColor),
                                    ),
                                    const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        const SizedBox(height: 30),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Charge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                            Text('0', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor)),
                          ],
                        ),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Payable', style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold)),
                            Text('0', style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: defaultPadding)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Your Email",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Mobile Number",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Bank Name",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your bank name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "IBAN / AC",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your IBAN or account number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Routing/IFSC/BIC/SwiftCode",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the routing number or equivalent';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Recipient Address",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the recipient address';
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
                            onPressed: _submitForm,
                            child: const Text('Make Payment', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFlagForCurrency(String currency) {
    switch (currency) {
      case 'USD':
        return '🇺🇸';
      case 'EUR':
        return '🇪🇺';
      case 'GBP':
        return '🇬🇧';
      default:
        return '';
    }
  }
}
