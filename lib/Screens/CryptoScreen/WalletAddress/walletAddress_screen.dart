import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mWalletAddress();
  }

  Future<void> mWalletAddress() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _walletAddressApi.walletAddressApi();

      if (response.walletAddressList != null && response.walletAddressList!.isNotEmpty) {
        setState(() {
          walletAddressList = response.walletAddressList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Wallet Address';
        });
      }
    } catch (error) {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
         child: Padding(padding: const EdgeInsets.all(defaultPadding),
         child:
           Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               SizedBox(
                 width: 180,
                 height: 45,
                 child: FloatingActionButton.extended(
                   onPressed: () {
                     mAddNewCoinBottomSheet(context);
                   },
                   label: const Text(
                     'Add New Coin',
                     style: TextStyle(color: Colors.white, fontSize: 15),
                   ),
                   icon: const Icon(Icons.add, color: Colors.white),
                   backgroundColor: kPrimaryColor,
                 ),
               ),

               const SizedBox(height: largePadding,),
               ListView.builder(
                 shrinkWrap: true,
                 itemCount: walletAddressList.length,
                 physics: const NeverScrollableScrollPhysics(),
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
                                 walletData.coin!.split('_')[0], // Split by underscore and show the first part
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
                                   color: kPurpleColor,
                                 ),
                               ),
                             ],
                           ),
                           const SizedBox(height: smallPadding),
                           SizedBox(
                             height: 40,
                             width: 150,
                             child: ElevatedButton(
                               onPressed: () {
                                 mWalletAddressBottomSheet(
                                     context, walletData.walletAddress!, walletData.coin!.split('_')[0]);
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: kPrimaryColor, // Change this to any color you prefer
                               ),
                               child: const Text(
                                 'View Address',
                                 style: TextStyle(fontSize: 15),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   );
                 },
               ),

             ],
           ),
         ),
      ),
    );
  }

  void mWalletAddressBottomSheet(BuildContext context, String walletAddress, String coinName) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return WalletAddressBottomSheet(
          mWalletAddress: walletAddress,
          coinName: coinName,
          onWalletAddressAdded: mWalletAddress,
        );
      },
    );
  }

  void mAddNewCoinBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AddNewCoinBottomSheet(onAddNewCoin: mWalletAddress);
        });
  }
}


class AddNewCoinBottomSheet extends StatefulWidget {
  final VoidCallback onAddNewCoin;
  const AddNewCoinBottomSheet({super.key, required this.onAddNewCoin});

  @override
  State<AddNewCoinBottomSheet> createState() => _AddNewCoinBottomSheet();
}

class _AddNewCoinBottomSheet extends State<AddNewCoinBottomSheet>{
  String? selectedTransferType;

  bool isLoading = false;
  String? errorMessage;

  void _showTransferTypeDropDown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions('BCH', 'https://assets.coincap.io/assets/icons/bch@2x.png'),
            _buildTransferOptions('BTC', 'https://assets.coincap.io/assets/icons/btc@2x.png'),
            _buildTransferOptions('BNB', 'https://assets.coincap.io/assets/icons/bnb@2x.png'),
            _buildTransferOptions('ADA', 'https://assets.coincap.io/assets/icons/ada@2x.png'),
            _buildTransferOptions('SOL', 'https://assets.coincap.io/assets/icons/sol@2x.png'),
            _buildTransferOptions('DOGE', 'https://assets.coincap.io/assets/icons/doge@2x.png'),
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

          const SizedBox(width: defaultPadding),
          Text(type,style: const TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),),
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
  Widget build(BuildContext context){
     return Padding(padding: const EdgeInsets.all(defaultPadding),
     child: Column(
       children: [
         const SizedBox(height: 0),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             const Text(
               'Request Wallet Address',
               style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
                 color: kPrimaryColor,
               ),
             ),
             IconButton(
               icon: const Icon(Icons.close, color: kPrimaryColor),
               onPressed: () {
                 Navigator.pop(context);
               },
             ),
           ],
         ),

         const SizedBox(height: 25,),
         GestureDetector(
           onTap: () => _showTransferTypeDropDown(context),
           child: Container(
             width: double.infinity,
             height: 60,
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
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     if (selectedTransferType != null)

                       ClipOval(
                         child: Image.network(

                           _getImageForCoin(selectedTransferType!),
                           height: 28,
                           width: 28,
                           errorBuilder: (context, error, stackTrace) {
                             return const Icon(Icons.broken_image, color: Colors.red);
                           },
                         ),
                       ),


                     const SizedBox(width: 8.0),
                     Text(
                       selectedTransferType != null
                           ? '$selectedTransferType'
                           : 'Select Coin',
                       style: const TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
                 const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
               ],
             ),
           ),
         ),

         const SizedBox(height: 45),

         const SizedBox(height: defaultPadding),
         if (isLoading) const CircularProgressIndicator(color: kPrimaryColor,), // Show loading indicator
         if (errorMessage != null) // Show error message if there's an error
           Text(errorMessage!, style: const TextStyle(color: Colors.red)),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 55),
           child: ElevatedButton(
             onPressed: (){},
             child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
           ),
         ),
         const SizedBox(height: 45),

       ],
     ),);
  }
}

class WalletAddressBottomSheet extends StatefulWidget {
  final VoidCallback onWalletAddressAdded;
  final String mWalletAddress;
  final String coinName;

  const WalletAddressBottomSheet({
    super.key,
    required this.onWalletAddressAdded,
    required this.mWalletAddress,
    required this.coinName,
  });

  @override
  State<WalletAddressBottomSheet> createState() => _WalletAddressBottomSheetState();
}

class _WalletAddressBottomSheetState extends State<WalletAddressBottomSheet> {
  final TextEditingController walledAddress = TextEditingController();
  String? mCoinName;

  @override
  void initState() {
    super.initState();
    // Set the wallet address passed from the parent widget
    walledAddress.text = widget.mWalletAddress;
    mCoinName = widget.coinName;
  }

  void _copyWalletAddress() {
    Clipboard.setData(ClipboardData(text: walledAddress.text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wallet Address link copied to clipboard!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wallet Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: kPrimaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Wallet Address for $mCoinName',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPurpleColor),
            ),
            const SizedBox(height: 20),
            // Referral Link
            const SizedBox(height: 20),
            TextFormField(
              controller: walledAddress,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.none,
              cursorColor: kPrimaryColor,
              onSaved: (value) {},
              readOnly: true,
              maxLines: 12,
              minLines: 1,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "Wallet Address",
                labelStyle: const TextStyle(color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.copy, color: kPrimaryColor),
                  onPressed: _copyWalletAddress, // Call the copy function
                ),
              ],
            ),
            const SizedBox(height: 45),
          ],
        ),
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
