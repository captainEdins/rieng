import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/service/themeService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool changeIcon = Get.isDarkMode;

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
            appBarItems()
          ],
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
}
