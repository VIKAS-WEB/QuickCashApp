import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoBuyModel/cryptoBuyApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoBuyModel/cryptoBuyModel.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

import '../../../../model/currencyApiModel/currencyApi.dart';
import '../../../../model/currencyApiModel/currencyModel.dart';

class CryptoBuyAnsSellScreen extends StatefulWidget {
  const CryptoBuyAnsSellScreen({super.key});

  @override
  State<CryptoBuyAnsSellScreen> createState() => _CryptoBuyAnsSellScreenState();
}

class _CryptoBuyAnsSellScreenState extends State<CryptoBuyAnsSellScreen> {
  final CurrencyApi _currencyApi = CurrencyApi();
  final CryptoBuyApi _cryptoBuyApi = CryptoBuyApi();

  final TextEditingController mAmount = TextEditingController();
  final TextEditingController mYouGet = TextEditingController();

  String? selectedCurrency; // Variable to hold selected coin
  List<CurrencyListsData> currency = [];

  bool isLoading = false;
  bool isBuySelected = true;
  String? selectedCoinType;
  String? sideType;

  double? rate;
  double? numberOfCoins;
  int? fees;
  int? cryptoFees;
  int? exchangeFees;

  @override
  void initState() {
    super.initState();
    mGetCurrency();
  }

  Future<void> mGetCurrency() async {
    final response = await _currencyApi.currencyApi();

    if (response.currencyList != null && response.currencyList!.isNotEmpty) {
      currency = response.currencyList!;
    }
  }

  // Crypto Buy and Sell Calculation Api -----------------
  Future<void> mCryptoBuySellCalculation() async{
    setState(() {
      isLoading = true;
    });

    try{

      if(isBuySelected == true){
        sideType = "buy";
      }else{
        sideType = "sell";
      }

      int amount = int.parse(mAmount.text);
      final request = CryptoBuyRequest(amount: amount, coinType: selectedCoinType!, currencyType: selectedCurrency!, sideType: sideType!);
      final response = await _cryptoBuyApi.cryptoBuyApi(request);

      if(response.message == "Success"){
        setState(() {
          isLoading = false;

          rate = response.data.rate;
          numberOfCoins = response.data.numberofCoins;
          fees = response.data.fees;
          cryptoFees = response.data.cryptoFees;
          exchangeFees = response.data.exchangeFees;
        });

      }else{
        setState(() {
          isLoading = false;
          CustomSnackBar.showSnackBar(context: context, message: "We are facing some issue!", color: kPrimaryColor);
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(context: context, message: "Something went wrong!", color: kPrimaryColor);
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
                          if(selectedCurrency != "Select Currency"){
                            if(selectedCoinType != "Coin"){
                              if(mAmount.text.isNotEmpty){
                                mCryptoBuySellCalculation();
                              }
                            }
                          }
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
              const SizedBox(
                height: 35.0,
              ),
              isBuySelected ? mCryptoBuy() : mCryptoSell(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Crypto Buy ------------------------------------
  Widget mCryptoBuy() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (currency.isNotEmpty) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Select Currency',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children:
                            currency.map((CurrencyListsData currencyItem) {
                              return ListTile(
                                title: Text(
                                  currencyItem.currencyCode!,
                                  style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.pop(
                                      context, currencyItem.currencyCode);
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
                        selectedCurrency =
                            newValue; // Update the selected currency
                        if(selectedCurrency != "Select Currency"){
                          if(selectedCoinType != "Coin"){
                            if(mAmount.text.isNotEmpty){
                              mCryptoBuySellCalculation();
                            }
                          }
                        }
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
                        selectedCurrency ?? "Select Currency",
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: mAmount,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              onChanged: (value){
                setState(() {
                  if(selectedCurrency != "Select Currency"){
                    if(selectedCoinType != "Coin"){
                      if(mAmount.text.isNotEmpty){
                        mCryptoBuySellCalculation();
                      }
                    }
                  }

                });
              },
              decoration: InputDecoration(
                labelText: "Amount",
                hintText: "0",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                // Enable the filled property
                fillColor: Colors.white, // Set the background color to white
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
                        Text("Coins Available:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17,color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exchange Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17,color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Crypto Rate:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor)),
                        Text("0.0000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17,color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            TextFormField(
              controller: mYouGet,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              readOnly: true,
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
              minLines: 1,
              maxLines: 6,
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
                        if (selectedCoinType != null)
                          ClipOval(
                            child: Image.network(

                              _getImageForTransferType(selectedCoinType!),
                              height: 28,
                              width: 28,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, color: Colors.red);
                              },
                            ),
                          ),
                        const SizedBox(width: 8.0),
                        Text(
                          selectedCoinType != null
                              ? '$selectedCoinType'
                              : 'Coin',
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: (){

                  /*if(!isLoading){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfirmBuyScreen()),
                    );
                  }*/

                },  // Disable button since it's triggered by API call
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                )
                    : const Text('Proceed',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Crypto Sell ------------------------------------
  Widget mCryptoSell() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [


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
                        if (selectedCoinType != null)

                          ClipOval(
                            child: Image.network(

                              _getImageForTransferType(selectedCoinType!),
                              height: 28,
                              width: 28,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, color: Colors.red);
                              },
                            ),
                          ),

                        const SizedBox(width: 8.0),
                        Text(
                          selectedCoinType != null
                              ? '$selectedCoinType'
                              : 'Coin',
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
              controller: mAmount,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              onChanged: (value){
                if(selectedCurrency != "Select Currency"){
                  if(selectedCoinType != "Coin"){
                    if(mAmount.text.isNotEmpty){
                      mCryptoBuySellCalculation();
                    }
                  }
                }
              },
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
                        Text("Coins Available:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17,color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Exchange Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor)),
                        Text("0",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17,color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                    Divider(color: Colors.white),
                    SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Crypto Rate:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,color: kPrimaryColor)),
                        Text("0.0000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17,color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(height: smallPadding),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            TextFormField(
              controller: mYouGet,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              style: const TextStyle(color: kPrimaryColor),
              readOnly: true,
              decoration: InputDecoration(
                labelText: "You Get",
                hintText: "0",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                // Enable the filled property
                fillColor: Colors.white, // Set the background color to white
              ),
              minLines: 1,
              maxLines: 6,
            ),
            const SizedBox(height: defaultPadding),
            GestureDetector(
              onTap: () {
                if (currency.isNotEmpty) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Select Currency',
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children:
                            currency.map((CurrencyListsData currencyItem) {
                              return ListTile(
                                title: Text(
                                  currencyItem.currencyCode!,
                                  style: const TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.pop(
                                      context, currencyItem.currencyCode);
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
                        selectedCurrency =
                            newValue; // Update the selected currency
                        if(selectedCurrency != "Select Currency"){
                          if(selectedCoinType != "Coin"){
                            if(mAmount.text.isNotEmpty){
                              mCryptoBuySellCalculation();
                            }
                          }
                        }
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
                        selectedCurrency ?? "Select Currency",
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35.0),
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
                onPressed: (){
                 /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConfirmBuyScreen()),
                  );*/

                },  // Disable button since it's triggered by API call
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                )
                    : const Text('Proceed',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _showTransferTypeDropDown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions(
                'BTC', 'https://assets.coincap.io/assets/icons/btc@2x.png'),
            _buildTransferOptions(
                'BNB', 'https://assets.coincap.io/assets/icons/bnb@2x.png'),
            _buildTransferOptions(
                'ADA', 'https://assets.coincap.io/assets/icons/ada@2x.png'),
            _buildTransferOptions(
                'SOL', 'https://assets.coincap.io/assets/icons/sol@2x.png'),
            _buildTransferOptions(
                'DOGE', 'https://assets.coincap.io/assets/icons/doge@2x.png'),
            _buildTransferOptions(
                'LTC', 'https://assets.coincap.io/assets/icons/ltc@2x.png'),
            _buildTransferOptions(
                'ETH', 'https://assets.coincap.io/assets/icons/eth@2x.png'),
            _buildTransferOptions(
                'SHIB', 'https://assets.coincap.io/assets/icons/shib@2x.png'),
          ],
        );
      },
    );
  }

  Widget _buildTransferOptions(String type, String logoPath) {
    return ListTile(
      title: Row(
        children: [
          ClipOval(child: Image.network(logoPath, height: 30),),
          const SizedBox(width: 8.0),
          Text(type,style: const TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),),
        ],
      ),
      onTap: () {
        setState(() {
          selectedCoinType = type;
        });
        Navigator.pop(context);
      },
    );
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "BTC":
        return 'https://assets.coincap.io/assets/icons/btc@2x.png';
      case "BNB":
        return 'https://assets.coincap.io/assets/icons/bnb@2x.png';
      case "ADA":
        return 'https://assets.coincap.io/assets/icons/ada@2x.png';
      case "SOL":
        return 'https://assets.coincap.io/assets/icons/sol@2x.png';
      case "DOGE":
        return 'https://assets.coincap.io/assets/icons/doge@2x.png';
      case "LTC":
        return 'https://assets.coincap.io/assets/icons/ltc@2x.png';
      case "ETH":
        return 'https://assets.coincap.io/assets/icons/eth@2x.png';
      case "SHIB":
        return 'https://assets.coincap.io/assets/icons/shib@2x.png';
      default:
        return 'assets/icons/default.png'; // Default image if needed
    }
  }
}
