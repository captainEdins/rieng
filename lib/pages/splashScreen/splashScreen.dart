import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rieng/pages/holder/mainHolder.dart';
import 'package:rieng/pages/landingPage/landingPage.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/resources/string.dart';

import 'dart:async';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(milliseconds: 3200), () async {
      openMe();
    });

    return Scaffold(
      backgroundColor: ColorList.appBlack,
      body: Center(
        child: logoComponents(),
      ),
    );
  }

  Widget logoComponents() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/logo.png",
          color: ColorList.appGreen,
          height: 100,
          width: 100,
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 96,
          child: Stack(
            children: [
              Text(
                Strings.appName,
                style: TextStyle(
                  color: ColorList.white,
                  fontSize: 70,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Positioned(
                bottom: 9,
                left: 4,
                child: Text(
                  Strings.slogan,
                  style: TextStyle(
                    color: ColorList.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void openMe() async {

    final getLoginStatus =  box.read('login') ?? "";
    openHome(homePage: getLoginStatus == "in");
  }

  void openHome({bool homePage = false}) {
    if (homePage) {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const MainHolder()));
    }else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandingPage()));
    }
  }
}
