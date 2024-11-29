import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class ConfirmBuyScreen extends StatefulWidget {
  final String? mCryptoAmount;
  final String? mCurrency;
  final String? mCoinName;
  final double? mFees;
  final String? mYouGetAmount;
  final double? mEstimateRates;
  const ConfirmBuyScreen({super.key,this.mCryptoAmount, this.mCurrency, this.mCoinName, this.mFees, this.mYouGetAmount, this.mEstimateRates});

  @override
  State<ConfirmBuyScreen> createState() => _ConfirmBuyScreenState();
}

class _ConfirmBuyScreenState extends State<ConfirmBuyScreen> {
  String? selectedTransferType;


  @override
  void initState() {
    mPrintData();
    super.initState();
  }

  Future<void> mPrintData() async {
    print('Get Amount: ${widget.mYouGetAmount}');
    print('Fees: ${widget.mFees}');
    print('Coin Name: ${widget.mCoinName}');
    print('Currency: ${widget.mCurrency}');
    print('Estimated Rate: ${widget.mEstimateRates}');
    print('Crypto Amount: ${widget.mCryptoAmount}');
  }

  void _showTransferTypeDropDown(BuildContext context, bool isTransfer) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions(
              'Bank Transfer',
              'assets/icons/bank.png',
              isTransfer,
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransferOptions(String type, String logoPath, bool isTransfer) {
    return ListTile(
      title: Row(
        children: [
          const SizedBox(width: defaultPadding),
          Image.asset(logoPath, height: 24,color: kPrimaryColor,),
          const SizedBox(width: defaultPadding),
          Text(type,style: const TextStyle(color: kPrimaryColor),),
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
          "Confirm Buy",
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount:",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        Text(
                          "1 USD",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    Divider(
                      color: kPrimaryLightColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fees:",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        Text(
                          "6 USD",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    Divider(
                      color: kPrimaryLightColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount:",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        Text(
                          "7 USD",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: smallPadding),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Divider line
                    Container(
                      height: 1,
                      width: 250,
                      color: kPrimaryLightColor,
                    ),
                    // Circular button
                    Material(
                      elevation: 4.0,
                      shape: const CircleBorder(),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_downward,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: smallPadding,),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("You will get",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),),
                    ),

                    SizedBox(height: defaultPadding,),
                    Text("0.2222222225558888 BTC",style: TextStyle(color: kPrimaryColor),),
                    Divider(color: kPrimaryLightColor,),
                    Text("1 USD = 0.555555555555 BTC",style: TextStyle(color: kPrimaryColor),),
                  ],
                ),
              ),

              const SizedBox(height: 45.0),
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
                            const SizedBox(width: smallPadding,),
                            Image.asset(
                              _getImageForTransferType(selectedTransferType!),
                              height: 24,
                              width: 24,
                              color: kPrimaryColor,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, color: Colors.red);
                              },
                            ),
                          const SizedBox(width: defaultPadding),
                          Text(
                            selectedTransferType != null
                                ? '$selectedTransferType ${_getFlagForTransferType(selectedTransferType!)}'
                                : 'Transfer Type',
                            style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25.0),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                style: const TextStyle(color: kPrimaryColor),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Wallet Address",
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
                    // Something ....
                  },
                  child: const Text('Confirm & Buy',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  String _getFlagForTransferType(String transferType) {
    switch (transferType) {
      case "Bank":
        return 'Bank Transfer';
      default:
        return '';
    }
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "Bank Transfer":
        return 'assets/icons/bank.png';

      default:
        return 'assets/icons/default.png';
    }
  }
}



