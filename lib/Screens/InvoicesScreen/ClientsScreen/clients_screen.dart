import 'package:flutter/material.dart';
import 'package:quickcash/Screens/InvoicesScreen/ClientsScreen/AddClientsFormScreen/add_clients_form_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/ClientsScreen/EditClientsFormScreen/edit_clients_form_screen.dart';
import 'package:quickcash/Screens/InvoicesScreen/ClientsScreen/ViewClientsScreen/view_clients_screen.dart';
import 'package:quickcash/constants.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {

  final List<Map<String, String>> clientsList = [
    {
      'createdDate': '2024-10-20',
      'clientName': 'Ganesh',
    },
    {
      'createdDate': '2024-10-22',
      'clientName': 'Ganesh Kumar',
    },
    // You can add more card entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Clients",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,

                        onSaved: (value){

                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(defaultPadding),
                            borderSide: const BorderSide(),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Search",
                          hintStyle: const TextStyle(color: kPrimaryColor),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                  ),

                  const SizedBox(width: defaultPadding,),

                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddClientsFormScreen()),
                      );
                    },
                    child: const Icon(Icons.add,color: kPrimaryColor,),
                  ),
                ],
              ),

              const SizedBox(height: largePadding,),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: clientsList.length,
                itemBuilder: (context, index) {
                  final card = clientsList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding), // Add spacing
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Created Date:', style: TextStyle(color: Colors.white, fontSize: 16),),
                              Text('${card['createdDate']}', style: const TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          ),

                          const SizedBox(height: smallPadding,),
                          const Divider(color: kPrimaryLightColor,),
                          const SizedBox(height: smallPadding,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Client Name:',style: TextStyle(color: Colors.white, fontSize: 16),),
                              Text('${card['clientName']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          ),



                          const SizedBox(height: smallPadding,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye,color: Colors.white,),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ViewClientsScreen()),
                                  );

                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white,),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const EditClientsFormScreen()),
                                  );

                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.white,),
                                onPressed: () {
                                  _showDeleteClientDialog();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteClientDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Client"),
        content: const Text("Do you really want to delete this client?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // No
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Yes
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Client deleted successfully!"),
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    )) ?? false;
  }

}