import 'package:flutter/material.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/auth_manager.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});


  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer>{

  @override
  Widget build(BuildContext context){
    return Container(
      color: kPrimaryColor,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: defaultPadding,),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://quickcash.oyefin.com/storage/66d6f4868f27287f8f7f2546/ownerProfile-173079761956539.jpg'),
                fit: BoxFit.cover, // Ensures the image covers the container fully
              ),
            ),
          ),

          Text(
            AuthManager.getUserName(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            AuthManager.getUserEmail(),
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}