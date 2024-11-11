import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/DashboardScreen/AllAccountsScreen/AccountDetailsScreen/accountDetailsScreen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListApi.dart';
import 'package:quickcash/constants.dart';

import '../Dashboard/AccountsList/accountsListModel.dart';

class AllAccountsScreen extends StatefulWidget {
  const AllAccountsScreen({super.key});

  @override
  State<AllAccountsScreen> createState() => _AllAccountsScreenState();
}

class _AllAccountsScreenState extends State<AllAccountsScreen>{

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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("All Accounts",
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(), // Show loading indicator
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,

              child: ListView.builder(
                itemCount: accountsListData.length,
                itemBuilder: (context, index) {
                  final accountsData = accountsListData[index];
                  final isSelected = index == _selectedIndex;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: smallPadding), // Adjust vertical padding for better spacing
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountDetailsScreen(
                                accountId: accountsData.accountId,
                              ),
                            ),
                          );
                        });
                      },
                      child: Card(
                        elevation: 5,
                        color: isSelected ? kPrimaryColor : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultPadding),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [



                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                  // Spacer or ElevatedButton to push the button to the right
                                  if (accountsData.currency == "USD")
                                    SizedBox(
                                      width: 100,  // Set the width of the button
                                      height: 30,  // Set the height of the button
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Your button action here
                                        },
                                        child: const Text(
                                          'Default',
                                          style: TextStyle(fontSize: 12, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(height: defaultPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "IBAN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${accountsData.iban}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: defaultPadding),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Balance",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${accountsData.amount}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : kPrimaryColor,
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
            )
          ],
        ),
      ),
    );
  }
}