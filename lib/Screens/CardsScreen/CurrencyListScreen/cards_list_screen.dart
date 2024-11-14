import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickcash/Screens/CardsScreen/CurrencyListScreen/model/cardApi.dart';
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
                                  mEditCardCardBottomSheet(context,card.cardId!);
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

  void mEditCardCardBottomSheet(BuildContext context, String cardId) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditCardCardBottomSheet(getCardId: cardId);
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
  final String getCardId;
  const EditCardCardBottomSheet({super.key, required this.getCardId});

  @override
  State<EditCardCardBottomSheet>  createState() => _EditCardBottomSheetState();
}

class _EditCardBottomSheetState extends State<EditCardCardBottomSheet> {
  final CardApi _cardApi = CardApi();
  String selectedStatus = 'Card Status';
  List<String> status = ['Active', 'Deactivate'];
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardNo = TextEditingController();
  TextEditingController cardCVV = TextEditingController();
  TextEditingController cardExpireDate = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mCard();
  }

  Future<void> mCard() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _cardApi.cardApi(widget.getCardId);

      if (response.card != null) {
        setState(() {
          isLoading = false;
          cardHolderName.text = response.card!.cardHolderName ?? '';
          cardNo.text = response.card!.cardNumber ?? '';
          cardCVV.text = response.card!.cardCVV ?? '';
          cardExpireDate.text = response.card!.cardValidity ?? '';

          // Set selectedStatus based on the API response, handle both null and non-null values
          if (response.card!.status != null) {
            selectedStatus = response.card!.status == true ? 'Active' : 'Deactivate';
          } else {
            selectedStatus = 'Card Status'; // Default value if status is null
          }
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No Card Found';
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: isLoading
        ? const Center(
        child: CircularProgressIndicator(), // Show loading indicator
    ) : SingleChildScrollView(
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
                    controller: cardHolderName,
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
                    controller: cardNo,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
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
                    controller: cardCVV,
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
                    controller: cardExpireDate,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
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
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: 'Card Status',
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    items: ['Card Status','Active', 'Deactivate'].map((String role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedStatus = newValue!;
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

