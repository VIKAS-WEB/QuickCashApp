import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/model/buyAndSellListApi.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountListTransactionApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/AccountsList/accountsListModel.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/RevenueList/revenueListApi.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/TransactionList/transactionListApi.dart';
import 'package:quickcash/Screens/KYCScreen/KYCStatusModel/kycStatusApi.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../Dashboard/TransactionList/transactionListModel.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/model/walletAddressModel.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/model/buyAndSellListModel.dart';

class DashboardProvider extends ChangeNotifier {
  final WalletAddressApi _walletAddressApi = WalletAddressApi();
  final TransactionListApi _transactionListApi = TransactionListApi();
  final AccountsListApi _accountsListApi = AccountsListApi();
  final CryptoListApi _cryptoListApi = CryptoListApi();
  final AccountListTransactionApi _accountListTransactionApi = AccountListTransactionApi();
  final RevenueListApi _revenueListApi = RevenueListApi();
  final KycStatusApi _kycStatusApi = KycStatusApi();

  List<WalletAddressListsData> walletAddressList = [];
  List<AccountsListsData> accountsListData = [];
  List<CryptoListsData> cryptoListData = [];
  List<TransactionListDetails> transactionList = [];

  int _selectedFiatIndex = -1;
  int _selectedCryptoIndex = -1;
  int _currentFiatPage = 0;
  int _currentCryptoPage = 0;
  String? _selectedCardType = "";
  CryptoListsData? selectedCryptoData;

  bool isLoading = false;
  bool isTransactionLoading = false;
  String? errorTransactionMessage;
  String? errorMessage;

  double? creditAmount;
  double? debitAmount;
  double? investingAmount;
  double? earningAmount;

  String? accountIdExchange;
  String? accountName;
  String? countryExchange;
  String? currencyExchange;
  String? ibanExchange;
  bool? statusExchange;
  double? amountExchange;
  String? mKycDocumentStatus;

  int get selectedFiatIndex => _selectedFiatIndex;
  int get selectedCryptoIndex => _selectedCryptoIndex;
  int get currentFiatPage => _currentFiatPage;
  int get currentCryptoPage => _currentCryptoPage;
  String? get selectedCardType => _selectedCardType;

  DashboardProvider() {
    initializeData();
  }

  Future<void> initializeData() async {
    // Ensure AuthManager is initialized
    await AuthManager.init();
    if (AuthManager.getKycStatus() == "completed") {
      isLoading = true;
      notifyListeners();
      await Future.wait([
        fetchAccounts(),
        fetchCryptoAccounts(),
        fetchRevenueList(),
        fetchTransactionList(),
        fetchWalletAddresses(),
      ]);
      _restoreSelectedAccount(); // Restore the last selected account or default to USD
      isLoading = false;
      notifyListeners();
    }
    await fetchKycStatus();
  }

  Future<void> fetchWalletAddresses() async {
    try {
      final response = await _walletAddressApi.walletAddressApi();
      walletAddressList = response.walletAddressList ?? [];
      errorMessage = walletAddressList.isEmpty ? "No Wallet Addresses Found" : null;
    } catch (error) {
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> fetchKycStatus() async {
    try {
      final response = await _kycStatusApi.kycStatusApi();
      if (response.message == "kyc data are fetched Successfully") {
        await AuthManager.saveKycStatus(response.kycStatusDetails!.first.kycStatus!);
        await AuthManager.saveKycId(response.kycStatusDetails!.first.kycId!);
        await AuthManager.saveKycDocFront(response.kycStatusDetails!.first.documentPhotoFront!);
        mKycDocumentStatus = response.kycStatusDetails!.first.documentPhotoFront;
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> fetchAccounts() async {
    try {
      final response = await _accountsListApi.accountsListApi();
      accountsListData = response.accountsList ?? [];
      errorMessage = accountsListData.isEmpty ? 'No Account Found' : null;
    } catch (error) {
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> fetchCryptoAccounts() async {
    try {
      final response = await _cryptoListApi.cryptoListApi();
      cryptoListData = response.cryptoList ?? [];
      errorMessage = cryptoListData.isEmpty ? 'No Data' : null;
    } catch (error) {
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> fetchTransactionList() async {
    isTransactionLoading = true;
    notifyListeners();
    try {
      final response = await _transactionListApi.transactionListApi();
      transactionList = response.transactionList ?? [];
      errorTransactionMessage = transactionList.isEmpty ? 'No Transaction List' : null;
    } catch (error) {
      errorTransactionMessage = error.toString();
    }
    isTransactionLoading = false;
    notifyListeners();
  }

  Future<void> fetchAccountListTransaction(String accountId, String currency) async {
    isTransactionLoading = true;
    notifyListeners();
    try {
      final response = await _accountListTransactionApi.accountListTransaction(accountId, currency, AuthManager.getUserId());
      transactionList = response.transactionList ?? [];
      errorTransactionMessage = transactionList.isEmpty ? 'No Transaction List' : null;
    } catch (error) {
      errorTransactionMessage = error.toString();
    }
    isTransactionLoading = false;
    notifyListeners();
  }

  Future<void> fetchRevenueList() async {
    try {
      final response = await _revenueListApi.revenueListApi();
      creditAmount = response.creditAmount ?? 0.0;
      debitAmount = response.debitAmount ?? 0.0;
      investingAmount = response.investingAmount ?? 0.0;
      earningAmount = response.earningAmount ?? 0.0;
    } catch (error) {
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  void selectFiatCard(int index, AccountsListsData data) {
    _selectedFiatIndex = index;
    _selectedCryptoIndex = -1;
    _selectedCardType = "fiat";
    accountName = data.Accountname;
    accountIdExchange = data.accountId;
    countryExchange = data.country;
    currencyExchange = data.currency;
    ibanExchange = data.iban;
    statusExchange = data.status;
    amountExchange = data.amount;
    AuthManager.saveCurrency(data.currency!);
    AuthManager.saveAccountBalance(data.amount.toString());
    AuthManager.saveSelectedAccountId(data.accountId!); // Use new method
    fetchAccountListTransaction(data.accountId!, data.currency!);
    notifyListeners();
  }

  void selectCryptoCard(int index) {
    _selectedCryptoIndex = index;
    _selectedFiatIndex = -1;
    _selectedCardType = "crypto";
    AuthManager.saveSelectedAccountId(''); // Clear fiat selection
    notifyListeners();
  }

  void updateFiatPage(int index) {
    _currentFiatPage = index;
    notifyListeners();
  }

  void updateCryptoPage(int index) {
    _currentCryptoPage = index;
    notifyListeners();
  }

  Future<void> refreshData() async {
    isLoading = true;
    notifyListeners();
    await Future.wait([
      fetchAccounts(),
      fetchCryptoAccounts(),
      fetchRevenueList(),
      fetchTransactionList(),
      fetchWalletAddresses(),
    ]);
    _restoreSelectedAccount(); // Restore selection on refresh
    isLoading = false;
    notifyListeners();
  }

  void _restoreSelectedAccount() {
    if (accountsListData.isNotEmpty) {
      final savedAccountId = AuthManager.getSelectedAccountId(); // Synchronous getter
      if (savedAccountId.isNotEmpty) {
        final accountIndex = accountsListData.indexWhere((account) => account.accountId == savedAccountId);
        if (accountIndex != -1) {
          selectFiatCard(accountIndex, accountsListData[accountIndex]);
          return;
        }
      }
      // Fallback to USD if no saved selection or account not found
      final usdIndex = accountsListData.indexWhere((account) => account.currency == "USD");
      if (usdIndex != -1) {
        selectFiatCard(usdIndex, accountsListData[usdIndex]);
      } else if (accountsListData.isNotEmpty) {
        selectFiatCard(0, accountsListData[0]); // Fallback to first account if no USD
      }
    }
  }
}