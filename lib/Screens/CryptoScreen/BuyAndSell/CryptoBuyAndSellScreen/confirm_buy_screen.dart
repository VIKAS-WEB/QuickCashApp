import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/cryptoBuyAddModel/cryptoBuyAddApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/cryptoBuyAddModel/cryptoBuyAddModel.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/cryptoTransactionGetDetails/cryptoTransactionGetDetailsApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/walletAddressModel/walletAddressApi.dart';
import 'package:quickcash/Screens/HomeScreen/home_screen.dart';
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

  const ConfirmBuyScreen(
      {super.key,
      this.mCryptoAmount,
      this.mCurrency,
      this.mCoinName,
      this.mFees,
      this.mYouGetAmount,
      this.mEstimateRates,
      this.mCryptoType});

  @override
  State<ConfirmBuyScreen> createState() => _ConfirmBuyScreenState();
}

class _ConfirmBuyScreenState extends State<ConfirmBuyScreen> {
  final CryptoBuyWalletAddressApi _cryptoBuyWalletAddressApi =
      CryptoBuyWalletAddressApi();
  final CryptoBuyAddApi _cryptoBuyAddApi = CryptoBuyAddApi();
  final CryptoTransactionGetDetailsApi _cryptoTransactionGetDetailsApi = CryptoTransactionGetDetailsApi();

  final TextEditingController walletAddress = TextEditingController();

  String? selectedTransferType;
  bool isCryptoBuy = true;
  bool isLoading = false;
  bool isUpdateLoading = false;

  String? mAmount;
  String? mCurrency;
  String? mCoin;
  double? mFees;
  String? mGetAmount;
  double? mEstimateRate;
  double? mTotalAmount;
  double? mTotalCryptoSellAmount;

  // Crypto Sell Add TransactionId
  String? mCryptoSellAddTransactionId;

  @override
  void initState() {
    mSetData();

    if (widget.mCryptoType == "Crypto Buy") {
      mWalletAddress();
      isCryptoBuy = true;
    } else {
      isCryptoBuy = false;
    }
    super.initState();
  }

  // Set Data
  Future<void> mSetData() async {
    mAmount = widget.mCryptoAmount;
    mCurrency = widget.mCurrency;
    mCoin = widget.mCoinName;
    mFees = widget.mFees;
    mGetAmount = widget.mYouGetAmount;
    mEstimateRate = widget.mEstimateRates;

    // Crypto Buy Calculation Total
    double amountValue =
        (mAmount != null) ? double.tryParse(mAmount!) ?? 0.0 : 0.0;
    double feesValue = mFees ?? 0.0;
    mTotalAmount = amountValue + feesValue;

    // Crypto Sell Calculate Total
    double amountValueSell =
        (mAmount != null) ? double.tryParse(mAmount!) ?? 0.0 : 0.0;
    double feesValueSell = mFees ?? 0.0;
    mTotalCryptoSellAmount = amountValueSell - feesValueSell;
  }

  // Wallet Address Api
  Future<void> mWalletAddress() async {
    setState(() {
      isLoading = true;
    });

    try {
      String coinName = '${mCoin}_TEST';
      final response = await _cryptoBuyWalletAddressApi
          .cryptoBuyWalletAddressApi(coinName, AuthManager.getUserEmail());

      if (response.message == "Response") {
        setState(() {
          walletAddress.text = response.data.addresses.first.address;
          isLoading = false;

        });
      } else {
        setState(() {
          isLoading = false;
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
            message: "Wallet Address not found",
            color: kPrimaryColor);
      });
    }
  }

  // Crypto Buy Add Api -
  Future<void> mCryptoBuyAddApi() async {
    if (selectedTransferType != null) {
      setState(() {
        isUpdateLoading = true;
      });

      try {
        int amount = int.parse(mAmount!);
        int? fees = mFees?.toInt();
        String coinType = '${mCoin}_TEST';

        final request = CryptoBuyAddRequest(
          userId: AuthManager.getUserId(),
          amount: amount,
          coinType: coinType,
          currencyType: mCurrency ?? '',
          fees: fees ?? 0,
          noOfCoins: mGetAmount!,
          paymentType: "Bank Transfer",
          side: "buy",
          status: "pending",
          walletAddress: walletAddress.text,
        );

        final response = await _cryptoBuyAddApi.cryptoBuyAddApi(request);

        if (response.message == "Crypto Transactions successfully !!!") {
          setState(() {
            isUpdateLoading = false;
            mCryptoSellAddTransactionId = response.data.id;

            mTransactionDetails(response.data.id);
          });
        } else if (response.message == "All fields are mandatory") {
          setState(() {
            CustomSnackBar.showSnackBar(
                context: context,
                message: "All fields are mandatory",
                color: kPrimaryColor);
            isUpdateLoading = false;
          });
        } else {
          setState(() {
            isUpdateLoading = false;
          });
        }
      } catch (error) {
        setState(() {
          isUpdateLoading = false;
          CustomSnackBar.showSnackBar(
            context: context,
            message: "Something went wrong!",
            color: kPrimaryColor,
          );
        });
      }
    } else {
      CustomSnackBar.showSnackBar(
        context: context,
        message: "Please Select Transfer Type!",
        color: kPrimaryColor,
      );
    }
  }


  // Crypto Transaction Details api ----
  Future<void> mTransactionDetails(String id) async{
    setState(() {
      isLoading = true;
    });

    try{
      final response = await _cryptoTransactionGetDetailsApi.cryptoTransactionGetDetailsApiApi(id);

      if(response.message == "list are fetched Successfully"){
        setState(() {
          isLoading = false;
          mPaymentSuccessDialog(context,mTotalAmount,mCurrency,mCoin,mGetAmount);
        });

      }else{
        setState(() {
          isLoading = false;
          CustomSnackBar.showSnackBar(
            context: context,
            message: "We are facing some issue!",
            color: kPrimaryColor,
          );
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(
          context: context,
          message: "Something went wrong!",
          color: kPrimaryColor,
        );
      });
    }

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Text(
                      "Confirm ${widget.mCryptoType}",
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: largePadding,
                    ),
                    isCryptoBuy ? mCryptoBuy() : mCryptoSell(),
                  ],
                ),
              ),
            ),
    );
  }

  // Widget Crypto Sell -----------
  Widget mCryptoBuy() {
    return SingleChildScrollView(
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

          const SizedBox(
            height: smallPadding,
          ),
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
                  child: Text(
                    "You will get",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  '${mGetAmount?.toString() ?? '0.0'} - $mCoin',
                  style: const TextStyle(color: kPrimaryColor),
                ),
                const Divider(
                  color: kPrimaryLightColor,
                ),
                Text(
                  "1 $mCurrency = ${mEstimateRate.toString()}",
                  style: const TextStyle(color: kPrimaryColor),
                ),
              ],
            ),
          ),

          const SizedBox(height: 45.0),
          GestureDetector(
            onTap: () => _showTransferTypeDropDown(context, true),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
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
                        const SizedBox(
                          width: smallPadding,
                        ),
                      Text(
                        selectedTransferType != null
                            ? '$selectedTransferType ${_getFlagForTransferType(selectedTransferType!)}'
                            : 'Transfer Type',
                        style:
                            const TextStyle(color: kPrimaryColor, fontSize: 16),
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

          const SizedBox(
            height: defaultPadding,
          ),
          if (isUpdateLoading)
            const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ), // Show loading indicator

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
              onPressed: isUpdateLoading ? null : mCryptoBuyAddApi,
              child: const Text('Confirm & Buy',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Crypto Sell ---------------
  Widget mCryptoSell() {
    return SingleChildScrollView(
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
                      "No of Coins:",
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
                    Text(
                      "Amount for ${mAmount!} $mCoin = $mGetAmount $mCurrency",
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
          const SizedBox(
            height: smallPadding,
          ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "You will get",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                const Text(
                  'Total Amount = Amount - Fees',
                  style: TextStyle(color: kPrimaryColor),
                ),
                /* const Divider(color: kPrimaryLightColor,),*/
                const SizedBox(
                  height: smallPadding,
                ),
                Text(
                  "$mCurrency $mTotalCryptoSellAmount",
                  style: const TextStyle(color: kPrimaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 55.0),
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
              onPressed: () {
                // Something ....
              },
              child: const Text('Confirm & Sell',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
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
          Image.asset(
            logoPath,
            height: 24,
            color: kPrimaryColor,
          ),
          const SizedBox(width: defaultPadding),
          Text(
            type,
            style: const TextStyle(color: kPrimaryColor),
          ),
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

  String _getFlagForTransferType(String transferType) {
    switch (transferType) {
      case "Bank":
        return 'Bank Transfer';
      default:
        return '';
    }
  }
}

Future<void> mPaymentSuccessDialog(BuildContext context, double? mTotalAmount, String? mCurrency, String? mCoin, String? mGetAmount) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PaymentSuccessScreen(
        totalAmount: mTotalAmount,
          currency: mCurrency,
          coinName: mCoin,
          gettingCoin: mGetAmount,
      );
    },
  );
}

class PaymentSuccessScreen extends StatefulWidget {
  final double? totalAmount;
  final String? currency;
  final String? coinName;
  final String? gettingCoin;

  const PaymentSuccessScreen({super.key,this.totalAmount,this.currency,this.coinName,this.gettingCoin});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  double screenWidth = 600;
  double screenHeight = 400;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      content: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 55,
              ),
              Image.asset(
                "assets/images/payment_success.png",
                fit: BoxFit.contain,
                width: 110, // Set your desired width
                height: 110, // Set your desired height
              ),
              const SizedBox(
                height: 55,
              ),
              const Text(
                "Thank You!",
                style: TextStyle(
                    color: kGreenColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Transaction Completed",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                "Please wait for admin admin approval!",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              const SizedBox(height: largePadding,),
              Container(
                height: 90,
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text("Total",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500,fontSize: 16),),
                    const SizedBox(height: 5,),
                    Text("${widget.totalAmount} ${widget.currency}",style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold,fontSize: 16),maxLines: 5, // Limit the number of lines if needed
                      overflow: TextOverflow.ellipsis,),

                  ],
                ),
              ),

              const SizedBox(height: largePadding,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Getting Coin",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    // Use TextOverflow and maxLines to prevent overflow
                    Text(
                      '${widget.gettingCoin?.toString() ?? '0.0'} - ${widget.coinName}',
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      maxLines: 5, // Limit the number of lines if needed
                      overflow: TextOverflow.ellipsis, // Truncate text if it's too long
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),

              const SizedBox(height: 65,),

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
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text('Home',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),



            ],
          ),
        ),
      ),
      /*actions: [
        TextButton(
          onPressed: isLoading ? null : mCreateTicket,
          child: const Text('Post Ticket'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],*/
    );
  }
}
