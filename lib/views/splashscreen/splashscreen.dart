import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:billspaye/views/landingpage/landingpage.dart';
import 'package:billspaye/views/login/selectelogin.dart';
import 'package:billspaye/widgets/bottomnavigation/bottomnavigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double opacityLevel = 1.0;
  bool loginValue = false;
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    getLoginStatus();
    Timer(const Duration(seconds: 3), () {
      _changeOpacity();
    });
  }

  getLoginStatus() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    if (userPref.getBool('isLogin') == null) {
      setState(() {
        loginValue = false;
      });
    } else {
      setState(() {
        loginValue = true;
      });
    }
    if (kDebugMode) {
      print('loginValue');
      print(loginValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AnimatedSplashScreen(
              duration: 3000,
              splash: Image.asset(Constants.logoImage),
              nextScreen: loginValue == true
                  ? const BottomNavigationTileScreen()
                  : const LandingPage(),
              animationDuration: const Duration(seconds: 3),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.topToBottom,
              splashIconSize: 500,
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    ));
  }
}
