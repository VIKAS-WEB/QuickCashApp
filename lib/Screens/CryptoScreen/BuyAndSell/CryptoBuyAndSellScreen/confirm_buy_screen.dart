import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/walletAddressModel/walletAddressApi.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/auth_manager.dart';

import '../../../../util/customSnackBar.dart';

class ConfirmBuyScreen extends StatefulWidget {
  final String? mCryptoAmount;
  final String? mCurrency;
  final String? mCoinName;
  final double? mFees;
  final String? mYouGetAmount;
  final double? mEstimateRates;
  final String? mCryptoType;
  const ConfirmBuyScreen({super.key,this.mCryptoAmount, this.mCurrency, this.mCoinName, this.mFees, this.mYouGetAmount, this.mEstimateRates, this.mCryptoType});

  @override
  State<ConfirmBuyScreen> createState() => _ConfirmBuyScreenState();
}

class _ConfirmBuyScreenState extends State<ConfirmBuyScreen> {
  final CryptoBuyWalletAddressApi _cryptoBuyWalletAddressApi = CryptoBuyWalletAddressApi();

  final TextEditingController walletAddress = TextEditingController();

  String? selectedTransferType;
  bool isCryptoBuy = true;
  bool isLoading = false;

  String? mAmount;
  String? mCurrency;
  String? mCoin;
  double? mFees;
  String? mGetAmount;
  double? mEstimateRate;
  double? mTotalAmount;


  @override
  void initState() {
    mPrintData();

    if(widget.mCryptoType == "Crypto Buy"){
      mWalletAddress();
      isCryptoBuy = true;
    }else{
      isCryptoBuy = false;
    }

    super.initState();
  }

  Future<void> mPrintData() async {
    mAmount = widget.mCryptoAmount;
    mCurrency = widget.mCurrency;
    mCoin = widget.mCoinName;
    mFees = widget.mFees;
    mGetAmount = widget.mYouGetAmount;
    mEstimateRate = widget.mEstimateRates;

    double amountValue = (mAmount != null) ? double.tryParse(mAmount!) ?? 0.0 : 0.0;
    double feesValue = mFees ?? 0.0;
    mTotalAmount = amountValue + feesValue;
  }

  Future<void> mWalletAddress() async {
    setState(() {
      isLoading = true;
    });

    try{
      String coinName = '${mCoin}_TEST';
      final response = await _cryptoBuyWalletAddressApi.cryptoBuyWalletAddressApi(coinName, AuthManager.getUserEmail());

      if(response.message == "Response"){
        setState(() {
          walletAddress.text = response.data.addresses.first.address;
          isLoading = false;
        });
      }else{
       setState(() {
         isLoading = false;
         CustomSnackBar.showSnackBar(
             context: context,
             message: "We are facing some issue!",
             color: kPrimaryColor);
       });
      }
    }catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            context: context,
            message: "Wallet Address not found",
            color: kPrimaryColor);
      });
    }
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
        title: Text(
          "${widget.mCryptoType}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              isCryptoBuy ? mCryptoBuy() : mCryptoSell(),
            ],
          ),
        ),
      ),
    );
  }

  Widget mCryptoBuy() {
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.all(0),
      child: Column(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Amount:",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    Text(
                      "${mAmount!} $mCurrency",
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
                const Divider(
                  color: kPrimaryLightColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Fees:",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    Text(
                      "${mFees!} $mCurrency",
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
                const Divider(
                  color: kPrimaryLightColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount:",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    Text(
                      "$mTotalAmount $mCurrency ",
                      style: const TextStyle(color: kPrimaryColor),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text("You will get",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),),
                ),

                const SizedBox(height: defaultPadding,),
                Text('${mGetAmount?.toString() ?? '0.0'} - $mCoin',style: const TextStyle(color: kPrimaryColor),),
                const Divider(color: kPrimaryLightColor,),
                Text("1 USD = ${mEstimateRate.toString()}",style: const TextStyle(color: kPrimaryColor),),
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
            controller: walletAddress,
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
      ),),
    );
  }

  Widget mCryptoSell() {
    return SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(0),
      child: Column(
        children: [],
      ),),
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

}



