import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebsocketDemo extends StatefulWidget {
  const WebsocketDemo({Key? key}) : super(key: key);

  @override
  State<WebsocketDemo> createState() => _WebsocketDemoState();
}

class _WebsocketDemoState extends State<WebsocketDemo> {
  String btcUsdtPrice = "0";
  String selectedCoin = 'btcusdt'; // Default selected coin
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    initializeChannel();
  }

  // Initialize the WebSocket channel with the selected coin
  void initializeChannel() {
    // Close the previous channel if it exists
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/$selectedCoin@trade');
    streamListener();
  }

  // Listen to the incoming WebSocket stream and update the price
  void streamListener() {
    channel.stream.listen((message) {
      Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
      });
    });
  }

  // Change the coin and restart the WebSocket connection
  void changeCoin(String coin) {
    setState(() {
      selectedCoin = coin;
      // Close the existing channel and open a new one
      channel.sink.close();
      initializeChannel();
    });
  }

  @override
  void dispose() {
    // Close the channel when the widget is disposed
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select a Coin",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            // Dropdown menu for selecting the coin
            DropdownButton<String>(
              value: selectedCoin,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  changeCoin(newValue);
                }
              },
              items: <String>['btcusdt', 'ethusdt', 'bnbusdt', 'adausdt']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Price of $selectedCoin",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                btcUsdtPrice,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 194, 25),
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
