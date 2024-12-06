import 'package:flutter/material.dart';
import 'package:quickcash/components/background.dart';
import 'package:quickcash/constants.dart';

class AddPaymentSuccessScreen extends StatefulWidget {
  const AddPaymentSuccessScreen({super.key});

  @override
  State<AddPaymentSuccessScreen> createState() =>
      _AddPaymentSuccessScreenState();
}

class _AddPaymentSuccessScreenState extends State<AddPaymentSuccessScreen> {
  Future<bool> _onWillPop() async {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Background(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                "assets/images/tick.png",
                fit: BoxFit.contain,
                width: 120,
                height: 120,
              ),
              const SizedBox(
                height: largePadding,
              ),
              const Text(
                "Transaction Successful",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: smallPadding),
              const Text(
                'Successfully paid \$ 150',
                maxLines: 3,
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 75,
              ),
              const Card(
                elevation: 1.0,
                color: kPrimaryLightColor,
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Transaction Id',style: TextStyle(fontWeight: FontWeight.w500,color: kPrimaryColor),),
                          Text('22124545412',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: kPrimaryColor),),
                        ],
                      ),
                      SizedBox(height: defaultPadding,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status',style: TextStyle(fontWeight: FontWeight.w500,color: kPrimaryColor),),
                          Text('Success', style: TextStyle(color: kGreenColor,fontWeight: FontWeight.w500,fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 100,),
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: FloatingActionButton.extended(
                    onPressed: (){

                    },
                    label: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    backgroundColor: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
