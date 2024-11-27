import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CardsScreen/card_screen.dart';
import 'package:quickcash/Screens/CryptoScreen/BuyAndSell/BuyAndSellScreen/buy_and_sell_home_screen.dart';
import 'package:quickcash/Screens/CryptoScreen/WalletAddress/walletAddress_screen.dart';
import 'package:quickcash/Screens/DashboardScreen/Dashboard/dashboard_screen.dart';
import 'package:quickcash/Screens/HomeScreen/my_drawer_header.dart';
import 'package:quickcash/Screens/InvoicesScreen/CategoriesScreen/categories_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/ClientsScreen/ClientsScreen/clients_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/invoice_dashboard_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceTransactions/invoice_transactions_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoicesScreen/Invoices/invoices_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/ManualInvoicePayment/manualInvoiceScreen/manual_invoice_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/ProductsScreen/ProductScreen/products_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/QuotesScreen/quoteScreen/quotes_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/Settings/settingsMainScreen.dart';
import 'package:quickcash/Screens/LoginScreen/login_screen.dart';
import 'package:quickcash/Screens/ReferAndEarnScreen/refer_and_earn_screen.dart';
import 'package:quickcash/Screens/SpotTradeScreen/spot_trade_screen.dart';
import 'package:quickcash/Screens/StatemetScreen/StatementScreen/statement_screen.dart';
import 'package:quickcash/Screens/TicketsScreen/TicketScreen/tickets_screen.dart';
import 'package:quickcash/Screens/TransactionScreen/TransactionScreen/transaction_screen.dart';
import 'package:quickcash/Screens/UserProfileScreen/profile_main_screen.dart';
import 'package:quickcash/constants.dart';

import '../../util/auth_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentPage = DrawerSections.dashboard;
  bool isCryptoExpanded = false; // Track submenu state for Crypto
  bool isInvoicesExpanded = false; // Track submenu state for Invoices

  @override
  Widget build(BuildContext context) {
    Widget container;

    switch (currentPage) {
      case DrawerSections.dashboard:
        container = const DashboardScreen();
        break;
      case DrawerSections.cards:
        container = const CardsScreen();
        break;
      case DrawerSections.transaction:
        container = const TransactionScreen();
        break;
      case DrawerSections.statement:
        container = const StatementScreen();
        break;
      case DrawerSections.buySell:
        container = const BuyAndSellScreen();
        break;
      case DrawerSections.walletAddress:
        container = const WalletAddressScreen();
        break;
      case DrawerSections.userProfile:
        container = const ProfileMainScreen();
        break;
      case DrawerSections.spotTrade:
        container = const SpotTradeScreen();
        break;
      case DrawerSections.tickets:
        container = const TicketsScreen();
        break;
      case DrawerSections.referAndEarn:
        container = const ReferAndEarnScreen();
        break;
      case DrawerSections.invoiceDashboard:
        container = const InvoiceDashboardScreen();
        break;
      case DrawerSections.clients:
        container = const ClientsScreen();
        break;
      case DrawerSections.categories:
        container = const CategoriesScreen();
        break;
      case DrawerSections.products:
        container = const ProductsScreen();
        break;
      case DrawerSections.quotes:
        container = const QuotesScreen();
        break;
     /* case DrawerSections.invoiceTemplates:
        container = const InvoiceTemplatesScreen();
        break;*/
      case DrawerSections.invoicesSub:
        container = const InvoicesScreen();
        break;
      case DrawerSections.manualInvoicePayment:
        container = const ManualInvoiceScreen();
        break;
      case DrawerSections.invoiceTransactions:
        container = const InvoiceTransactionsScreen();
        break;
      case DrawerSections.settings:
        container = const SettingsMainScreen();
        break;
      default:
        container = const DashboardScreen(); // Fallback
    }

    return WillPopScope(
      onWillPop: () async {
        if (currentPage != DrawerSections.dashboard) {
          setState(() {
            currentPage = DrawerSections.dashboard; // Go back to Dashboard
          });
          return false; // Prevent default back action
        } else {
          return await _showExitDialog(); // Show exit dialog if on Dashboard
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            container, // Your main content

            // Positioned widgets for menu and logout icons
            Positioned(
              top: 40, // Adjust this value as needed
              left: 10, // Adjust this value as needed
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    // Open the drawer using the Builder's context
                    Scaffold.of(context).openDrawer();
                  },
                  color: kPrimaryColor, // Customize the color if needed
                  iconSize: 30, // Customize the size if needed
                ),
              ),
            ),

            Positioned(
              top: 40, // Align the logout button at the same height as the menu icon
              right: 10, // Adjust this value to move it to the right side
              child: IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // Handle logout functionality here
                  mLogoutDialog();
                  // print("Logout button pressed");
                },
                color: kPrimaryColor, // Customize the color if needed
                iconSize: 30, // Customize the size if needed
              ),
            ),

            // Centered text between the icons
            const Positioned(
              top: 50, // Align with the icons vertically
              left: 50, // Start positioning the text from the left side
              right: 50, // Give some space on the right side for text
              child: Center(
                child: Text(
                  'Dashboard', // Replace with your desired text
                  style: TextStyle(
                    fontSize: 20, // Customize text size
                    fontWeight: FontWeight.bold, // Customize text weight
                    color: kPrimaryColor, // Customize text color
                  ),
                  textAlign: TextAlign.center, // Center the text horizontally
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const MyHeaderDrawer(),
                mMyDrawerList(),
              ],
            ),
          ),
        ),
      ),


    );
  }

  Future<bool> _showExitDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Exit"),
        content: const Text("Do you really want to exit?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Yes
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ??
        false;
  }

  Future<bool> mLogoutDialog() async {
    return (await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Do you really want to Logout?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No, return false
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              // Log the user out
              AuthManager.logout();  // Make sure to call logout function here
              // Pop the dialog and return true (indicating a successful logout)
              Navigator.of(context).pop(true);
              // Navigate to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // replace HomeScreen with your actual home screen
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ?? false; // In case of dialog dismiss, return false
  }


  Widget mMyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(
            1,
            "Dashboard",
            Image.asset("assets/icons/menu_dashboard.png", width: 24, height: 24),
            currentPage == DrawerSections.dashboard,
          ),
          menuItem(
            2,
            "Cards",
            Image.asset("assets/icons/menu_card.png", width: 24, height: 24),
            currentPage == DrawerSections.cards,
          ),
          menuItem(
            3,
            "Transaction",
            Image.asset("assets/icons/menu_transaction.png", width: 24, height: 24),
            currentPage == DrawerSections.transaction,
          ),
          menuItem(
            4,
            "Statement",
            Image.asset("assets/icons/menu_statement.png", width: 24, height: 24),
            currentPage == DrawerSections.statement,
          ),
          menuItem(
            5,
            "Crypto",
            Image.asset("assets/icons/menu_crypto.png", width: 24, height: 24),
            currentPage == DrawerSections.crypto,
            isDropdown: true,
            isExpanded: isCryptoExpanded,
            onTap: () {
              setState(() {
                isCryptoExpanded = !isCryptoExpanded; // Toggle the submenu
                if (isCryptoExpanded) {
                  isInvoicesExpanded = false; // Collapse Invoices if Crypto is expanded
                }
              });
            },
          ),
          if (isCryptoExpanded) ...[

            submenuItem(
              " - Buy / Sell",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.buySell;
                });
              },
            ),

            submenuItem(
              " - Wallet Address",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.walletAddress;
                });
              },
            ),
          ],
          menuItem(
            6,
            "User Profile",
            Image.asset("assets/icons/menu_userprofile.png", width: 24, height: 24),
            currentPage == DrawerSections.userProfile,
          ),
          menuItem(
            7,
            "Spot Trade",
            Image.asset("assets/icons/menu_spot_trade.png", width: 24, height: 24),
            currentPage == DrawerSections.spotTrade,
          ),
          menuItem(
            8,
            "Tickets",
            Image.asset("assets/icons/menu_support.png", width: 24, height: 24),
            currentPage == DrawerSections.tickets,
          ),
          menuItem(
            9,
            "Refer & Earn",
            Image.asset("assets/icons/menu_refer_reward.png", width: 24, height: 24),
            currentPage == DrawerSections.referAndEarn,
          ),
          menuItem(
            10,
            "Invoices",
            Image.asset("assets/icons/menu_invoice.png", width: 24, height: 24),
            currentPage == DrawerSections.invoices,
            isDropdown: true,
            isExpanded: isInvoicesExpanded,
            onTap: () {
              setState(() {
                isInvoicesExpanded = !isInvoicesExpanded; // Toggle the submenu
                if (isInvoicesExpanded) {
                  isCryptoExpanded = false; // Collapse Crypto if Invoices is expanded
                }
              });
            },
          ),
          if (isInvoicesExpanded) ...[
            submenuItem(
              " - Invoice Dashboard",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.invoiceDashboard;
                });
              },
            ),
            submenuItem(
              " - Clients",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.clients;
                });
              },
            ),
            submenuItem(
              " - Categories",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.categories;
                });
              },
            ),
            submenuItem(
              " - Products",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.products;
                });
              },
            ),
            submenuItem(
              " - Quotes",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.quotes;
                });
              },
            ),
            /*submenuItem(
              " - Templates",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.invoiceTemplates;
                });
              },
            ),*/
            submenuItem(
              " - Invoices",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.invoicesSub;
                });
              },
            ),
            submenuItem(
              " - Manual Invoice Payment",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.manualInvoicePayment;
                });
              },
            ),
            submenuItem(
              " - Invoice Transactions",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.invoiceTransactions;
                });
              },
            ),
            submenuItem(
              " - Settings",
                  () {
                Navigator.pop(context);
                setState(() {
                  currentPage = DrawerSections.settings;
                });
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, Widget icon, bool selected, {bool isDropdown = false, bool isExpanded = false, Function()? onTap}) {
    return Material(
      color: selected ? kPrimaryLightColor : Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            setState(() {
              currentPage = DrawerSections.values[id - 1];
              Navigator.pop(context); // Close the drawer
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 20),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kPrimaryColor)),
              const Spacer(),
              if (isDropdown)
                Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget submenuItem(String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Aligns to the left
          children: [
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kPrimaryColor)),
          ],
        ),
      ),
    );
  }

}

enum DrawerSections {
  dashboard,
  cards,
  transaction,
  statement,
  crypto,
  userProfile,
  spotTrade,
  tickets,
  referAndEarn,
  invoices,
  walletAddress,
  buySell,
  invoiceDashboard,
  clients,
  categories,
  products,
  quotes,
  /*invoiceTemplates,*/
  invoicesSub,
  manualInvoicePayment,
  invoiceTransactions,
  settings,
}
