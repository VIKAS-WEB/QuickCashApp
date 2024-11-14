import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/CardsScreen/cardListModel/cardListApi.dart';
import 'package:quickcash/Screens/CardsScreen/cardListModel/cardListModel.dart';
import 'package:quickcash/constants.dart';

class CardsListScreen extends StatefulWidget {
  const CardsListScreen({super.key});

  @override
  State<CardsListScreen> createState() => _CardsListScreenState();
}

class _CardsListScreenState extends State<CardsListScreen> {
  final CardListApi _cardListApi = CardListApi();
  List<CardListsData> cardListData = [];

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mCardList();
  }

  Future<void> mCardList() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {

      final response = await _cardListApi.cardListApi();

      if(response.cardList !=null && response.cardList!.isNotEmpty){
        setState(() {
          cardListData = response.cardList!;
          isLoading = false;
        });
      }else{
        setState(() {
          isLoading = false;
          errorMessage = 'No Card Found';
        });
      }

    }catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
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
          "Cards List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(), // Show loading indicator
      ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardListData.length,
                itemBuilder: (context, index) {
                  final card = cardListData[index];


                  DateTime parsedDate = DateTime.parse(card.date!);
                  String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: defaultPadding), // Add spacing
                    child: Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text('Date: $formattedDate', style: const TextStyle(color: kPrimaryColor, fontSize: 16),),
                          const Divider(color: kPrimaryLightColor,),
                          Text('Name: ${card.cardHolderName}',style: const TextStyle(color: kPrimaryColor, fontSize: 16),),
                          const Divider(color: kPrimaryLightColor,),
                          Text('Card Number: ${card.cardNumber}',style: const TextStyle(color: kPrimaryColor, fontSize: 16),),
                          const Divider(color: kPrimaryLightColor,),
                          Text('CVC: ${card.cardCVV}',style: const TextStyle(color: kPrimaryColor, fontSize: 16),),
                          const Divider(color: kPrimaryLightColor,),
                          Text('Expiry: ${card.cardValidity}',style: const TextStyle(color: kPrimaryColor, fontSize: 16),),
                          const Divider(color: kPrimaryLightColor,),
                          Text(
                            'Status: ${card.status! ? 'Active' : 'Deactivate'}',
                            style: const TextStyle(color: kPrimaryColor, fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,color: kPrimaryColor,),
                                onPressed: () {
                                  // Edit action
                                  mEditCardCardBottomSheet(context);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,color: kPrimaryColor,),
                                onPressed: () {
                                  _showDeleteCardDialog();
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

  void mEditCardCardBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const EditCardCardBottomSheet(); // Use the new StatefulWidget
      },
    );
  }


  Future<bool> _showDeleteCardDialog() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Card"),
        content: const Text("Do you really want to delete this card?"),
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
                  content: Text("Card deleted successfully!"),
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


class EditCardCardBottomSheet extends StatefulWidget {
  const EditCardCardBottomSheet({super.key});

  @override
  State<EditCardCardBottomSheet>  createState() => _EditCardBottomSheetState();
}

class _EditCardBottomSheetState extends State<EditCardCardBottomSheet> {
  String? selectedCoin; // Variable to hold selected coin
  List<String> coins = ['Active', 'Deactivate']; // List of coins
  TextEditingController nameController = TextEditingController(); // Controller for the name input

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Card Details',
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
            const SizedBox(height: defaultPadding),

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: smallPadding),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: false,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Card Name",
                      labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Refresh the UI when the name changes
                    },
                  ),


                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: false,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Card Number",
                      labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Refresh the UI when the name changes
                    },
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: false,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "CVV",
                      labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Refresh the UI when the name changes
                    },
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: false,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Expiry Date",
                      labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Refresh the UI when the name changes
                    },
                  ),


                  const SizedBox(height: defaultPadding,),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedCoin ?? "Card Status", style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
                          const Icon(Icons.arrow_drop_down, color: kPrimaryColor),
                        ],
                      ),
                    ),
                    onTap: () {
                      RenderBox renderBox = context.findRenderObject() as RenderBox;
                      Offset offset = renderBox.localToGlobal(Offset.zero);

                      showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          offset.dx,
                          offset.dy + renderBox.size.height,
                          offset.dx + renderBox.size.width,
                          0.0,
                        ),
                        items: coins.map((String value) {
                          return PopupMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ).then((String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCoin = newValue; // Update the selected coin
                          });
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: ElevatedButton(
                      child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 45),
                ],
              ),
            ),

            const SizedBox(height: 25,),


          ],
        ),
      ),
    );
  }
}

