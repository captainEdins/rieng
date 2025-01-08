import 'package:flutter/material.dart';
import 'package:get/get.dart';

void pushReplacement(
    {required Widget classReplace}) {
  Get.off(classReplace);
}

void pushNotReplacement(
    {required Widget classReplace}) {
  Get.to(classReplace);
}

// void pushNotReplacementNavigation(
//     {required Widget classReplace, required BuildContext context}) {
//   pushNewScreen(
//     context,
//     screen: classReplace,
//     withNavBar: false, // OPTIONAL VALUE. True by default.
//     pageTransitionAnimation: PageTransitionAnimation.slideRight,
//   );
// }
