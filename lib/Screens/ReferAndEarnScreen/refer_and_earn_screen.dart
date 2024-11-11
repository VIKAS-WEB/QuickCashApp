import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickcash/constants.dart';
import 'package:quickcash/util/customSnackBar.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({super.key});

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  // Store the referral link
  final String referralLink = "https://quickcash.oyefin.com/register?code=8AQsHE2O9j"; // Replace with your actual referral link
  bool isLoading = false;
  String? errorMessage;

  void _copyReferralLink() {
    Clipboard.setData(ClipboardData(text: referralLink)).then((_) {
      CustomSnackBar.showSnackBar(context: context, message: 'Referral link copied to clipboard!', color: kPrimaryColor);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Refer & Earns",
          style: TextStyle(color: Colors.white),
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
                                referralLink,
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
