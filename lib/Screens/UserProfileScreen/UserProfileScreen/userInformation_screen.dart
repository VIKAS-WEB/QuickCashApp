import 'package:flutter/material.dart';
import 'package:quickcash/Screens/UserProfileScreen/UserProfileScreen/model/userProfileApi.dart';
import 'package:quickcash/util/apiConstants.dart';
import 'package:quickcash/util/auth_manager.dart';
import '../../../../constants.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final UserProfileApi _userProfileApi = UserProfileApi();

  // Add text controllers to bind to the text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _totalAccountsController =
      TextEditingController();
  final TextEditingController _defaultCurrencyController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    mUserProfile();
  }

  Future<void> mUserProfile() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _userProfileApi.userProfile();

      AuthManager.saveUserImage(response.ownerProfile!);

      // Set the profile image URL dynamically
      if (response.ownerProfile != null) {
        // Assuming response.ownerProfile contains the image filename
        profileImageUrl =
            '${ApiConstants.baseImageUrl}${AuthManager.getUserId()}/${response.ownerProfile}';
      }

      if (response.name != null) {
        _fullNameController.text = response.name!;
      }
      if (response.email != null) {
        _emailController.text = response.email!;
      }
      if (response.mobile != null) {
        _mobileController.text = response.mobile!;
      }
      if (response.country != null) {
        _countryController.text = response.country!;
      }
      if (response.defaultCurrency != null) {
        _defaultCurrencyController.text = response.defaultCurrency.toString();
      }
      if (response.address != null) {
        _addressController.text = response.address!;
      }
      _totalAccountsController.text =
          response.accountDetails?.length.toString() ?? '0';

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),

                  // Profile Image Section
                  if (profileImageUrl != null)
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profileImageUrl!),
                          ),
                        ],
                      ),
                    )
                  else if (isLoading)
                    const Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                                'assets/images/profile_pic.png'), // Replace with actual image asset
                          ),
                        ],
                      ),
                    ),
                  // Show loading indicator

                  const SizedBox(height: defaultPadding),

                  Text(
                    _fullNameController.text,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),

                  const SizedBox(height: defaultPadding),

                  if (isLoading)
                    const CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  // Show loading indicator
                  if (errorMessage !=
                      null) // Show error message if there's an error
                    Text(errorMessage!,
                        style: const TextStyle(color: Colors.red)),
                  const SizedBox(
                    height: defaultPadding,
                  ),

                  // Update the text fields with TextEditingController
                  TextFormField(
                    controller: _fullNameController,
                    // Bind the controller
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: _emailController,
                    // Bind the controller
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Your Email",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: _mobileController,
                    // Bind the controller
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: _countryController,
                    // Bind the controller
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Country",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: _totalAccountsController,
                    // Bind the controller
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Total Accounts",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: _defaultCurrencyController,
                    // Bind the controller
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Default Currency",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: _addressController,
                    // Bind the controller
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {},
                    readOnly: true,
                    style: const TextStyle(color: kPrimaryColor),
                    decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: const TextStyle(color: kPrimaryColor),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide()),
                    ),
                  ),

                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
