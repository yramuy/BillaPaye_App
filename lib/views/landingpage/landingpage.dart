import 'package:billspaye/widgets/bottomnavigation/bottomnavigation.dart';
import 'package:billspaye/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/responsive.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const LandingScreen(),
      desktop: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: const LandingScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Constants.landingBg,
                ),
                fit: BoxFit.cover)),
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Text(
                'Bills Paye',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
              ),
              Image.asset(
                Constants.logoImage,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 3),
              GestureDetector(
                // onTap: () => Get.to(() => const ChooseLoginScreen()),
                onTap: () => Get.offAll(() => const BottomNavigationTileScreen()),
                child: Column(
                  children: [
                    Image.asset(Constants.swipeIcon),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'Lets Start',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
