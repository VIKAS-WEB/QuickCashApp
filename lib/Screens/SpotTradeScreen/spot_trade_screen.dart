import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class SpotTradeScreen extends StatefulWidget {
  const SpotTradeScreen({super.key});

  @override
  State<SpotTradeScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<SpotTradeScreen> {
  String? selectedTransferType;
  String? selectedSendCurrency;

  void _showTransferTypeDropDown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions('BTCUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('BNBUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('ADAUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('SOLUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('DOGEUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('LTCUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('ETHUSDT', 'assets/icons/menu_crypto.png'),
            _buildTransferOptions('SHIBUSDT', 'assets/icons/menu_crypto.png'),
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
          "Spot Trade",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


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



          ],
        ),),
      ),
    );
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "BTCUSDT":
      case "BNBUSDT":
      case "ADAUSDT":
      case "SOLUSDT":
      case "DOGEUSDT":
      case "LTCUSDT":
      case "ETHUSDT":
      case "SHIBUSDT":
        return 'assets/icons/menu_crypto.png';
      default:
        return 'assets/icons/default.png';
    }
  }

  String _getFlagForTransferType(String transferType) {
    switch (transferType) {
      case "btc":
        return 'BTCUSDT';
      case "bnb":
        return 'BNBUSDT';
      case "ada":
        return 'ADAUSDT';
      case "solu":
        return 'SOLUSDT';
      case "doge":
        return 'DOGEUSDT';
      case "ltc":
        return 'LTCUSDT';
      case "eth":
        return 'ETHUSDT';
      case "shib":
        return 'SHIBUSDT';
      default:
        return '';
    }
  }

}