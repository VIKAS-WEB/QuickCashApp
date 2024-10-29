import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  final List<Map<String, String>> categoriesList = [
    {
      'createdDate': '2024-10-20',
      'category': 'Business',
      'product': '1',
    },
    {
      'createdDate': '2024-10-22',
      'category': 'Business',
      'product': '2',
    },
    // You can add more card entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const
        Text("Categories",
          style: TextStyle(color: Colors.white),),
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
                        hintStyle: const TextStyle(color: kHintColor),
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

                    },
                    child: const Icon(Icons.add,color: kPrimaryColor,),
                  ),
                ],
              ),

              const SizedBox(height: largePadding,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final card = categoriesList[index];
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
                              const Text('Category:',style: TextStyle(color: Colors.white, fontSize: 16),),
                              Text('${card['category']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          ),

                          const SizedBox(height: smallPadding,),
                          const Divider(color: kPrimaryLightColor,),
                          const SizedBox(height: smallPadding,),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Product:',style: TextStyle(color: Colors.white, fontSize: 16),),
                              Text('${card['product']}',style: const TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          ),

                          const SizedBox(height: smallPadding,),
                          const Divider(color: kPrimaryLightColor,),
                          const SizedBox(height: smallPadding,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Expanded(child: Text("Action:",style: TextStyle(color: Colors.white, fontSize: 16))),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white,),
                                onPressed: () {


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
        title: const Text("Delete Category"),
        content: const Text("Do you really want to delete this category?"),
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
                  content: Text("Category deleted successfully!"),
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