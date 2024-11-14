import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:quickcash/Screens/CardsScreen/cardListModel/cardListApi.dart';
import 'package:quickcash/Screens/CardsScreen/cardListModel/cardListModel.dart';
import 'package:quickcash/Screens/CardsScreen/cards_list_screen.dart';
import 'package:quickcash/constants.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final CardListApi _cardListApi = CardListApi();
  List<CardListsData> cardsListData = [];

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

    try{
      final response = await _cardListApi.cardListApi();

      if(response.cardList !=null && response.cardList!.isNotEmpty){
        setState(() {
          cardsListData = response.cardList!;
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
          "Cards",
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
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        mAddCardBottomSheet(context);
                      },
                      label: const Text(
                        'Add Card',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white),
                      backgroundColor: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 35),
                  SizedBox(
                    width: 150,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        // Add your onPressed code here!
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CardsListScreen()),
                        );
                      },
                      label: const Text(
                        'Action',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      icon: const Icon(Icons.arrow_forward, color: Colors.white),
                      backgroundColor: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardsListData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CardItem(card: cardsListData[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mAddCardBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const AddCardBottomSheet(); // Use the new StatefulWidget
      },
    );
  }
}

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet>  createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  String? selectedCoin; // Variable to hold selected coin
  List<String> coins = ['USD', 'EUR', 'INR']; // List of coins
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
                  'Add Card',
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
            const SizedBox(height: 20),
            const Text(
              "Add card details here in order to save your card",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 25),
            Card(
              child: Container(
                width: double.infinity,
                height: 200.0,
                padding: const EdgeInsets.all(smallPadding),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      left: defaultPadding,
                      child: Image.asset('assets/icons/chip.png'),
                    ),
                    const Positioned(
                      top: 75,
                      left: 75,
                      child: Text(
                        "••••    ••••    ••••    ••••",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: defaultPadding,
                      left: defaultPadding,
                      child: Text(
                        nameController.text.isEmpty ? "Your Name Here" : nameController.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 38,
                      right: defaultPadding,
                      child: Text(
                        "valid thru",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: defaultPadding,
                      right: 35,
                      child: Text(
                        '••/••',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 45),
            TextFormField(
              controller: nameController, // Set the controller
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (value) {},
              readOnly: false,
              style: const TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                labelText: "Your Name",
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
                    Text(selectedCoin ?? "Select Currency", style: const TextStyle(color: kPrimaryColor, fontSize: 16)),
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
                child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}


class CardItem extends StatefulWidget {
  final CardListsData card;

  const CardItem({super.key, required this.card});

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isFront = true;
  bool showFullNumber = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFront = !isFront;
          showFullNumber = false;
        });
      },
      child: isFront ? _buildCardFront() : _buildCardBack(),
    );
  }

  Widget _buildCardFront() {
    return Container(
      width: double.infinity,
      height: 250.0,
      padding: const EdgeInsets.all(smallPadding),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 55,
            left: defaultPadding,
            child: Image.asset('assets/icons/chip.png'),
          ),
          Positioned(
            top: 125,
            left: defaultPadding,
            child: Text(
              _formatCardNumber(widget.card.cardNumber!),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: defaultPadding,
            left: defaultPadding,
            child: Text(
              widget.card.cardHolderName!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: defaultPadding,
            right: defaultPadding,
            child: Text(
              'valid thru ${widget.card.cardValidity!}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 25,
            child: CountryFlag.fromCountryCode(
              width: 35,
              height: 35,
              widget.card.currency?.substring(0, 2) ?? "USD",
              shape: const Circle(),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showFullNumber = !showFullNumber;
                });
              },
              child: const Icon(
                Icons.info,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      width: double.infinity,
      height: 250.0,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 110,
            left: 20,
            right: 20,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.yellow, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      widget.card.cardCVV!, // CVC code
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: SizedBox(
              width: 150,
              height: 45,
              child: FloatingActionButton.extended(
                onPressed: () {
                  _mSetPinBottomSheet(context, widget.card.cardHolderName!, widget.card.cardNumber!, widget.card.cardPin!);
                },
                label: const Text(
                  'Set Pin',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                backgroundColor: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCardNumber(String cardNumber) {
    if (showFullNumber) {
      return cardNumber;
    } else {
      return '${cardNumber.substring(0, 4)}******${cardNumber.substring(10, 14)}******';
    }
  }

  void _mSetPinBottomSheet(BuildContext context, String cardName, String cardNumber, int oldPassword) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 450,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pin Change',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: kPrimaryColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Card Name: $cardName', style: const TextStyle(fontSize: 16, color: kPrimaryColor)),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Card Number: $cardNumber', style: const TextStyle(fontSize: 16, color: kPrimaryColor)),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Old Password: $oldPassword', style: const TextStyle(fontSize: 16, color: kPrimaryColor)),
                ],
              ),
              const SizedBox(height: 35),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'New PIN',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: ElevatedButton(
                  child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 16)),
                  onPressed: () {
                    // Handle the PIN submission
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class CardData {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String iconPath;
  final String oldPassword;

  CardData(this.cardNumber, this.cardHolder, this.expiryDate, this.iconPath, this.oldPassword);
}
