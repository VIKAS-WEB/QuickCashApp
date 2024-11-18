import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressApi.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressModel.dart';
import 'package:quickcash/constants.dart';

class WalletAddressScreen extends StatefulWidget {
  const WalletAddressScreen({super.key});

  @override
  State<WalletAddressScreen> createState() => _WalletAddressScreenState();
}

class _WalletAddressScreenState extends State<WalletAddressScreen> {
  final WalletAddressApi _walletAddressApi = WalletAddressApi();
  List<WalletAddressListsData> walletAddressList = [];

/*
  final List<String> walletTypes = ["ADA", "BTC", "ETH", "LTC"];
  final List<String> walletBalances = ["0", "0.99988454", "1.154665", "0.999880000"]; // Example balances
*/

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mWalletAddress();
  }

  Future<void> mWalletAddress() async{
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final response = await _walletAddressApi.walletAddressApi();

      if(response.walletAddressList !=null && response.walletAddressList!.isNotEmpty){
        setState(() {
          walletAddressList = response.walletAddressList!;
          isLoading = false;
        });
      }else{
        setState(() {
          isLoading = false;
          errorMessage = 'No Wallet Address';
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
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
          "Wallet Address",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      ) : Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: walletAddressList.length,
          itemBuilder: (context, index) {
            final walletData = walletAddressList[index];
            return Card(
              elevation: 4.0,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          walletData.coin!.split('_')[0],  // Split by underscore and show the first part
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        // Show image corresponding to the coin
                        ClipOval(
                          child: Image.network(
                            _getImageForCoin(walletData.coin!.split('_')[0]),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover, // Ensure the image fills the circle
                          ),
                        )

                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          walletData.noOfCoins!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kPurpleColor
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: smallPadding,),
                    SizedBox(height: 40,width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor, // Change this to any color you prefer
                      ),
                      child: const Text('View Address',style: TextStyle(fontSize: 15),),
                    ),
                    ),
                    /*OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: kPurpleColor, width: 1),
                      ),
                      child: const Text("View Address",
                        style: TextStyle(color: kPurpleColor),
                      ),
                    ),*/
                  ],
                ),
              ),
            );
          },
        )
        ,
      ),
    );
  }
}

String _getImageForCoin(String coin) {
  switch (coin) {
    case "BTC":
      return 'https://assets.coincap.io/assets/icons/btc@2x.png';
    case "BCH":
      return 'https://assets.coincap.io/assets/icons/bch@2x.png';
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
