import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/TicketsScreen/TicketScreen/model/ticketScreenApi.dart';
import 'package:quickcash/Screens/TicketsScreen/TicketScreen/model/ticketScreenModel.dart';
import 'package:quickcash/Screens/TicketsScreen/chatHistoryScreen/chat_history_screen.dart';
import 'package:quickcash/Screens/TicketsScreen/CreateTicketScreen/create_ticket_screen.dart';
import 'package:quickcash/constants.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {

  final TicketListApi _ticketListApi = TicketListApi();
  List<TicketListsData> ticketHistory = [];

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mTicketHistory();
  }

  Future<void> mTicketHistory() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try{
      final response = await _ticketListApi.ticketListApi();

      if(response.ticketList !=null && response.ticketList!.isNotEmpty){
        setState(() {
          ticketHistory = response.ticketList!;
          isLoading = false;
        });
      }else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Statement List';
        });
      }

    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  // Function to format the date
  String formatDate(String? dateTime) {
    if (dateTime == null) {
      return 'Date not available';
    }
    DateTime date = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Tickets", style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          const SizedBox(height: defaultPadding),

          // Create Ticket Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showCreateTicketDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create Ticket', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding),

          Expanded(
            child:  isLoading ? const Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ) : SingleChildScrollView(
              child: Column(
                children: ticketHistory.map((ticketsData) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: kPrimaryColor,
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Ticket ID:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("${ticketsData.ticketId}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Created At:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text(formatDate(ticketsData.date), style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subject:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("${ticketsData.subject}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Message:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("${ticketsData.message}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Status:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white, width: 1),
                                ),
                                child: Text("${ticketsData.status}", style: const TextStyle(color: Colors.green)),
                              ),
                            ],
                          ),

                          // View Button
                          const SizedBox(height: 35),
                          Center(
                            child: SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChatHistoryScreen(mID: ticketsData.id,)),
                                  );
                                },
                                child: const Text('View', style: TextStyle(color: kPrimaryColor, fontSize: 16)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
