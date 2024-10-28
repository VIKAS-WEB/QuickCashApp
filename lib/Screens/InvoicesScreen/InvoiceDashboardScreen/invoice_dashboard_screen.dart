import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/AddInvoice/add_invoice_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/AddQuoteScreen/add_quote_screen.dart';
import 'package:quickcash/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvoiceDashboardScreen extends StatefulWidget {
  const InvoiceDashboardScreen({super.key});

  @override
  State<InvoiceDashboardScreen> createState() => _InvoiceDashboardScreenState();
}

class _InvoiceDashboardScreenState extends State<InvoiceDashboardScreen> {
  bool light = true;

  final List<ChartData> paymentOverview = <ChartData>[
    ChartData(x: 'Paid', y: 70),
    ChartData(x: 'Unpaid', y: 27),
  ];

  final List<ChartData> invoiceOverview = <ChartData>[
    ChartData(x: 'Paid', y: 70),
    ChartData(x: 'Unpaid', y: 27),
    ChartData(x: 'Overdue', y: 27),
  ];

  final List<Map<String, String>> invoicePaymentList = [
    {
      'invoiceNumber': 'ITIOXX9X9O18958',
      'paymentDate': '10-10-2024',
      'total': '\$3.5735152490829463',
      'paidAmount': '\$3.5735152490829463',
      'transactionType': 'Manual',
    },
    {
      'invoiceNumber': 'ITIOXX9X9O18955558',
      'paymentDate': '11-10-2024',
      'total': '\$3.573515249044829463',
      'paidAmount': '\$3.57351524904829463',
      'transactionType': 'Manual',
    },
    {
      'invoiceNumber': 'ITIOXX9X9O1895558',
      'paymentDate': '09-10-2024',
      'total': '\$3.573515249074829463',
      'paidAmount': '\$3.573515265490829463',
      'transactionType': 'Manual',
    },
  ];

  String? selectedDays;

  void _showCurrencyDropdown(BuildContext context, bool isSend) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            _buildDaysOption('Today', isSend),
            _buildDaysOption('This Week',isSend),
            _buildDaysOption('Last Week',isSend),
            _buildDaysOption('This Month',isSend),
            _buildDaysOption('Last Month',isSend),
          ],
        );
      },
    );
  }

  Widget _buildDaysOption(String currency, bool isSend) {
    return ListTile(
      title: Row(
        children: [
          const SizedBox(width: smallPadding),
          Text(currency,style: const TextStyle(color: kPrimaryColor,fontSize: 14,fontWeight: FontWeight.w500),),
        ],
      ),
      onTap: () {
        setState(() {
          if (isSend) {
            selectedDays = currency;
          }
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
          "Invoice Dashboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: smallPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                    value: light,
                    activeColor: Colors.orange,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    child: Text(
                      light ? 'Invoice' : 'Quotes',
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    width: 155,
                    height: 45,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        // Handle adding invoice or quote

                        if (light) {
                          // Navigate to Add Invoice Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddInvoiceScreen()),
                          );
                        } else {
                          // Navigate to Add Quotes Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddQuoteScreen()),
                          );
                        }


                      },
                      label: Text(
                        light ? 'New Invoice' : 'New Quotes',
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white),
                      backgroundColor: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              // Conditional widget to show Invoice or Quotes
              light ? _buildInvoiceContent() : _buildQuotesContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const SizedBox(
              height: smallPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kPinkColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Invoice",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Icon(
                          Icons.receipt,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(height: defaultPadding),
                        Text(
                          "\$47.65",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kSkyBlueColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Paid",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Icon(
                          Icons.task_alt,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(height: defaultPadding),
                        Text(
                          "\$14.75",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kGreeneColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Unpaid",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        SvgPicture.asset(
                          'assets/icons/unpaid.svg',
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        const Text(
                          "\$56.25",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kPurpleColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Overdue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Icon(
                          Icons.access_time_filled_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(height: defaultPadding),
                        Text(
                          "\$45557.58",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),


            const SizedBox(
              height: defaultPadding,
            ),
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
              child: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IndicatorWidget(
                      label: "Total Product",
                      amount: 2,
                      percentage: 0.20,
                      color: Colors.teal,
                      icon: Icons.print_rounded,
                    ),
                    IndicatorWidget(
                      label: "Total Category",
                      amount: 4,
                      percentage: 0.30,
                      color: Colors.orange,
                      icon: Icons.category,
                    ),
                    IndicatorWidget(
                      label: "Total Clients",
                      amount: 5,
                      percentage: 0.50,
                      color: Colors.purple,
                      icon: Icons.people_rounded,
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: defaultPadding,),
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
              child: Padding(padding: const EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Invoice Income Overview",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => _showCurrencyDropdown(context, true),
                          child: Container(
                            height: 50.0,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: kPrimaryColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDays != null
                                      ? '$selectedDays'
                                      : 'Today',
                                  style: const TextStyle(color: kPrimaryColor,  fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ),
            ),


            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 200,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Payment Overview",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: smallPadding,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SfCircularChart(
                          series: <CircularSeries<ChartData, String>>[
                            PieSeries<ChartData, String>(
                                dataSource: paymentOverview,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelMapper: (ChartData data, _) =>
                                data.x,
                                radius: '100%',
                                explodeIndex: 1,
                                explode: true,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    // Avoid labels intersection
                                    labelIntersectAction:
                                    LabelIntersectAction.shift,
                                    labelPosition:
                                    ChartDataLabelPosition.outside,
                                    connectorLineSettings:
                                    ConnectorLineSettings(
                                        type: ConnectorType.curve,
                                        length: '15%')))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 200,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Invoice Overview",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: smallPadding,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SfCircularChart(
                          series: <CircularSeries<ChartData, String>>[
                            PieSeries<ChartData, String>(
                                dataSource: invoiceOverview,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelMapper: (ChartData data, _) =>
                                data.x,
                                radius: '100%',
                                explodeIndex: 1,
                                explode: true,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    // Avoid labels intersection
                                    labelIntersectAction:
                                    LabelIntersectAction.shift,
                                    labelPosition:
                                    ChartDataLabelPosition.outside,
                                    connectorLineSettings:
                                    ConnectorLineSettings(
                                        type: ConnectorType.curve,
                                        length: '15%')))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: largePadding,
            ),
            const Text(
              "Invoice Payment Transaction List",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: smallPadding,
            ),
            Column(
              children: invoicePaymentList.map((ticketsData) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: smallPadding, horizontal: 0),
                  color: kPrimaryColor,
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Invoice Number:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text("${ticketsData['invoiceNumber']}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Payment Date:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text("${ticketsData['paymentDate']}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text("${ticketsData['total']}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Paid Amount:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            Text("${ticketsData['paidAmount']}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Transaction Type:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white, width: 1),
                              ),
                              child: Text("${ticketsData['transactionType']}",
                                  style:
                                  const TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotesContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const SizedBox(
              height: smallPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kPinkColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Quotes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        SvgPicture.asset(
                          'assets/icons/total_quotes.svg',
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        const Text(
                          "\$47.65",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kSkyBlueColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Converted",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/total_quotes.svg',
                              width: 30,
                              height: 30,
                              color: Colors.white,
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: Colors.white,
                            ),
                            const Icon(
                              Icons.receipt,
                              size: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        const SizedBox(height: defaultPadding),
                        const Text(
                          "\$14.75",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kGreeneColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Accept",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: defaultPadding),
                        Icon(
                          Icons.task,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(height: defaultPadding),
                        Text(
                          "\$56.25",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 160.0,
              padding: const EdgeInsets.all(smallPadding),
              decoration: BoxDecoration(
                color: kRedColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Space between children
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Reject",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        SvgPicture.asset(
                          'assets/icons/close.svg',
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        const Text(
                          "\$45557.58",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/round.svg',
                    width: 120,
                    height: 120,
                    color: Colors.white,
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

// Indicator Widget for Deposit, Debit, and Fee Debit
class IndicatorWidget extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;
  final Color color;
  final IconData icon;

  const IndicatorWidget({
    super.key,
    required this.label,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 12.0,
          percent: percentage,
          center: Icon(icon, size: 30, color: color),
          progressColor: color,
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(amount.toStringAsFixed(0),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class ChartData {
  ChartData({this.x, this.y});

  final String? x;
  final num? y;
}
