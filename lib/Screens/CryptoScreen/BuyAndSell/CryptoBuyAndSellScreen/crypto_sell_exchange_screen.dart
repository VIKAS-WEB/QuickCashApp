import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/confirm_buy_screen.dart';
import 'package:quickcash/constants.dart';

import '../../../../model/currencyApiModel/currencyApi.dart';
import '../../../../model/currencyApiModel/currencyModel.dart';

class CryptoBuyAnsSellScreen extends StatefulWidget {
  const CryptoBuyAnsSellScreen({super.key});

  @override
  State<CryptoBuyAnsSellScreen> createState() => _CryptoBuyAnsSellScreenState();
}

class _CryptoBuyAnsSellScreenState extends State<CryptoBuyAnsSellScreen> {
  final CurrencyApi _currencyApi = CurrencyApi();

  String? selectedCurrency; // Variable to hold selected coin
  List<CurrencyListsData> currency = [];

  bool isBuySelected = true;
  String? selectedSendCurrency;
  String? selectedTransferType;


  @override
  void initState() {
    super.initState();
    mGetCurrency();
  }


  Future<void> mGetCurrency() async {
    final response = await _currencyApi.currencyApi();

    if(response.currencyList !=null && response.currencyList!.isNotEmpty) {
      currency = response.currencyList!;
    }

  }


















  void _showCurrencyDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildCurrencyOption('USD', '🇺🇸'),
            _buildCurrencyOption('EUR', '🇪🇺'),
            _buildCurrencyOption('GBP', '🇬🇧'),
          ],
        );
      },
    );
  }

  Widget _buildCurrencyOption(String currency, String flagEmoji) {
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
          selectedSendCurrency = currency;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showTransferTypeDropDown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions('BNB', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('BTC', 'assets/icons/menu_crypto.png'),
          ],
        );
      },
    );
  }

  Widget _buildTransferOptions(String type, String logoPath) {
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
          selectedTransferType = type;
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
          "Crypto Exchange",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "Exchange crypto manually from the comfort of your home, quickly, safely with minimal fees.",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 45.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          isBuySelected = true;
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            isBuySelected ? kPrimaryColor : Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: isBuySelected
                              ? Colors.transparent
                              : kPrimaryColor,
                          width: 2,
                        ),
                        elevation: isBuySelected ? 4 : 0,
                      ),
                      child: Text(
                        'Crypto Buy',
                        style: TextStyle(
                          color: isBuySelected ? Colors.white : kPrimaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          isBuySelected = false;
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            !isBuySelected ? kPrimaryColor : Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: !isBuySelected
                              ? Colors.transparent
                              : kPrimaryColor,
                          width: 2,
                        ),
                        elevation: !isBuySelected ? 4 : 0,
                      ),
                      child: Text(
                        'Crypto Sell',
                        style: TextStyle(
                          color: !isBuySelected ? Colors.white : kPrimaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35.0,),
              isBuySelected ? mCryptoBuy() : mCryptoSell(),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget Crypto Buy ------------------------------------
  Widget mCryptoBuy(){
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (currency.isNotEmpty) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Currency',style: TextStyle(color: kPrimaryColor),),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: currency.map((CurrencyListsData currencyItem) {
                              return ListTile(
                                title: Text(currencyItem.currencyCode!,style: const TextStyle(color: kPrimaryColor),),
                                onTap: () {
                                  Navigator.pop(context, currencyItem.currencyCode);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ).then((String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedCurrency = newValue; // Update the selected currency
                      });
                    }
                  });
                } else {
                  // Handle empty currency list case
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
                      Text(
                        selectedCurrency ?? "Select Currency",
                        style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                      ),
                      const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: defaultPadding),
            TextFormField(
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
                filled: true,
                // Enable the filled property
                fillColor: Colors.white, // Set the background color to white
              ),
              initialValue: '0',
            ),

            const SizedBox(height: 20.0),

            const Card(
              elevation: 4.0,
              color: kPrimaryLightColor,
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exchange Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Crypto Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Estimated Rate:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("0.0000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "You Get",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                // Enable the filled property
                fillColor: Colors.white, // Set the background color to white
              ),
              initialValue: '0',
            ),
            const SizedBox(height: defaultPadding),
            GestureDetector(
              onTap: () => _showTransferTypeDropDown(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 15.0),
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
                              return const Icon(Icons.broken_image,
                                  color: Colors.red);
                            },
                          ),
                        const SizedBox(width: 8.0),
                        Text(
                          selectedTransferType != null
                              ? '$selectedTransferType ${_getFlagForTransferType(selectedTransferType!)}'
                              : 'Coin',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfirmBuyScreen()),
                  );
                },
                child: const Text('Proceed',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),

          ],
        ),
      ),
    );
  }


  // Widget Crypto Sell ------------------------------------
  Widget mCryptoSell(){
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(0),
        child: Column(
          children: [

            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "No of Coins",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                // Enable the filled property
                fillColor: Colors.white, // Set the background color to white
              ),
              initialValue: '0',
            ),
            const SizedBox(height: defaultPadding),
            GestureDetector(
              onTap: () => _showTransferTypeDropDown(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 15.0),
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
                              return const Icon(Icons.broken_image,
                                  color: Colors.red);
                            },
                          ),
                        const SizedBox(width: 8.0),
                        Text(
                          selectedTransferType != null
                              ? '$selectedTransferType ${_getFlagForTransferType(selectedTransferType!)}'
                              : 'Coin',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            const Card(
              elevation: 4.0,
              color: kPrimaryLightColor,
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exchange Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Crypto Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Estimated Rate:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("0.0000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),

            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "You Get",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                // Enable the filled property
                fillColor: Colors.white, // Set the background color to white
              ),
              initialValue: '0',
            ),
            const SizedBox(height: defaultPadding),
            GestureDetector(
              onTap: () => _showCurrencyDropdown(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 15.0),
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


            const SizedBox(height: 35.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfirmBuyScreen()),
                  );
                },
                child: const Text('Proceed',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),

          ],
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
      case "bnb":
        return 'BNB';
      case "btc":
        return 'BTC';
      default:
        return '';
    }
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "BNB":
      case "BTC":
        return 'assets/icons/menu_crypto.png';
      default:
        return 'assets/icons/default.png';
    }
  }
}
