import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rieng/pages/splashScreen/splashScreen.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/service/themeService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool changeIcon = Get.isDarkMode;
  String joined = "5 minutes ago";
  String name = "John Kimathi";
  String email = "john@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: changeIcon ? ColorList.appBlack : ColorList.white,
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top > 0 ? 35 : 5,
            left: 10,
            right: 10),
        child: Column(
          children: [
            appBarItems(),
            SizedBox(height: 50,),
            buttonLogout()
          ],
        ),
      ),
    );
  }

  Widget buttonLogout() {
    return InkWell(
      onTap: () {
        openSplashScreen();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorList.appGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Sign Out',
          style: TextStyle(
            color: changeIcon ? ColorList.appBlack : ColorList.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget appBarItems() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: changeIcon ? ColorList.white : ColorList.appBlack,
                    fontSize: 24),
              ),
              Row(
                children: [
                  Text(
                    "your ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: changeIcon ? ColorList.white : ColorList.appBlack,
                        fontSize: 24),
                  ),
                  Text(
                    "Profile.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: ColorList.appGreen,
                        fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: (){
            ThemeService().switchTheme();
            setState(() {
              changeIcon = !changeIcon;
              print("object $changeIcon");
            });
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration:  BoxDecoration(
                color: changeIcon ? ColorList.iconBackground : ColorList.appBlack.withOpacity(.1),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Icon(
                changeIcon ? Icons.sunny : Icons.nightlight,
                color: changeIcon ? ColorList.white : ColorList.appBlack,
                size: 23,
              )),
        )
      ],
    );
  }

  final box = GetStorage();
  Future<void> openSplashScreen() async {


    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      //open her the splashscreen
      box.erase();
      ThemeService().switchThemeLight();
      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => const Splashscreen()));

      print('User signed out successfully!');
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }
}
