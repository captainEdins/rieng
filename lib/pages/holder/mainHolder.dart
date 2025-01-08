import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rieng/pages/holder/bottomNavigationPages/homePage.dart';
import 'package:rieng/resources/color.dart';

class MainHolder extends StatefulWidget {
  const MainHolder({super.key,});

  @override
  State<MainHolder> createState() => _MainHolderState();
}

class _MainHolderState extends State<MainHolder> {

  late PersistentTabController _controller;


  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  int item = 0;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      margin:  EdgeInsets.only(left: 70,right:70,bottom: 20),
      screens: _buildScreensSpinner() ,
      items:  _navBarsItems(),
      onItemSelected: (selected){
        setState(() {
          item = selected;
        });
      },
      backgroundColor: ColorList.appGreen.withOpacity(.1),
      // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardAppears: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration:  NavBarDecoration(
        colorBehindNavBar: ColorList.appGreen,
        borderRadius: BorderRadius.circular(200.0),
      ),
      navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
            backgroundColor: item == 0 ? ColorList.appGreen : ColorList.appGreen.withOpacity(.3),
            child: const Icon(CupertinoIcons.house_fill,
              color: ColorList.white,
              size: 24,
            )),
        activeColorPrimary: ColorList.white,
        inactiveColorPrimary: ColorList.white,
      ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          backgroundColor: item == 1 ? ColorList.appGreen : ColorList.appGreen.withOpacity(.3),
            child: const Icon(CupertinoIcons.graph_square_fill,
              color: ColorList.white,
              size: 24,
            )),
        activeColorPrimary: ColorList.white,
        inactiveColorPrimary: ColorList.white,
      ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          backgroundColor: item == 2 ? ColorList.appGreen : ColorList.appGreen.withOpacity(.3),
            child: const Icon(CupertinoIcons.settings,
              color: ColorList.white,
              size: 24,
            )),
        activeColorPrimary: ColorList.white,
        inactiveColorPrimary: ColorList.white,
      ),
    ];
  }

  List<Widget> _buildScreensSpinner() {
    return [
      const HomePage(),
       containerHere("statics"),
       containerHere("settings"),
    ];
  }


  Widget containerHere(String textHere){
    return Container(
      color: ColorList.appGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children:  <Widget>[
              Center(
                child: Text(textHere,
                    style: const TextStyle(
                      fontSize: 21,fontWeight: FontWeight.w900,color: ColorList.appGreen,),textAlign: TextAlign.center
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
