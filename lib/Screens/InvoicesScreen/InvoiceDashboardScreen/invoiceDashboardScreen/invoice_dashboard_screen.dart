import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/AddInvoice/add_invoice_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/AddQuoteScreen/add_quote_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/InvoiceDashboardScreen/invoiceDashboardScreen/quotesModel/quotesDashboardApi.dart';
import 'package:quickcash/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickcash/util/customSnackBar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'invoiceModel/imvoiceDashboardApi.dart';

class InvoiceDashboardScreen extends StatefulWidget {
  const InvoiceDashboardScreen({super.key});

  @override
  State<InvoiceDashboardScreen> createState() => _InvoiceDashboardScreenState();
}

class _InvoiceDashboardScreenState extends State<InvoiceDashboardScreen> {
  final InvoiceDashboardApi _invoiceDashboardApi = InvoiceDashboardApi();
  final QuotesDashboardApi _quotesDashboardApi = QuotesDashboardApi();

  // Invoice
  double? totalInvoice;
  String? totalInvoicePaid;
  double? totalInvoiceUnpaid;
  String? totalInvoiceOverdue;

  // Quotes
  int? totalQuotes;
  int? totalQuotesConverted;
  int? totalQuotesAccept;
  int? totalQuotesReject;

  bool isLoading = false;
  bool light = true;

  List<ChartData> paymentOverview = [];
  List<ChartData> invoiceOverview = [];

  @override
  void initState() {
    mInvoiceDashboard();
    mQuotesDashboard();
    super.initState();
  }

  // Invoice Dashboard Api ------
  Future<void> mInvoiceDashboard() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _invoiceDashboardApi.invoiceDashboardApi();

      if (response.message == "Dashboard Invoice are fetched successfully!!!") {
        setState(() {
          totalInvoice = response.data?.totalInvoice;
          totalInvoicePaid = response.data?.totalPaid;
          totalInvoiceUnpaid = response.data?.totalUnpaid;
          totalInvoiceOverdue = response.data?.totalOverdue;

          // Update the paymentOverview list once data is available
          paymentOverview = [
            ChartData(x: 'Paid', y: double.tryParse(totalInvoicePaid ?? '0') ?? 0),
            ChartData(x: 'Unpaid', y: totalInvoiceUnpaid ?? 0.0),
          ];

          invoiceOverview = [
            ChartData(x: 'Paid', y: double.tryParse(totalInvoicePaid ?? '0') ?? 0),
            ChartData(x: 'Unpaid', y: totalInvoiceUnpaid ?? 0.0),
            ChartData(x: 'Overdue', y: double.tryParse(totalInvoiceOverdue ?? '0') ?? 0),
          ];

          isLoading = false;
        });
      } else {
        setState(() {
          totalInvoice = 0.00;
          totalInvoicePaid = "0.00";
          totalInvoiceUnpaid = 0.00;
          totalInvoiceOverdue = "0.00";

          // Reset the paymentOverview list
          paymentOverview = [
            ChartData(x: 'Paid', y: 0.0),
            ChartData(x: 'Unpaid', y: 0.0),
          ];

          isLoading = false;
        });
      }

    } catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(context: context, message: "Something went wrong!", color: kPrimaryColor);
      });
    }
  }


  // Quotes Dashboard Api --------------
  Future<void> mQuotesDashboard() async {
    setState(() {
      isLoading = false;
    });

    try{
      final response = await _quotesDashboardApi.quotesDashboardApi();

      if(response.message == "Dashboard Quote details are fetched successfully!!!"){
        setState(() {
          totalQuotes = response.data?.totalQuote;
          totalQuotesConverted = response.data?.totalConverted;
          totalQuotesAccept = response.data?.totalAccept;
          totalQuotesReject = response.data?.totalReject;
        });
      }else{
        totalQuotes = 0;
        totalQuotesConverted = 0;
        totalQuotesAccept = 0;
        totalQuotesReject = 0;
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        CustomSnackBar.showSnackBar(context: context, message: "Something went wrong!", color: kPrimaryColor);
      });
    }
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
      body:  isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      )
          : SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Invoice",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        const Icon(
                          Icons.receipt,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        Text(
                          '\$${totalInvoice?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )

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
                          "Total Paid",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        const Icon(
                          Icons.task_alt,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        Text(
                          "\$${totalInvoicePaid ?? 0}",
                          style: const TextStyle(
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
                color: kGreenColor,
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
                        Text(
                          '\$${totalInvoiceUnpaid?.toStringAsFixed(2) ?? '0.00'}',
                          style: const TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Overdue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        const Icon(
                          Icons.access_time_filled_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        Text(
                          "\$${totalInvoiceOverdue ?? 0.0}",
                          style: const TextStyle(
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

            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              width: double.infinity,
              height: 250,
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
                              dataLabelMapper: (ChartData data, _) => data.x,
                              radius: '60%',
                              explodeIndex: 1,
                              explode: true,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelIntersectAction: LabelIntersectAction.shift,
                                labelPosition: ChartDataLabelPosition.outside,
                                connectorLineSettings: ConnectorLineSettings(
                                  type: ConnectorType.curve,
                                  length: '5%',
                                ),
                              ),
                            ),
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
              height: 250,
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
                                radius: '60%',
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
                                        length: '5%')))
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
                        Text(
                          '${totalQuotes ?? 0}',
                          style: const TextStyle(
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
                        Text(
                          "${totalQuotesConverted ?? 0}",
                          style: const TextStyle(
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
                color: kGreenColor,
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
                          "Total Accept",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        const Icon(
                          Icons.task,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(height: defaultPadding),
                        Text(
                          "${totalQuotesAccept ?? 0}",
                          style: const TextStyle(
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
                        Text(
                          "${totalQuotesReject ?? 0}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
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
