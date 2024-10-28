import 'package:flutter/material.dart';
import 'package:quickcash/Screens/TicketsScreen/chat_history_screen.dart';
import 'package:quickcash/Screens/TicketsScreen/create_ticket_screen.dart';
import 'package:quickcash/constants.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  // Sample Ticket History
  final List<Map<String, String>> ticketHistory = [
    {
      'ticketId': '1725879084380350001112',
      'createdAt': '2024-09-09',
      'subject': 'Account related Query',
      'message': 'Lorem Ipsum Dollar',
      'status': 'Close',
    },
    {
      'ticketId': '1725879084380350001113',
      'createdAt': '2024-09-10',
      'subject': 'Payment Issue',
      'message': 'Payment not processed',
      'status': 'Open',
    },
    {
      'ticketId': '1725879084380350001114',
      'createdAt': '2024-09-11',
      'subject': 'App Bug',
      'message': 'App crashes on launch',
      'status': 'Open',
    },
    {
      'ticketId': '1725879084380350001115',
      'createdAt': '2024-09-12',
      'subject': 'Feedback',
      'message': 'Great app overall!',
      'status': 'Close',
    },
  ];

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
            child: SingleChildScrollView(
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
                              Text("${ticketsData['ticketId']}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Created At:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("${ticketsData['createdAt']}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Subject:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("${ticketsData['subject']}", style: const TextStyle(color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Message:", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("${ticketsData['message']}", style: const TextStyle(color: Colors.white, fontSize: 16)),
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
                                child: Text("${ticketsData['status']}", style: const TextStyle(color: Colors.green)),
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
                                    MaterialPageRoute(builder: (context) => const ChatHistoryScreen()),
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
