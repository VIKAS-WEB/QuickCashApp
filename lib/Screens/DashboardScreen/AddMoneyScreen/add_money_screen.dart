import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreen();
}

class _AddMoneyScreen extends State<AddMoneyScreen> {
  String? selectedSendCurrency;
  String? selectedTransferType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  void _showTransferTypeDropDown(BuildContext context, bool isTransfer) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions(
              'Stripe * Support Other Currencies',
              'assets/icons/stripe.png',
              isTransfer,
            ),
            _buildTransferOptions(
              'UPI * Currently Support Only INR Currency',
              'assets/icons/upi.png',
              isTransfer,
            ),
          ],
        );
      },
    );
  }

  void _showCurrencyDropdown(BuildContext context, bool isSend) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
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
          }
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildTransferOptions(String type, String logoPath, bool isTransfer) {
    return ListTile(
      title: Row(
        children: [
          Image.asset(logoPath, height: 24),
          const SizedBox(width: 8.0),
          Text(type),
        ],
      ),
      onTap: () {
        setState(() {
          if (isTransfer) {
            selectedTransferType = type;
          }
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Money",
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
                              : 'Currency Type',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                        const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                GestureDetector(
                  onTap: () => _showTransferTypeDropDown(context, true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            if (selectedTransferType != null)
                              Image.asset(
                                _getImageForTransferType(selectedTransferType!),
                                height: 24,
                                width: 24,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image, color: Colors.red);
                                },
                              ),
                            const SizedBox(width: 8.0),
                            Text(
                              selectedTransferType != null
                                  ? '$selectedTransferType ${_getFlagForTransferType(selectedTransferType!)}'
                                  : 'Transfer Type',
                              style: const TextStyle(color: kPrimaryColor),
                            ),
                          ],
                        ),
                        const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 45),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Deposit Fee:", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    Text("0.00", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: smallPadding),
                const Divider(),
                const SizedBox(height: smallPadding),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount Charge:", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    Text("0.00", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: smallPadding),
                const Divider(),
                const SizedBox(height: smallPadding),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Conversion Amount:", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                    Text("0.00", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 45),
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



                      if (_formKey.currentState!.validate()) {
                        if (selectedSendCurrency == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a currency type')),
                          );
                          return;
                        } else if (selectedTransferType == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a transfer type')),
                          );
                          return;
                        }
                        // Perform the action to add money
                      }
                    },
                    child: const Text('Add Money', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
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

  String _getFlagForTransferType(String transferType) {
    switch (transferType) {
      case "Stripe * Support Other Currencies":
        return 'Stripe';
      case "UPI * Currently Support Only INR Currency":
        return 'UPI';
      default:
        return '';
    }
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "Stripe * Support Other Currencies":
        return 'assets/icons/stripe.png';
      case "UPI * Currently Support Only INR Currency":
        return 'assets/icons/upi.png';
      default:
        return 'assets/icons/default.png';
    }
  }
}
