import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/buy_and_sell_home_screen.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/crypto_sell_exchange_screen.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressModel.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/walletAddress_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/add_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/AllAccountsScreen/allAccountsScreen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListModel.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/KycStatusWidgets/KycStatusWidgets.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionList/transactionListModel.dart';
import 'package:quickcash/Screens/DashboardScreen/DashboardProvider/DashboardProvider.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/exchangeMoneyScreen/exchange_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/send_money_screen.dart';
import 'package:quickcash/Screens/KYCScreen/kycHomeScreen.dart';
import 'package:quickcash/Screens/LoginScreen/login_screen.dart';
import 'package:quickcash/Screens/TransactionScreen/TransactionDetailsScreen/transaction_details_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/auth_manager.dart';
import 'package:quickcash/util/customSnackBar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
        return 'assets/icons/default.png';
    }
  }

  String _formatDate(String? dateTime) {
    if (dateTime == null) return 'Date not available';
    DateTime date = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _getCurrencySymbol(String currencyCode) {
    return NumberFormat.simpleCurrency(name: currencyCode).currencySymbol;
  }

  Future<bool> _showTokenExpireDialog(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierColor: kPrimaryColor,
          builder: (context) => AlertDialog(
            title: const Text("Login Again"),
            content: const Text("Token has been expired, Please Login Again!"),
            actions: [
              TextButton(
                onPressed: () async {
                  AuthManager.logout();
                  Navigator.of(context).pop(true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: provider.refreshData,
          child: Background(
            child: SingleChildScrollView(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25),
                        CheckKycStatus(),
                        const SizedBox(height: 60),
                        if (AuthManager.getKycStatus() == "completed") ...[
                          _buildRevenueGauges(provider),
                          const SizedBox(height: smallPadding),
                          _buildFiatSection(context, provider),
                          const SizedBox(height: smallPadding),
                          _buildCryptoSection(context, provider),
                          _buildActionButtons(context, provider),
                          const SizedBox(height: largePadding),
                          _buildTransactionSection(context, provider),
                        ],
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRevenueGauges(DashboardProvider provider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            GaugeContainer(
              child: GaugeWidget(
                label: 'Credit',
                currentAmount: provider.creditAmount ?? 0.0,
                totalAmount: provider.creditAmount ?? 1.0,
                color: Colors.green,
                icon: Icons.arrow_downward_rounded,
              ),
            ),
            const SizedBox(width: 16),
            GaugeContainer(
              child: GaugeWidget(
                label: 'Debit',
                currentAmount: provider.debitAmount ?? 0.0,
                totalAmount: provider.creditAmount ?? 1.0,
                color: Colors.red,
                icon: Icons.arrow_upward_rounded,
              ),
            ),
            const SizedBox(width: 16),
            GaugeContainer(
              child: GaugeWidget(
                label: 'Investing',
                currentAmount: provider.investingAmount ?? 0.0,
                totalAmount: provider.creditAmount ?? 1.0,
                color: Colors.purple,
                icon: Icons.attach_money,
              ),
            ),
            const SizedBox(width: 16),
            GaugeContainer(
              child: GaugeWidget(
                label: 'Earning',
                currentAmount: provider.earningAmount ?? 0.0,
                totalAmount: provider.creditAmount ?? 1.0,
                color: Colors.lightGreen,
                icon: Icons.attach_money,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiatSection(BuildContext context, DashboardProvider provider) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const Text('FIAT',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          const SizedBox(height: 10),
          if (provider.accountsListData.isEmpty &&
              provider.errorMessage != null)
            Center(
                child: Text(provider.errorMessage!,
                    style: const TextStyle(color: Colors.red)))
          else
            Column(
              children: [
                CarouselSlider.builder(
                  itemCount: provider.accountsListData.length + 1,
                  options: CarouselOptions(
                    height: 168,
                    autoPlay: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        provider.updateFiatPage(index),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    if (index == provider.accountsListData.length) {
                      return _buildAddCurrencyCard(context);
                    }
                    final account = provider.accountsListData[index];
                    final isSelected = index == provider.selectedFiatIndex &&
                        provider.selectedCardType == "fiat";
                    return _buildFiatCard(
                        context, provider, account, index, isSelected);
                  },
                ),
                const SizedBox(height: 10),
                AnimatedSmoothIndicator(
                  activeIndex: provider.currentFiatPage,
                  count: provider.accountsListData.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: kPrimaryColor, dotHeight: 5, dotWidth: 5),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCryptoSection(BuildContext context, DashboardProvider provider) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const Text('CRYPTO',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
          const SizedBox(height: 10),
          if (provider.walletAddressList.isEmpty &&
              provider.errorMessage != null)
            Center(
                child: Text(provider.errorMessage!,
                    style: const TextStyle(color: Colors.red)))
          else if (provider.walletAddressList.isNotEmpty)
            Column(
              children: [
                CarouselSlider.builder(
                  itemCount: provider.walletAddressList.length,
                  options: CarouselOptions(
                    height: 130,
                    autoPlay: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) =>
                        provider.updateCryptoPage(index),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final wallet = provider.walletAddressList[index];
                    final isSelected = index == provider.selectedCryptoIndex &&
                        provider.selectedCardType == "crypto";
                    return _buildCryptoCard(
                        context, provider, wallet, index, isSelected);
                  },
                ),
                const SizedBox(height: 15),
                AnimatedSmoothIndicator(
                  activeIndex: provider.currentCryptoPage,
                  count: provider.walletAddressList.length,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: kPrimaryColor, dotHeight: 5, dotWidth: 5),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, DashboardProvider provider) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: provider.selectedCardType == "crypto"
            ? _buildCryptoActions(context)
            : _buildFiatActions(context, provider),
      ),
    );
  }

  Widget _buildTransactionSection(
      BuildContext context, DashboardProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text("Recent Transaction",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: smallPadding),
        if (provider.isTransactionLoading)
          const Center(child: CircularProgressIndicator())
        else if (provider.errorTransactionMessage != null)
          SizedBox(
            height: 190,
            child: Card(
              color: kPrimaryColor,
              elevation: 4,
              child: Center(
                  child: Text(provider.errorTransactionMessage!,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16))),
            ),
          )
        else if (provider.transactionList.isNotEmpty)
          Column(
            children: provider.transactionList
                .take(4)
                .map((transaction) => _buildTransactionCard(
                    context, transaction, provider)) // Pass context here
                .toList(),
          ),
      ],
    );
  }

  Widget _buildAddCurrencyCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          CupertinoPageRoute(builder: (context) => AllAccountsScreen())),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultPadding)),
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(defaultPadding),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle_outline,
                      size: 35, color: kPrimaryColor),
                  Text('Add Currency',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor)),
                ],
              ),
              SizedBox(height: largePadding),
              Text('XXXXXXXX',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFiatCard(BuildContext context, DashboardProvider provider,
      AccountsListsData account, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => provider.selectFiatCard(index, account),
      child: Card(
        elevation: 5,
        color: isSelected ? kPrimaryColor : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultPadding)),
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CountryFlag.fromCountryCode(
                      width: 35,
                      height: 35,
                      account.country!,
                      shape: const Circle()),
                  Text(_getCurrencySymbol(account.currency!),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${account.currency}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                  Text("${account.iban}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Balance",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                  Row(
                    children: [
                      Text(_getCurrencySymbol(account.currency!),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected ? Colors.white : kPrimaryColor)),
                      Text("${account.amount}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected ? Colors.white : kPrimaryColor)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCryptoCard(BuildContext context, DashboardProvider provider,
      WalletAddressListsData wallet, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => provider.selectCryptoCard(index),
      child: Card(
        elevation: 5,
        color: isSelected ? kCryptoSelectedColor : Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultPadding)),
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipOval(
                      child: Image.network(
                          _getImageForCoin(wallet.coin!.split('_')[0]),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover)),
                  Text(wallet.coin!.split('_')[0],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Balance",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                  Text(wallet.noOfCoins!,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : kPrimaryColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCryptoActions(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: smallPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CryptoBuyAnsSellScreen())),
              label:
                  const Text('Buy/SELL', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.send, color: Colors.white),
              backgroundColor: kPrimaryColor,
            ),
            const SizedBox(width: 35),
            FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WalletAddressScreen())),
              label: const Text('WALLET ADDRESS',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.send, color: Colors.white),
              backgroundColor: kPrimaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFiatActions(BuildContext context, DashboardProvider provider) {
    return Column(
      children: [
        const SizedBox(height: smallPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                if (provider.amountExchange == null) {
                  CustomSnackBar.showSnackBar(
                      context: context,
                      message:
                          "Please Select Any one Currency From FIAT section",
                      color: kRedColor);
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMoneyScreen(
                      accountName: provider.accountName,
                      accountId: provider.accountIdExchange,
                      country: provider.countryExchange,
                      currency: provider.currencyExchange,
                      iban: provider.ibanExchange,
                      status: provider.statusExchange,
                      amount: provider.amountExchange,
                    ),
                  ),
                );
              },
              label: const Text('Add Money',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.add, color: Colors.white),
              backgroundColor: kPrimaryColor,
            ),
            const SizedBox(width: 35),
            FloatingActionButton.extended(
              onPressed: () {
                if (provider.amountExchange == null) {
                  CustomSnackBar.showSnackBar(
                      context: context,
                      message:
                          "Exchange Money Can't Work Right Now Because Fiat Data Is Null",
                      color: kRedColor);
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExchangeMoneyScreen(
                      accountId: provider.accountIdExchange,
                      country: provider.countryExchange,
                      currency: provider.currencyExchange,
                      iban: provider.ibanExchange,
                      status: provider.statusExchange,
                      amount: provider.amountExchange,
                    ),
                  ),
                );
              },
              label:
                  const Text('Exchange', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.currency_exchange, color: Colors.white),
              backgroundColor: kPrimaryColor,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SendMoneyScreen())),
              label: const Text('Send Money',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.send, color: Colors.white),
              backgroundColor: kPrimaryColor,
            ),
            const SizedBox(width: 30),
            FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllAccountsScreen())),
              label: const Text('All Account',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.select_all, color: Colors.white),
              backgroundColor: kPrimaryColor,
            ),
          ],
        ),
        const SizedBox(height: smallPadding),
      ],
    );
  }

  Widget _buildTransactionCard(BuildContext context,
      TransactionListDetails transaction, DashboardProvider provider) {
    // Added context parameter
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: kDefaultIconLightColor,
      child: InkWell(
        onTap: () => Navigator.push(
          context, // Use the passed context
          MaterialPageRoute(
              builder: (context) => TransactionDetailPage(
                  transactionId: transaction.trxId ?? '')),
        ),
        child: ListTile(
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${transaction.transactionId}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                  Text(_formatDate(transaction.transactionDate),
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${transaction.transactionType}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                  Row(
                    children: [
                      const Text('+',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                      Text(_getCurrencySymbol(transaction.fromCurrency!),
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      Text("${transaction.conversionAmount}",
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(_getCurrencySymbol(transaction.fromCurrency!),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      Text('${transaction.balance!.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16)),
                    ],
                  ),
                  Text(
                    (transaction.transactionStatus?.isNotEmpty ?? false)
                        ? '${transaction.transactionStatus![0].toUpperCase()}${transaction.transactionStatus!.substring(1)}'
                        : 'Unknown',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4))
      ],
      border: Border.all(color: Colors.grey.shade300, width: 1),
    );
  }
}

// Reused Gauge Widgets remain unchanged
class GaugeContainer extends StatelessWidget {
  final Widget child;
  const GaugeContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
        width: 210,
        height: 112,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4))
          ],
        ),
        child: child,
      );
}

class GaugeWidget extends StatelessWidget {
  final String label;
  final double currentAmount;
  final double totalAmount;
  final Color color;
  final IconData icon;

  const GaugeWidget(
      {super.key,
      required this.label,
      required this.currentAmount,
      required this.totalAmount,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final double percentage = (currentAmount / totalAmount).clamp(0.0, 1.0);
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
            size: const Size(100, 120),
            painter: GaugePainter(percentage: percentage, color: color)),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: largePadding),
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 0),
            Text(label,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: color)),
            Text('\$${currentAmount.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  final double percentage;
  final Color color;

  GaugePainter({required this.percentage, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40.0;
    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40.0;

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        pi,
        pi,
        false,
        backgroundPaint);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        pi,
        pi * percentage,
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
