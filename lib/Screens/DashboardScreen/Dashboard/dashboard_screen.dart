import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/buy_and_sell_home_screen.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/model/buyAndSellListApi.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/model/buyAndSellListModel.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/cryptoBuyModel/walletAddressModel/walletAddressModel.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/CryptoBuyAndSellScreen/crypto_sell_exchange_screen.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressApi.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressModel.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/walletAddress_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/KycStatusWidgets/KycStatusWidgets.dart';
import 'package:quickcash/util/ShimmerLoader.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/AddMoneyScreen/add_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/AllAccountsScreen/allAccountsScreen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountListTransactionApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListModel.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionList/transactionListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/exchangeMoneyScreen/exchange_money_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/SendMoneyScreen/send_money_screen.dart';
import 'package:quickcash/Screens/KYCScreen/KYCStatusModel/kycStatusApi.dart';
import 'package:quickcash/Screens/TransactionScreen/TransactionDetailsScreen/transaction_details_screen.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/util/auth_manager.dart';
import 'package:quickcash/util/customSnackBar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../KYCScreen/kycHomeScreen.dart';
import '../../LoginScreen/login_screen.dart';
import 'RevenueList/revenueListApi.dart';
import 'TransactionList/transactionListModel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final WalletAddressApi _walletAddressApi = WalletAddressApi();
  List<WalletAddressListsData> walletAddressList = [];
  final TransactionListApi _transactionListApi = TransactionListApi();
  final AccountsListApi _accountsListApi = AccountsListApi();
  final CryptoListApi _cryptoListApi = CryptoListApi();

  // bool _isPageManuallyChanged = false; // Track if the page change was manual

  int _selectedFiatIndex = -1; // Initialize to -1 (no selection)
  int _selectedCryptoIndex = -1;

  int _currentFiatPage = 0; // Track the current FIAT page
  int _currentCryptoPage = 0; // Track the current Crypto page

  final AccountListTransactionApi _accountListTransactionApi =
      AccountListTransactionApi();
  final RevenueListApi _revenueListApi = RevenueListApi();
  final KycStatusApi _kycStatusApi = KycStatusApi();
  String? _selectedCardType = "";

  List<AccountsListsData> accountsListData = [];
  List<CryptoListsData> cryptoListData = [];
  List<TransactionListDetails> transactionList = [];
  //bool _isCardSelected = false;
  CryptoListsData? selectedCryptoData;

  //int _cryptoIndex = 0;

  bool isLoading = false;
  bool isTransactionLoading = false;
  String? errorTransactionMessage;
  String? errorMessage;
  //int? _selectedIndex;
  double? creditAmount;
  double? debitAmount;
  double? investingAmount;
  double? earningAmount;

  // Exchange ---
  String? accountIdExchange;
  String? accountName;

  String? countryExchange;
  String? currencyExchange;
  String? ibanExchange;
  bool? statusExchange;
  double? amountExchange;

  String? mKycDocumentStatus;

  //int _currentIndex = 0;

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

  @override
  void initState() {
    super.initState();
    if (AuthManager.getKycStatus() == "completed") {
      isLoading = true;
      mAccounts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
      CryptoAccounts();
      mRevenueList();
      mTransactionList();
      mKycStatus();
      fetchWalletAddresses();
    }
    mKycStatus();
  }

  void _showWalletAddressBottomSheet(
      BuildContext context, String walletAddress, String coinName) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return WalletAddressBottomSheet(
          mWalletAddress: walletAddress,
          coinName: coinName,
          onWalletAddressAdded: fetchWalletAddresses,
        );
      },
    );
  }

  Future<void> fetchWalletAddresses() async {
    try {
      final response = await _walletAddressApi.walletAddressApi();
      if (response.walletAddressList != null &&
          response.walletAddressList!.isNotEmpty) {
        setState(() {
          walletAddressList = response.walletAddressList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "No Wallet Addresses Found";
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  Future<void> mKycStatus() async {
    setState(() {});
    try {
      final response = await _kycStatusApi.kycStatusApi();

      if (response.message == "kyc data are fetched Successfully") {
        setState(() {
          AuthManager.saveKycStatus(
              response.kycStatusDetails!.first.kycStatus!);
          AuthManager.saveKycId(response.kycStatusDetails!.first.kycId!);
          AuthManager.saveKycDocFront(
              response.kycStatusDetails!.first.documentPhotoFront!);
          mKycDocumentStatus =
              response.kycStatusDetails!.first.documentPhotoFront;

          if (AuthManager.getKycStatus() == "completed") {
            mAccounts();
            CryptoAccounts();
            mRevenueList();
            mTransactionList();
          }
        });
      } else {
        setState(() {
          CustomSnackBar.showSnackBar(
              context: context,
              message: "We are facing some issue, Please try after some time!",
              color: kPrimaryColor);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  /// Function to refresh the screen data.
  Future<void> _refreshData() async {
    // setState(() {
    //   isLoading = true;
    // });
    // Place your refresh logic here.
    // For example: fetching new data from an API, reloading state, etc.
    await Future.delayed(const Duration(seconds: 2)); // simulate a network call
    // After your data is refreshed, update the state
    // setState(() {
    //   isLoading = false;
    // });
  }

  // CryptoAccounts List Api ---------------
  Future<void> CryptoAccounts() async {
    setState(() {
      //isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _cryptoListApi.cryptoListApi();

      if (response.cryptoList != null && response.cryptoList!.isNotEmpty) {
        setState(() {
          cryptoListData = response.cryptoList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Data';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();

        mTokenExpireDialog();
      });
    }
  }

  // Accounts List Api ---------------
  Future<void> mAccounts() async {
    setState(() {
      //isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _accountsListApi.accountsListApi();

      if (response.accountsList != null && response.accountsList!.isNotEmpty) {
        setState(() {
          accountsListData = response.accountsList!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Account Found';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();

        mTokenExpireDialog();
      });
    }
  }

  // Account List Transaction Api ------
  Future<void> mAccountListTransaction(accountId, currency) async {
    setState(() {
      //isTransactionLoading = true;
      errorTransactionMessage = null;
    });

    try {
      final response = await _accountListTransactionApi.accountListTransaction(
          accountId, currency, AuthManager.getUserId());
      if (response.transactionList != null &&
          response.transactionList!.isNotEmpty) {
        setState(() {
          transactionList = response.transactionList!;
          isTransactionLoading = false;
        });
      } else {
        setState(() {
          isTransactionLoading = false;
          errorTransactionMessage = 'No Transaction List';
        });
      }
    } catch (error) {
      setState(() {
        isTransactionLoading = false;
        errorTransactionMessage = error.toString();
      });
    }
  }

  // Revenue List Api ------------
  Future<void> mRevenueList() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    try {
      final response = await _revenueListApi.revenueListApi();
      creditAmount = response.creditAmount ?? 0.0;
      debitAmount = response.debitAmount ?? 0.0;
      investingAmount = response.investingAmount ?? 0.0;
      earningAmount = response.earningAmount ?? 0.0;
    } catch (error) {
      setState(() {
        isLoading = false;
        errorTransactionMessage = error.toString();
      });
    }
  }

  // Transaction List Api   ------
  Future<void> mTransactionList() async {
    setState(() {
      // isTransactionLoading = true;
      errorTransactionMessage = null;
    });

    try {
      final response = await _transactionListApi.transactionListApi();

      if (response.transactionList != null &&
          response.transactionList!.isNotEmpty) {
        setState(() {
          transactionList = response.transactionList!;
          isTransactionLoading = false;
        });
      } else {
        setState(() {
          isTransactionLoading = false;
          errorTransactionMessage = 'No Transaction List';
        });
      }
    } catch (error) {
      setState(() {
        isTransactionLoading = false;
        errorTransactionMessage = error.toString();
      });
    }
  }

// Function to format the date
  String formatDate(String? dateTime) {
    if (dateTime == null) {
      return 'Date not available'; // Fallback text if dateTime is null
    }
    DateTime date = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String getCurrencySymbol(String currencyCode) {
    var format = NumberFormat.simpleCurrency(name: currencyCode);
    return format.currencySymbol;
  }

  Future<bool> mTokenExpireDialog() async {
    return (await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          barrierColor: kPrimaryColor,
          builder: (context) => AlertDialog(
            title: const Text("Login Again"),
            content: const Text("Token has been expired, Please Login Again!"),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  // Log the user out
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
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Background(
        child: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(), // Show loading indicator
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25.0,
                    ),

                    if (isLoading)
                      const Center(child: CircularProgressIndicator()),

                    //Check Kyc STATUS
                    CheckKycStatus(),
                    //KYC STAUS CHECK ENDS HERE

                    const SizedBox(
                      height: 60,
                    ),

                    if (AuthManager.getKycStatus() == "completed")
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25),
                              GaugeContainer(
                                child: GaugeWidget(
                                  label: 'Credit',
                                  currentAmount: creditAmount ?? 0.0,
                                  totalAmount: creditAmount ?? 0.0,
                                  color: Colors.green,
                                  icon: Icons.arrow_downward_rounded,
                                ),
                              ),
                              const SizedBox(width: 16),
                              GaugeContainer(
                                child: GaugeWidget(
                                  label: 'Debit',
                                  currentAmount: debitAmount ?? 0.0,
                                  totalAmount: creditAmount ?? 0.0,
                                  color: Colors.red,
                                  icon: Icons.arrow_upward_rounded,
                                ),
                              ),
                              const SizedBox(width: 16),
                              GaugeContainer(
                                child: GaugeWidget(
                                  label: 'Investing',
                                  currentAmount: investingAmount ?? 0.0,
                                  totalAmount: creditAmount ?? 0.0,
                                  color: Colors.purple,
                                  icon: Icons.attach_money,
                                ),
                              ),
                              const SizedBox(width: 16),
                              GaugeContainer(
                                child: GaugeWidget(
                                  label: 'Earning',
                                  currentAmount: earningAmount ?? 0.0,
                                  totalAmount: creditAmount ?? 0.0,
                                  color: Colors.lightGreen,
                                  icon: Icons.attach_money,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(
                      height: smallPadding,
                    ),

                    // Loading and Error Handling
                    if (AuthManager.getKycStatus() == "completed")
                      Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        child: Column(
                          children: [
                            // Title
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    'FIAT',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Check if KYC is not pending
                            if (AuthManager.getKycStatus() == "completed")
                              isLoading
                                  ? const Center(
                                      child: LinearProgressIndicator(
                                      color: kPrimaryColor,
                                    ))
                                  : Column(
                                      children: [
                                        CarouselSlider.builder(
                                          itemCount: accountsListData.length +
                                              1, // Add 1 for the default card
                                          options: CarouselOptions(
                                            height: 168,
                                            autoPlay: false,
                                            enlargeCenterPage: false,
                                            viewportFraction:
                                                1, // Adjusted to ensure proper spacing
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _currentFiatPage =
                                                    index; // Update page indicator
                                              });
                                            },
                                          ),
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            // Check if it's the last item (default card)
                                            if (index ==
                                                accountsListData.length) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            AllAccountsScreen(),
                                                      ));
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            defaultPadding),
                                                  ),
                                                  child: Container(
                                                    width: 340,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            defaultPadding),
                                                    child: const Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .add_circle_outline,
                                                              size: 35,
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                            Text(
                                                              'Add Currency',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height:
                                                                largePadding),
                                                        Text(
                                                          'XXXXXXXX',
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }

                                            // Handle regular account cards
                                            final accountsData =
                                                accountsListData[index];
                                            final isSelected =
                                                index == _selectedFiatIndex &&
                                                    _selectedCardType == 'fiat';

                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedFiatIndex = index;
                                                  _selectedCryptoIndex = -1;
                                                  _selectedCardType = "fiat";

                                                  // Assign data
                                                  accountName =
                                                      accountsData.Accountname;
                                                  accountIdExchange =
                                                      accountsData.accountId;
                                                  countryExchange =
                                                      accountsData.country;
                                                  currencyExchange =
                                                      accountsData.currency;
                                                  ibanExchange =
                                                      accountsData.iban;
                                                  statusExchange =
                                                      accountsData.status;
                                                  amountExchange =
                                                      accountsData.amount;

                                                  // Save Data
                                                  AuthManager.saveCurrency(
                                                      accountsData.currency!);
                                                  AuthManager
                                                      .saveAccountBalance(
                                                          accountsData.amount
                                                              .toString());

                                                  // Perform Transaction
                                                  mAccountListTransaction(
                                                      accountsData.accountId,
                                                      accountsData.currency);
                                                });
                                              },
                                              child: Card(
                                                elevation: 5,
                                                color: isSelected
                                                    ? kPrimaryColor
                                                    : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          defaultPadding),
                                                ),
                                                child: Container(
                                                  width: 340,
                                                  padding: const EdgeInsets.all(
                                                      defaultPadding),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CountryFlag
                                                              .fromCountryCode(
                                                            width: 35,
                                                            height: 35,
                                                            accountsData
                                                                .country!,
                                                            shape:
                                                                const Circle(),
                                                          ),
                                                          Text(
                                                            getCurrencySymbol(
                                                                accountsData
                                                                    .currency!),
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${accountsData.currency}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${accountsData.iban}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Balance",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                getCurrencySymbol(
                                                                    accountsData
                                                                        .currency!),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: isSelected
                                                                      ? Colors
                                                                          .white
                                                                      : kPrimaryColor,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${accountsData.amount}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: isSelected
                                                                      ? Colors
                                                                          .white
                                                                      : kPrimaryColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        AnimatedSmoothIndicator(
                                          activeIndex: _currentFiatPage,
                                          count: accountsListData.length,
                                          effect: const ExpandingDotsEffect(
                                            activeDotColor: kPrimaryColor,
                                            dotHeight: 5,
                                            dotWidth: 5,
                                          ),
                                        ),
                                      ],
                                    ) // if (AuthManager.g// Show shimmer while loading
                            else if (errorMessage != null)
                              Center(
                                child: Text(
                                  errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            else if (accountsListData.isEmpty)
                              const Center(
                                child: Text(
                                  'Data Not Available',
                                  style: TextStyle(color: kRedColor),
                                ),
                              )
                          ],
                        ),
                      ),

                    const SizedBox(
                      height: smallPadding,
                    ),
                    if (AuthManager.getKycStatus() == "completed")
                      Container(
                        margin: const EdgeInsets.all(15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    'CRYPTO',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (AuthManager.getKycStatus() == "completed")
                              isLoading
                                  ? const Center(
                                      child: LinearProgressIndicator(
                                      color: kPrimaryColor,
                                    ))
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CarouselSlider.builder(
                                          itemCount: walletAddressList.isEmpty ? 0 : walletAddressList.length,
                                          options: CarouselOptions(
                                            height: 130,
                                            autoPlay: false,
                                            enlargeCenterPage: false,
                                            viewportFraction:
                                                1, // Smooth scrolling
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _currentCryptoPage =
                                                    index; // Update indicator only
                                              });
                                            },
                                          ),
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            final walletData =
                                                walletAddressList[index];
                                            final isSelected = index ==
                                                    _selectedCryptoIndex &&
                                                _selectedCardType == 'crypto';
                                            debugPrint('isSelected: $isSelected for index: $index');

                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedCryptoIndex =
                                                      index; // Select card only when tapped
                                                  _selectedFiatIndex =
                                                      -1; // Deselect FIAT
                                                  _selectedCardType = "crypto";
                                                });
                                              },
                                              child: Card(
                                                elevation: 5,
                                                color: isSelected
                                                    ? kCryptoSelectedColor
                                                    : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          defaultPadding),
                                                ),
                                                child: Container(
                                                  width: 340,
                                                  padding: const EdgeInsets.all(
                                                      defaultPadding),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ClipOval(
                                                            child:
                                                                Image.network(
                                                              _getImageForCoin(
                                                                  walletData
                                                                      .coin!
                                                                      .split(
                                                                          '_')[0]),
                                                              width: 40,
                                                              height: 40,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Text(
                                                            walletData.coin!
                                                                .split('_')[0],
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height:
                                                              defaultPadding),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Balance",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            walletData
                                                                .noOfCoins!,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: isSelected
                                                                  ? Colors.white
                                                                  : kPrimaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 15),
                                        AnimatedSmoothIndicator(
                                          activeIndex:
                                              _currentCryptoPage, // Only updates on scroll
                                          count: walletAddressList.length,
                                          effect: const ExpandingDotsEffect(
                                            activeDotColor: kPrimaryColor,
                                            dotHeight: 5,
                                            dotWidth: 5,
                                          ),
                                        ),
                                      ],
                                    )
                          ],
                        ),
                      ),

                    if (AuthManager.getKycStatus() == "completed")
                      _selectedCardType == "crypto"
                          // The Accounts design ----------------
                          ? Card(
                              margin: const EdgeInsets.all(16.0),
                              color: Colors.white,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: smallPadding),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CryptoBuyAnsSellScreen()),
                                            );
                                            // Add your onPressed code here!
                                          },
                                          label: const Text(
                                            'Buy/SELL',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                        const SizedBox(width: 35),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const WalletAddressScreen()),
                                            );
                                          },
                                          label: const Text(
                                            'WALLET ADDRESS',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Card(
                              margin: const EdgeInsets.all(16.0),
                              color: Colors.white,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: smallPadding),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            if (amountExchange == null) {
                                              CustomSnackBar.showSnackBar(
                                                  context: context,
                                                  message:
                                                      "Please Select Any one Currency From FIAT section",
                                                  color: kRedColor);

                                              return;
                                            }
                                            print(
                                                "amountExchange: $amountExchange");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddMoneyScreen(
                                                          accountName:
                                                              accountName,
                                                          accountId:
                                                              accountIdExchange,
                                                          country:
                                                              countryExchange,
                                                          currency:
                                                              currencyExchange,
                                                          iban: ibanExchange,
                                                          status:
                                                              statusExchange,
                                                          amount:
                                                              amountExchange)),
                                            );
                                            // Add your onPressed code here!
                                          },
                                          label: const Text(
                                            'Add Money',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                        const SizedBox(width: 35),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            if (amountExchange == null) {
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
                                                  builder: (context) =>
                                                      ExchangeMoneyScreen(
                                                          accountId:
                                                              accountIdExchange,
                                                          country:
                                                              countryExchange,
                                                          currency:
                                                              currencyExchange,
                                                          iban: ibanExchange,
                                                          status:
                                                              statusExchange,
                                                          amount:
                                                              amountExchange)),
                                            );
                                          },
                                          label: const Text(
                                            ' Exchange',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: const Icon(
                                            Icons.currency_exchange,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SendMoneyScreen()),
                                            );
                                            // Add your onPressed code here!
                                          },
                                          label: const Text(
                                            'Send Money',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                        const SizedBox(width: 30),
                                        FloatingActionButton.extended(
                                          onPressed: () {
                                            // Add your onPressed code here!
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AllAccountsScreen()),
                                            );
                                          },
                                          label: const Text(
                                            'All Account',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: const Icon(
                                            Icons.select_all,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: smallPadding,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                    // // if (AuthManager.getKycStatus() != "Pending")
                    // //   // Transaction List Design
                    const SizedBox(
                      height: largePadding,
                    ),
                    if (AuthManager.getKycStatus() == "completed")
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultPadding),
                        child: Text(
                          "Recent Transaction ",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(
                      height: smallPadding,
                    ),

                    if (AuthManager.getKycStatus() == "completed")
                      // Loading and Error Handling
                      if (isTransactionLoading)
                        const Center(child: CircularProgressIndicator()),
                    if (errorTransactionMessage != null)
                      SizedBox(
                          height: 190,
                          child: Padding(
                            padding: const EdgeInsets.all(largePadding),
                            child: Card(
                              color: kPrimaryColor,
                              elevation: 4,
                              child: Center(
                                  child: Text(
                                errorTransactionMessage!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                            ),
                          )),

                    if (AuthManager.getKycStatus() == "completed")
                      // Account list (only when not loading and no error)
                      if (!isTransactionLoading &&
                          errorTransactionMessage == null &&
                          transactionList.isNotEmpty)
                        Column(
                          children: transactionList.take(2).map((transaction) {
                            // Limiting to 5 items
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              color:
                                  kDefaultIconLightColor, // Custom background color
                              child: InkWell(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransactionDetailPage(
                                        transactionId: transaction
                                            .trxId, // Passing transactionId here
                                      ),
                                    ),
                                  )
                                }, // Navigate on tap
                                child: ListTile(
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: defaultPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${transaction.transactionId}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          Text(
                                              formatDate(
                                                  transaction.transactionDate),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${transaction.transactionType}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          Row(
                                            children: [
                                              Text('+', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),),
                                              Text( 
                                                getCurrencySymbol(
                                                    transaction.fromCurrency!),
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${transaction.conversionAmount}",
                                                style: const TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [

                                          Row(children: [

                                            Text(
                                                getCurrencySymbol(
                                                    transaction.fromCurrency!),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            
                                          Text(
                                              '${transaction.balance!.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16)),
                                          ],),
                                          
                                          Text(
                                            (transaction.transactionStatus
                                                        ?.isNotEmpty ??
                                                    false)
                                                ? '${transaction.transactionStatus![0].toUpperCase()}${transaction.transactionStatus!.substring(1)}'
                                                : 'Unknown',
                                            // Fallback to 'Unknown' if null or empty
                                            style: const TextStyle(
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  ],
                ),
        ),
      ),
    );
  }
}

class GaugeContainer extends StatelessWidget {
  final Widget child;

  const GaugeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class GaugeWidget extends StatelessWidget {
  final String label;
  final double currentAmount;
  final double totalAmount;
  final Color color;
  final IconData icon;

  const GaugeWidget({
    super.key,
    required this.label,
    required this.currentAmount,
    required this.totalAmount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (currentAmount / totalAmount).clamp(0.0, 1.0);

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: const Size(100, 120),
          painter: GaugePainter(percentage: percentage, color: color),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // If you want to show the icon, uncomment the following line
            const SizedBox(
              height: largePadding,
            ),
            Icon(
              icon,
              size: 20, // Icon size
              color: color,
            ),
            const SizedBox(height: 0),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              '\$${currentAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
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

    // Draw the background arc (representing the full gauge)
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      pi, // Start angle (180 degrees)
      pi, // Sweep angle (180 degrees)
      false,
      backgroundPaint,
    );

    // Draw the progress arc (representing the percentage filled)
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      pi, // Start angle
      pi * percentage, // Sweep angle based on percentage
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
