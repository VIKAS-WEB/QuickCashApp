import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickcash/Screens/ReferAndEarnScreen/model/referAndEarnApi.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

import '../../util/apiConstants.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {

  final ReferAndEarnApi _referAndEarnApi = ReferAndEarnApi();
  // Store the referral link
  String? referralLink;
  bool isLoading = false;
  String? errorMessage;

  void _copyReferralLink() {
    if (referralLink != null) {
      Clipboard.setData(ClipboardData(text: referralLink!)).then((_) {
        CustomSnackBar.showSnackBar(
          context: context,
          message: 'Referral link copied to clipboard!',
          color: kPrimaryColor,
        );
      });
    } else {
      // Show an error or handle the case when referralLink is null
      CustomSnackBar.showSnackBar(
        context: context,
        message: 'Referral link is not available!',
        color: Colors.red,
      );
    }
  }


  @override
  void initState() {
    super.initState();
    mReferralAndEarn();
  }

  Future<void> mReferralAndEarn() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _referAndEarnApi.referralAndEarnApi();

      if (response.referralCode != null) {
        setState(() {
          referralLink = '${ApiConstants.baseReferralCodeUrl}${response.referralCode}';
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Referral code is unavailable';
          isLoading = false;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.transparent),
        title: const Text(
          "Refer & Earns",
          style: TextStyle(color: Colors.transparent),
        ),
      ),
    body: isLoading ? const Center(
      child: CircularProgressIndicator(
        color: kPrimaryColor,
      ),
    ) : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align all children to the start
          children: [
            const SizedBox(height: defaultPadding),
            Card(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/referrer_bg.png', // Replace with your image path
                      fit: BoxFit.cover,
                      height: 270,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Refer Your Friends And Get Rewards",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Tell your friends about TITA. Copy and paste the referral URL provided below to as many people as possible. Receive interesting incentives and deals as a reward for your recommendation!",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: defaultPadding),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                referralLink ?? 'Loading referral link...', // Fallback message
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.copy, color: Colors.white),
                              onPressed: _copyReferralLink,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            const Text(
              "How Does it Work?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,), // Optional styling
            ),

            const SizedBox(height: 8),
            const Text("All you have to do is develop campaigns, distribute them, and you'll be able to profit from our lucrative trading platform in no time. Discover how to:"),

            const SizedBox(height: defaultPadding),
            const Text(
              '1. Get Your Link',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                'Sign up for the platform, begin trading, and receive the above-mentioned referral link.',
              ),
            ),


            const SizedBox(height: defaultPadding),
            const Text(
              '2. Share Your Link',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                'Distribute the generated link to the specified number of sources.',
              ),
            ),


            const SizedBox(height: 16),
            const Text(
              '3. Earn When They Trade',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

          ],
        ),
      ),
    ),
    );
  }
}
