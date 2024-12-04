import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/auth_manager.dart';
import 'package:quickcash/util/customSnackBar.dart';

class KycHomeScreen extends StatefulWidget {
  const KycHomeScreen({super.key});

  @override
  State<KycHomeScreen> createState() => _KycHomeScreenState();
}

class _KycHomeScreenState extends State<KycHomeScreen> {
  final TextEditingController mEmail = TextEditingController();
  final TextEditingController mPrimaryPhoneNo = TextEditingController();
  final TextEditingController mAdditionalPhoneNo = TextEditingController();

  @override
  void initState() {
    mSetData();
    super.initState();
  }

  Future<void> mSetData() async {
    mEmail.text = AuthManager.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Align items to the left
            mainAxisAlignment: MainAxisAlignment.start,  // Align items to the top
            children: [

              const Center(
                child: Text("Let's Verify KYC", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 28),),
              ),

              const SizedBox(height: 25,),

              const Center(
                child: Text(
                  "To fully activate your account and access all features, please complete the KYC (Know your Customer) process. It's quick and essential for your security and compliance. Don't miss out. Finish your KYC today!",
                  style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center, // Ensure text is centered
                ),
              ),

              const SizedBox(height: 35,),

              Expanded(child: SingleChildScrollView(
                child: Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        const Text(
                          'Contact Details',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: kPrimaryColor),
                        ),

                        const SizedBox(height: 25),
                        TextFormField(
                          controller: mEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Your Email",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: largePadding),
                        TextFormField(
                          controller: mPrimaryPhoneNo,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Primary Phone Number",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter primary phone number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: smallPadding,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 125,
                              height: 47.0,
                              child: FloatingActionButton.extended(
                                onPressed: () {
                                  if(mPrimaryPhoneNo.text.isNotEmpty){
                                    showCreateTicketDialog(context);
                                  }else{
                                    CustomSnackBar.showSnackBar(context: context, message: "Please enter primary phone number", color: kPrimaryColor);
                                  }
                                },
                                label: const Text(
                                  'Verify',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                backgroundColor: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: largePadding),
                        TextFormField(
                          controller: mAdditionalPhoneNo,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          style: const TextStyle(color: kPrimaryColor),
                          decoration: InputDecoration(
                            labelText: "Additional Phone Number",
                            labelStyle: const TextStyle(color: kPrimaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter additional phone number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: smallPadding,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 125,
                              height: 47.0,
                              child: FloatingActionButton.extended(
                                onPressed: () {
                                  if(mAdditionalPhoneNo.text.isNotEmpty){

                                  }else{
                                    CustomSnackBar.showSnackBar(context: context, message: "Please enter additional phone number", color: kPrimaryColor);
                                  }
                                },
                                label: const Text(
                                  'Verify',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                backgroundColor: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 35),
                        const SizedBox(height: smallPadding,),
                        SizedBox(
                          width: 185,
                          height: 47.0,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
                            label: const Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            backgroundColor: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ))


            ],
          ),
        ),
    );
  }
}

// Function to show the dialog with barrierDismissible set to false
Future<void> showCreateTicketDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing the dialog by tapping outside
    builder: (BuildContext context) {
      return const CreateTicketScreen(
      );
    },
  );
}

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key,});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();

}

class _CreateTicketScreenState extends State<CreateTicketScreen> {

  final TextEditingController mOTP = TextEditingController();

  bool isLoading = false;
  String? errorMessage;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 350,
        height: 300,
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: smallPadding,),
                const Text('Verify OTP', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 18),),

                const SizedBox(height: largePadding,),
                const Center(child: Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Text(
                          ' 4054 ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: kPrimaryColor),
                        ),

                      ],
                    ),
                  ),
                ),),

                const SizedBox(height: 25),
                TextFormField(
                  controller: mOTP,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  style: const TextStyle(color: kPrimaryColor),
                  decoration: InputDecoration(
                    labelText: "Enter OTP",
                    labelStyle: const TextStyle(color: kPrimaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),

                const SizedBox(height: 35),
                const SizedBox(height: smallPadding,),
               Center(
                 child:  SizedBox(
                   width: 185,
                   height: 47.0,
                   child: FloatingActionButton.extended(
                     onPressed: () {
                       if(mOTP.text.isNotEmpty){
                         Navigator.of(context).pop();
                       }else{
                         CustomSnackBar.showSnackBar(context: context, message: "Please enter otp", color: kPrimaryColor);
                       }
                     },
                     label: const Text(
                       'Proceed',
                       style: TextStyle(
                           color: Colors.white, fontSize: 14),
                     ),
                     backgroundColor: kPrimaryColor,
                   ),
                 ),
               ),
                const SizedBox(height: 25),

              ],
            ),
          ),
      ),
    );
  }
}



