import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class SpotTradeScreen extends StatefulWidget {
  const SpotTradeScreen({super.key});

  @override
  State<SpotTradeScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<SpotTradeScreen> {
  String? selectedTransferType;
  double sliderValue = 50;

  final List<Map<String, String>> recentTrades = [
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:28 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    {
      "price": "71417.67000000",
      "quantity": "0.00018000",
      "time": "05:33:38 PM"
    },
    // Add more trades here if needed
  ];

  void _showTransferTypeDropDown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            const SizedBox(height: 25),
            _buildTransferOptions('BTCUSDT', 'https://assets.coincap.io/assets/icons/btc@2x.png'),
            _buildTransferOptions('BNBUSDT', 'https://assets.coincap.io/assets/icons/bnb@2x.png'),
            _buildTransferOptions('ADAUSDT', 'https://assets.coincap.io/assets/icons/ada@2x.png'),
            _buildTransferOptions('SOLUSDT', 'https://assets.coincap.io/assets/icons/sol@2x.png'),
            _buildTransferOptions('DOGEUSDT', 'https://assets.coincap.io/assets/icons/doge@2x.png'),
            _buildTransferOptions('LTCUSDT', 'https://assets.coincap.io/assets/icons/ltc@2x.png'),
            _buildTransferOptions('ETHUSDT', 'https://assets.coincap.io/assets/icons/eth@2x.png'),
            _buildTransferOptions('SHIBUSDT', 'https://assets.coincap.io/assets/icons/shib@2x.png'),
          ],
        );
      },
    );
  }

  Widget _buildTransferOptions(String type, String logoPath) {
    return ListTile(
      title: Row(
        children: [
          Image.network(logoPath, height: 30),
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
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: smallPadding),
              GestureDetector(
                onTap: () => _showTransferTypeDropDown(context),
                child: Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (selectedTransferType != null)
                            Image.network(
                              _getImageForTransferType(selectedTransferType!),
                              height: 28,
                              width: 28,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, color: Colors.red);
                              },
                            ),
                          const SizedBox(width: 8.0),
                          Text(
                            selectedTransferType != null
                                ? '$selectedTransferType'
                                : 'Coin',
                            style: const TextStyle(color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: smallPadding),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("24h Change", style: TextStyle(color: kPurpleColor)),
                    SizedBox(height: 5),
                    Text("0.000018729.666%", style: TextStyle(color: kGreeneColor, fontSize: 16)),
                    SizedBox(height: smallPadding),
                    Divider(color: kPrimaryLightColor),
                    Text("24h High", style: TextStyle(color: kPurpleColor)),
                    SizedBox(height: 5),
                    Text("0.00001902", style: TextStyle(fontSize: 16)),
                    SizedBox(height: smallPadding),
                    Divider(color: kPrimaryLightColor),
                    Text("24h Low", style: TextStyle(color: kPurpleColor)),
                    SizedBox(height: 5),
                    Text("0.00001697", style: TextStyle(fontSize: 16)),
                    SizedBox(height: smallPadding),
                    Divider(color: kPrimaryLightColor),
                    Text("24h Volume", style: TextStyle(color: kPurpleColor)),
                    SizedBox(height: 5),
                    Text("40375.66323000", style: TextStyle(fontSize: 16)),
                    SizedBox(height: smallPadding),
                    Divider(color: kPrimaryLightColor),
                    Text("24h Volume(USDT)", style: TextStyle(color: kPurpleColor)),
                    SizedBox(height: 5),
                    Text("2831616388.79402430", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),

              const SizedBox(height: largePadding),
              Container(
                width: double.infinity,
                height: 418,
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
                    const Text("Recent Trades", style: TextStyle(color: kPrimaryColor, fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: smallPadding),
                    // Wrap ListView in a Container or SizedBox with a defined height
                    SizedBox(
                      height: 350, // Adjust this height as needed
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: recentTrades.length,
                        itemBuilder: (context, index) {
                          final trade = recentTrades[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: smallPadding),
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: kPurpleColor, width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Price (USDT):", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                                    Text("${trade['price']}", style: const TextStyle(color: kPrimaryColor)),
                                  ],
                                ),
                                const SizedBox(height: smallPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Qty (BTC):", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                                    Text("${trade['quantity']}", style: const TextStyle(color: kPrimaryColor)),
                                  ],
                                ),
                                const SizedBox(height: smallPadding),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Time:", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                                    Text("${trade['time']}", style: const TextStyle(color: kPrimaryColor)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: largePadding,),
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
                      child: Text("Spot", style: TextStyle(color: kPrimaryColor, fontSize: 17, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: smallPadding,),
                    const Divider(color: kPurpleColor,),
                    const SizedBox(height: defaultPadding,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 45,
                          child: FloatingActionButton.extended(
                            onPressed: () {

                            },
                            label: const Text(
                              'Limit',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        SizedBox(
                          width: 100,
                          height: 45,
                          child: FloatingActionButton.extended(
                            onPressed: () {

                            },
                            label: const Text(
                              'Market',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        SizedBox(
                          width: 110,
                          height: 45,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              // Add your onPressed code here!
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CardsListScreen()),
                              );*/
                            },
                            label: const Text(
                              'Stop Limit',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),

                    // Balance
                    const SizedBox(height: defaultPadding,),
                    Container(
                      width: double.infinity,
                      height: 55.0,
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
                      ),// Replace with your desired color
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("USD Balance",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),),

                          Text("428.5093297443351 USD",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),),
                        ],
                      ),
                    ),

                    // Price
                    const SizedBox(height: defaultPadding,),
                    Container(
                      width: double.infinity,
                      height: 55.0,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPurpleColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Price",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),),

                          Text("428.5093297443223351 USD",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),),
                        ],
                      ),
                    ),

                    // No of coins
                    const SizedBox(height: defaultPadding,),
                    Container(
                      width: double.infinity,
                      height: 55.0,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPurpleColor, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("No of Coins",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),),

                          Text("BTC",style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 15),),
                        ],
                      ),
                    ),

                    // Range
                    const SizedBox(height: defaultPadding,),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
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
                          const Text(
                            "Amount Range",
                            style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text("0%", style: TextStyle(fontSize: 12, color: kPrimaryColor, fontWeight: FontWeight.bold)),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: kPurpleColor,
                                    inactiveTrackColor: kPrimaryLightColor,
                                    thumbColor: kPrimaryColor,
                                    overlayColor: Colors.black.withOpacity(0.1),
                                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                                    trackHeight: 4.0,
                                  ),
                                  child: Slider(
                                    value: sliderValue,
                                    min: 0,
                                    max: 100,
                                    divisions: 100,
                                    onChanged: (value) {
                                      setState(() {
                                        sliderValue = value; // Update slider value dynamically
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text("100%", style: TextStyle(fontSize: 12, color: kPrimaryColor, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Center(
                            child:  Text("${sliderValue.toInt()}%", style: const TextStyle(fontSize: 12, color: kPrimaryColor, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),

                    // Total Balance
                    const SizedBox(height: defaultPadding,),
                    Container(
                      width: double.infinity,
                      height: 55.0,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),// Replace with your desired color
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),

                          Text("214.5093297443351 USD",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                        ],
                      ),
                    ),

                    //Buy And Sell Button
                    const SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        const SizedBox(width: largePadding,),

                        SizedBox(
                          width: 130,
                          height: 45,
                          child: FloatingActionButton.extended(
                            onPressed: () {

                            },
                            label: const Text(
                              'Buy',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            backgroundColor: kGreeneColor,
                          ),
                        ),

                        const SizedBox(width: defaultPadding),
                        SizedBox(
                          width: 130,
                          height: 45,
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              // Add your onPressed code here!
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CardsListScreen()),
                              );*/
                            },
                            label: const Text(
                              'Sell',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            backgroundColor: kRedColor,
                          ),
                        ),

                        const SizedBox(width: largePadding,),

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  String _getImageForTransferType(String transferType) {
    switch (transferType) {
      case "BTCUSDT":
        return 'https://assets.coincap.io/assets/icons/btc@2x.png';
      case "BNBUSDT":
        return 'https://assets.coincap.io/assets/icons/bnb@2x.png';
      case "ADAUSDT":
        return 'https://assets.coincap.io/assets/icons/ada@2x.png';
      case "SOLUSDT":
        return 'https://assets.coincap.io/assets/icons/sol@2x.png';
      case "DOGEUSDT":
        return 'https://assets.coincap.io/assets/icons/doge@2x.png';
      case "LTCUSDT":
        return 'https://assets.coincap.io/assets/icons/ltc@2x.png';
      case "ETHUSDT":
        return 'https://assets.coincap.io/assets/icons/eth@2x.png';
      case "SHIBUSDT":
        return 'https://assets.coincap.io/assets/icons/shib@2x.png';
      default:
        return 'assets/icons/default.png'; // Default image if needed
    }
  }
}
