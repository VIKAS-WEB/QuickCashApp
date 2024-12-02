import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/ExchangeScreen/review_exchange_money_screen.dart';
import 'package:quickcash/constants.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/util/customSnackBar.dart';
import '../Dashboard/AccountsList/accountsListModel.dart';

class ExchangeMoneyScreen extends StatefulWidget {
  final String? accountId;
  final String? country;
  final String? currency;
  final String? iban;
  final bool? status;
  final double? amount;

  const ExchangeMoneyScreen(
      {super.key,
      this.accountId,
      this.country,
      this.currency,
      this.iban,
      this.status,
      this.amount});

  @override
  State<ExchangeMoneyScreen> createState() => _ExchangeMoneyScreen();
}

class _ExchangeMoneyScreen extends State<ExchangeMoneyScreen> {
  // Default Account ---
  String? mAccountId;
  String? mCountry;
  String? mCurrency;
  String? mIban;
  bool? mStatus;
  double? mAmount;
  String? mCurrencySymbol;

  //Selected Account -----
  String? selectedAccountId = '';
  String? selectedCountry = '';
  String? selectedCurrency = 'Select';
  String? selectedIban = '';
  bool? selectedStatus;
  double? selectedAmount = 0.0;
  String? selectedCurrencySymbol = '';

  @override
  void initState() {
    mSetDefaultAccountData();
    super.initState();
  }

  Future<void> mSetDefaultAccountData() async {
    setState(() {
      mAccountId = widget.accountId;
      mCountry = widget.country;
      mCurrency = widget.currency;
      mIban = widget.iban;
      mStatus = widget.status;
      mAmount = widget.amount;

      mCurrencySymbol = getCurrencySymbol(mCurrency!);
    });
  }

  Future<void> mSetSelectedAccountData(mSelectedAccountId,mSelectedCountry,mSelectedCurrency,mSelectedIban,mSelectedStatus,mSelectedAmount) async{
    setState(() {
      selectedAccountId = mSelectedAccountId;
      selectedCountry = mSelectedCountry;
      selectedCurrency = mSelectedCurrency;
      selectedIban = mSelectedIban;
      selectedStatus = mSelectedStatus;
      selectedAmount = mSelectedAmount;

      selectedCurrencySymbol = getCurrencySymbol(selectedCurrency!);

    });
  }


  String getCurrencySymbol(String currencyCode) {
    // Create a NumberFormat object for the specific currency
    var format = NumberFormat.simpleCurrency(name: currencyCode);

    // Extract the currency symbol
    return format.currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Exchange Money",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to PayRecipientsScreen when tapped
                            },
                            child: Card(
                              elevation: 1.0,
                              color: kPrimaryLightColor,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Row(
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      width: 35,
                                      height: 35,
                                      mCountry!,
                                      shape: const Circle(),
                                    ),
                                    const SizedBox(width: defaultPadding),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$mCurrency Account',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.navigate_next_rounded,
                                        color: kPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: kPrimaryColor),

                            decoration: InputDecoration(
                              prefixText: '$mCurrencySymbol ',
                              labelText: "Amount",
                              labelStyle: const TextStyle(color: kPrimaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            enabled: true,
                            maxLines: 2,
                            minLines: 1,
                            // Disable editing
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Fee:",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$mCurrencySymbol 0",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Balance:",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$mCurrencySymbol ${mAmount?.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Divider line
                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: kPrimaryLightColor,
                    ),
                    // Circular button
                    Material(
                      elevation: 6.0,
                      shape: const CircleBorder(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_downward,
                            size: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              mGetAllAccountBottomSheet(context, mCurrency);
                            },
                            child: Card(
                              elevation: 1.0,
                              color: kPrimaryLightColor,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Row(
                                  children: [
                                    CountryFlag.fromCountryCode(
                                      width: 35,
                                      height: 35,
                                      selectedCountry!,
                                      shape: const Circle(),
                                    ),
                                    const SizedBox(width: defaultPadding),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$selectedCurrency Account',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.navigate_next_rounded,
                                        color: kPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            cursorColor: kPrimaryColor,
                            style: const TextStyle(color: kPrimaryColor),
                            decoration: InputDecoration(
                              prefixText: '$selectedCurrencySymbol ',
                              labelText: "Amount",
                              labelStyle: const TextStyle(color: kPrimaryColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(),
                              ),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            enabled: false,
                            // Disable editing
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Balance:",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$selectedCurrencySymbol ${selectedAmount?.toStringAsFixed(3)}",
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReviewExchangeMoneyScreen()),
                    );
                  },
                  child: const Text('Review Order',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mGetAllAccountBottomSheet(BuildContext context, String? mCurrency) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Container(
              height: 600,
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
              child: AllAccountsBottomSheet(
                currency: mCurrency,
                onAccountSelected: (
                    String accountId,
                    String country,
                    String currency,
                    String iban,
                    bool status,
                    double amount,
                    ) async {
                  await mSetSelectedAccountData(
                    accountId,
                    country,
                    currency,
                    iban,
                    status,
                    amount,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

}

class AllAccountsBottomSheet extends StatefulWidget {
  final String? currency;
  final Function(String, String, String, String, bool, double) onAccountSelected; // Update with required parameters


  const AllAccountsBottomSheet({super.key, this.currency,required this.onAccountSelected});

  @override
  State<AllAccountsBottomSheet> createState() => _AllAccountsBottomSheetState();
}

class _AllAccountsBottomSheetState extends State<AllAccountsBottomSheet> {
  final AccountsListApi _accountsListApi = AccountsListApi();
  List<AccountsListsData> accountsListData = [];
  bool isLoading = false;
  String? errorMessage;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    mAccounts();
  }

  // Accounts List Api ---------------
  Future<void> mAccounts() async {
    setState(() {
      isLoading = true;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Change Account',
              style: TextStyle(
                fontSize: 20,
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
        const SizedBox(
          height: defaultPadding,
        ),
        const Text(
          "Select your preferred account for currency exchange. Easily switch between different currencies to manage your transactions.",
          style: TextStyle(color: kPrimaryColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: isLoading
                              ? const Center(
                                  child:
                                      CircularProgressIndicator(), // Show loading indicator
                                )
                              : ListView.builder(
                                  itemCount: accountsListData.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final accountsData =
                                        accountsListData[index];
                                    final isSelected = index == _selectedIndex;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: smallPadding),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;

                                            if (widget.currency != accountsData.currency) {
                                              widget.onAccountSelected(
                                                accountsData.accountId ?? '',
                                                accountsData.country ?? '',
                                                accountsData.currency ?? '',
                                                accountsData.iban ?? '',
                                                accountsData.status ?? false,
                                                accountsData.amount ?? 0.0,
                                              );
                                              Navigator.pop(context);
                                            } else {
                                              CustomSnackBar.showSnackBar(
                                                context: context,
                                                message: "Please Select Another Account",
                                                color: kPrimaryColor,
                                              );
                                            }
                                          });
                                        },

                                        child: Card(
                                          elevation: 5,
                                          color: isSelected
                                              ? kPrimaryColor
                                              : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                defaultPadding),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CountryFlag.fromCountryCode(
                                                      width: 35,
                                                      height: 35,
                                                      accountsData.country!,
                                                      shape: const Circle(),
                                                    ),
                                                    Text(
                                                      "${accountsData.currency}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: isSelected
                                                            ? Colors.white
                                                            : kPrimaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                    height: defaultPadding),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "IBAN",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                            FontWeight.bold,
                                                        color: isSelected
                                                            ? Colors.white
                                                            : kPrimaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                    height: defaultPadding),
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
                                                            FontWeight.bold,
                                                        color: isSelected
                                                            ? Colors.white
                                                            : kPrimaryColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${accountsData.amount}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  )),
      ],
    ));
  }
}
