import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';
import '../../../../constants.dart';
import '../../../HomeScreen/home_screen.dart';

class TransactionSuccessScreen extends StatefulWidget {
  final double? totalAmount;
  final String? currency;
  final String? coinName;
  final String? gettingCoin;
  final String? mCryptoType;

  const TransactionSuccessScreen({super.key, this.totalAmount, this.currency, this.coinName, this.gettingCoin, this.mCryptoType});

  @override
  State<TransactionSuccessScreen> createState() => _TransactionSuccessScreen();
}

class _TransactionSuccessScreen extends State<TransactionSuccessScreen> {

  Future<bool> _onWillPop() async {
    return Future.value(false);
  }

  bool isCryptoBuy = false;

  @override
  void initState() {
    if(widget.mCryptoType == "Crypto Buy"){
      isCryptoBuy = true;
    }else{
      isCryptoBuy = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Background(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: <Widget>[

              isCryptoBuy? mCryptoBuySuccess() : mCryptoSellSuccess(),
            ],
          ),
          ),
        ),
      ),
    );
  }

  // Widget Crypto Buy Transaction Success Screen
  Widget mCryptoBuySuccess() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/payment_success.png",
            fit: BoxFit.contain,
            width: 110,
            height: 110,
          ),
          const SizedBox(
            height: largePadding,
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
          const SizedBox(height: 55),
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
                const Text(
                  "Total",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "${widget.totalAmount} ${widget.currency}",
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 5, // Limit the number of lines if needed
                  overflow: TextOverflow.ellipsis, // Truncate text if it's too long
                ),
              ],
            ),
          ),
          const SizedBox(height: largePadding),
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
          const SizedBox(height: 95),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
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
    );
  }

  // Widget Crypto Sell Transaction Success Screen
  Widget mCryptoSellSuccess() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/payment_success.png",
            fit: BoxFit.contain,
            width: 110,
            height: 110,
          ),
          const SizedBox(
            height: largePadding,
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
          const SizedBox(height: 55),
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
                const Text(
                  "Getting Amount",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  "${widget.totalAmount} ${widget.currency}",
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 5, // Limit the number of lines if needed
                  overflow: TextOverflow.ellipsis, // Truncate text if it's too long
                ),
              ],
            ),
          ),
          const SizedBox(height: largePadding),
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
                  "Total Coin Sell",
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
          const SizedBox(height: 95),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
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
    );
  }

}
