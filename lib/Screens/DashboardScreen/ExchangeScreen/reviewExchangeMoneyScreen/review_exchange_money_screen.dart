import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';

class ReviewExchangeMoneyScreen extends StatefulWidget {
  const ReviewExchangeMoneyScreen({super.key});
  
  @override
  State<ReviewExchangeMoneyScreen> createState() => _ReviewExchangeMoneyScreen();
  
}

 class _ReviewExchangeMoneyScreen extends State<ReviewExchangeMoneyScreen> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Review Exchange Money",style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Card(
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Exchange",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: kPrimaryColor),),
                          Text("\$1.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height: 8,),
                      Divider(color: kPrimaryLightColor,),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Rate",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: kPrimaryColor),),
                          Text("\$1.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height: 8,),
                      Divider(color: kPrimaryLightColor,),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fee",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: kPrimaryColor),),
                          Text("\$1.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height: 8,),
                      Divider(color: kPrimaryLightColor,),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Charge",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: kPrimaryColor),),
                          Text("\$1.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                      SizedBox(height: 8,),
                      Divider(color: kPrimaryLightColor,),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Will get Exactly",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: kPrimaryColor),),
                          Text("\$1.0",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: defaultPadding),

              Card(
                elevation: 4.0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text("Source Account",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),),

                      const SizedBox(height: defaultPadding),

                       Card(
                        elevation: 1.0,
                        color: kPrimaryLightColor,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/profile_pic.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: defaultPadding),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'USD Account',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Text("US1000000001",style: TextStyle(
                                      fontSize: 14,
                                    ),),
                                  ],
                                ),
                              ),
                              const Text("\$325.17",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Padding(padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    //Something here
                  },

                  child: const Text('Exchange', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
 }