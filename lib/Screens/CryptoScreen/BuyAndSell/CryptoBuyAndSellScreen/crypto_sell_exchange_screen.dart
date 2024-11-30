import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoBuyModel/cryptoBuyApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoBuyModel/cryptoBuyModel.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoSellFetchCoinDataModel/cryptoSellFetchCoinApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoSellFetchCoinPriceModel/cryptoSellFetchCoinPriceApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/cryptoSellFetchCoinPriceModel/cryptoSellFetchCoinPriceModel.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

import '../../../../model/currencyApiModel/currencyApi.dart';
import '../../../../model/currencyApiModel/currencyModel.dart';
import 'confirm_buy_screen.dart';

class CryptoBuyAnsSellScreen extends StatefulWidget {
  const CryptoBuyAnsSellScreen({super.key});

  @override
  State<CryptoBuyAnsSellScreen> createState() => _CryptoBuyAnsSellScreenState();
}

class _CryptoBuyAnsSellScreenState extends State<CryptoBuyAnsSellScreen> {
  final CurrencyApi _currencyApi = CurrencyApi();
  final CryptoBuyApi _cryptoBuyApi = CryptoBuyApi();
  final CryptoSellFetchCoinDataApi _cryptoSellFetchCoinDataApi =
      CryptoSellFetchCoinDataApi();
  final CryptoSellFetchCoinPriceApi _cryptoSellFetchCoinPriceApi =
      CryptoSellFetchCoinPriceApi();

  final TextEditingController mAmount = TextEditingController();
  final TextEditingController mYouGet = TextEditingController();

  String? selectedCurrency; // Variable to hold selected coin
  List<CurrencyListsData> currency = [];

  bool isLoading = false;
  bool isBuySelected = true;
  String? selectedCoinType;

  String? sideType = "buy";

  // Crypto Sell
  double? mEstimatedRate;
  double? fees;
  double? mCryptoFees;
  double? mExchangeFees;

  // Crypto Buy
  String? coinName;
  String? mCryptoSellCoinAvailable = "0.0";
  double? mSellCryptoFees;
  double? mSellExchangeFees;

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
  Future<void> mCryptoBuySellCalculation() async {
    setState(() {
      isLoading = true;
    });

    try {
      int amount = int.parse(mAmount.text);
      final request = CryptoBuyRequest(
          amount: amount,
          coinType: selectedCoinType!,
          currencyType: selectedCurrency!,
          sideType: sideType!);
      final response = await _cryptoBuyApi.cryptoBuyApi(request);

      if (response.message == "Success") {
        setState(() {
          isLoading = false;

          mEstimatedRate = response.data.rate;
          mYouGet.text = response.data.numberofCoins.toString();
          fees = response.data.fees;
          mCryptoFees = response.data.cryptoFees;
          mExchangeFees = response.data.exchangeFees;
        });
      } else if (response.message ==
          "Make sure you have fill amount,currency and coin") {
        isLoading = false;
        mEstimatedRate = 0.0;
        fees = 0.0;
        mCryptoFees = 0.0;
        mExchangeFees = 0.0;
      } else {
        setState(() {
          isLoading = false;
          mEstimatedRate = 0.0;
          fees = 0.0;
          mCryptoFees = 0.0;
          mExchangeFees = 0.0;
          CustomSnackBar.showSnackBar(
              context: context,
              message: "We are facing some issue!",
              color: kPrimaryColor);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Something went wrong!",
            color: kPrimaryColor);
      });
    }
  }

  // Crypto Sell Fetch Coin ----
  Future<void> mCryptoSellFetchCoinData() async {
    setState(() {
      isLoading = true;
    });

    try {
      coinName = '${selectedCoinType}_TEST';
      final response = await _cryptoSellFetchCoinDataApi
          .cryptoSellFetchCoinDataApi(coinName!);

      if (response.message == "crypto coins are fetched Successfully") {
        setState(() {
          isLoading = false;
          mCryptoSellCoinAvailable = response.data;
        });
      } else {
        setState(() {
          mCryptoSellCoinAvailable = "0";
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        mCryptoSellCoinAvailable = "0";
        CustomSnackBar.showSnackBar(
            context: context,
            message: "No of Coins not found",
            color: kPrimaryColor);
      });
    }
  }

  // Crypto Sell Fetch Coin -----------------------------
  Future<void> mCryptoSellFetchCoinPrice() async {
    setState(() {
      isLoading = true;
    });

    try {
      final request = CryptoSellFetchCoinPriceRequest(
          coinType: selectedCoinType!,
          currencyType: selectedCurrency!,
          noOfCoins: mAmount.text);
      final response = await _cryptoSellFetchCoinPriceApi
          .cryptoSellFetchCoinPriceApi(request);

      if (response.message == "Success") {
        setState(() {
          isLoading = false;
          mSellCryptoFees = response.data.cryptoFees;
          mSellExchangeFees = response.data.exchangeFees;
          mYouGet.text = response.data.amount;
        });
      } else {
        setState(() {
          isLoading = false;
          mSellCryptoFees = 0.0;
          mSellExchangeFees = 0.0;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Something went wrong!",
            color: kPrimaryColor);
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
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: kPrimaryColor),
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
                          mAmount.clear();
                          mYouGet.clear();
                          mCryptoSellCoinAvailable = "0.0";
                          mSellCryptoFees = 0.0;
                          mSellExchangeFees = 0.0;
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
                          mYouGet.clear();
                          mAmount.clear();
                          mCryptoFees = 0.0;
                          mExchangeFees = 0.0;
                          mEstimatedRate = 0.0;
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
                        if (selectedCurrency != null) {
                          if (selectedCoinType != null) {
                            if (mAmount.text.isNotEmpty) {
                              mCryptoBuySellCalculation();
                            }
                          }
                        }
                      });
                    }
                  });
                }
              },
              child: Material(
                color: Colors.transparent,
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
              onChanged: (value) {
                setState(() {
                  if (selectedCurrency != null) {
                    if (selectedCoinType != null) {
                      if (mAmount.text.isNotEmpty) {
                        mCryptoBuySellCalculation();
                      }
                    }
                  }
                });
              },
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
            ),
            const SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              color: kPrimaryLightColor,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Crypto Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                        Text(
                          '${mCryptoFees?.toString() ?? '0.0'} ${selectedCurrency ?? ""} ',
                          // Fallback to '0' if mCryptoFees is null
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                    mExchangeFees != 0
                        ? Column(
                            children: [
                              const SizedBox(height: smallPadding),
                              const Divider(color: Colors.white),
                              const SizedBox(height: smallPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Exchange Fees:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: kPrimaryColor)),
                                  Text(
                                      '${mExchangeFees?.toString() ?? '0.0'} ${selectedCurrency ?? ""}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: kPrimaryColor)),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: smallPadding),
                    const Divider(color: Colors.white),
                    const SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Estimated Rate:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                        Text(mEstimatedRate?.toString() ?? '0.0',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                      ],
                    ),
                    const SizedBox(height: smallPadding),
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
                                return const Icon(Icons.broken_image,
                                    color: Colors.red);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // Disable button if mAmount is null
                onPressed: isLoading &&
                        mAmount.text.isEmpty &&
                        selectedCurrency != null &&
                        selectedCoinType != null
                    ? null
                    : () {
                        if (mAmount.text.isNotEmpty &&
                            selectedCurrency != null &&
                            selectedCoinType != null &&
                            mCryptoFees != null &&
                            mYouGet.text.isNotEmpty &&
                            mEstimatedRate != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  ConfirmBuyScreen(
                                  mCryptoAmount: mAmount.text,
                                  mCurrency: selectedCurrency,
                                  mCoinName: selectedCoinType,
                                  mFees: mCryptoFees,
                                  mYouGetAmount: mYouGet.text,
                                  mEstimateRates: mEstimatedRate,
                                  mCryptoType: "Crypto Buy"),
                            ),
                          );
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(kWhiteColor),
                      )
                    : const Text(
                        'Proceed',
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
                                return const Icon(Icons.broken_image,
                                    color: Colors.red);
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
              onChanged: (value) {
                if (selectedCurrency != null) {
                  if (selectedCoinType != null) {
                    if (mAmount.text.isNotEmpty) {
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
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Card(
              elevation: 4.0,
              color: kPrimaryLightColor,
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Coins Available:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                        Text(mCryptoSellCoinAvailable!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                      ],
                    ),
                    mSellExchangeFees != 0
                        ? Column(
                            children: [
                              const SizedBox(height: smallPadding),
                              const Divider(color: Colors.white),
                              const SizedBox(height: smallPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Exchange Fees:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: kPrimaryColor)),
                                  Text(
                                      '${mSellExchangeFees?.toString() ?? '0.0'} ${selectedCurrency ?? ""}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: kPrimaryColor)),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: smallPadding),
                    const Divider(color: Colors.white),
                    const SizedBox(height: smallPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Crypto Fees:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                        Text(
                            '${mSellCryptoFees?.toString() ?? '0.0'} ${selectedCurrency ?? ""}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: kPrimaryColor)),
                      ],
                    ),
                    const SizedBox(height: smallPadding),
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
                      if (isBuySelected == true) {
                        setState(() {
                          selectedCurrency =
                              newValue; // Update the selected currency
                          if (selectedCurrency != null) {
                            if (selectedCoinType != null) {
                              if (mAmount.text.isNotEmpty) {
                                mCryptoBuySellCalculation();
                              }
                            }
                          }
                        });
                      } else {
                        setState(() {
                          if (selectedCoinType == null) {
                            CustomSnackBar.showSnackBar(
                                context: context,
                                message: "Please Select Coin",
                                color: kPrimaryColor);
                          } else if (mAmount.text.isEmpty) {
                            CustomSnackBar.showSnackBar(
                                context: context,
                                message: "Please Enter No Of Coin",
                                color: kPrimaryColor);
                          } else {
                            selectedCurrency = newValue;

                            if (selectedCurrency != null) {
                              mCryptoSellFetchCoinPrice();
                            }
                          }
                        });
                      }
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // Disable button if mAmount is null
                onPressed: isLoading &&
                        mAmount.text.isEmpty &&
                        selectedCurrency != null &&
                        selectedCoinType != null
                    ? null
                    : () {
                        if (mAmount.text.isNotEmpty &&
                            selectedCurrency != null &&
                            selectedCoinType != null &&
                            mSellCryptoFees != null &&
                            mYouGet.text.isNotEmpty &&
                            mEstimatedRate != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmBuyScreen(
                                  mCryptoAmount: mAmount.text,
                                  mCurrency: selectedCurrency,
                              mCoinName: selectedCoinType,
                              mFees: mSellCryptoFees,
                              mYouGetAmount: mYouGet.text,
                              mEstimateRates: mEstimatedRate,
                              mCryptoType: "Crypto Sell"),
                            ),
                          );
                        }
                      },
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(kWhiteColor),
                      )
                    : const Text(
                        'Proceed',
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
          ClipOval(
            child: Image.network(logoPath, height: 30),
          ),
          const SizedBox(width: 8.0),
          Text(
            type,
            style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          selectedCoinType = type;
          if (selectedCurrency != null) {
            if (selectedCoinType != null) {
              if (mAmount.text.isNotEmpty) {
                mCryptoBuySellCalculation();
              }
            }
          }

          mCryptoSellFetchCoinData();
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
