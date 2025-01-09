import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/resources/string.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top > 0 ? 35 : 5,
            left: 20,
            right: 20),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? ColorList.iconBackground : ColorList.appBlack.withOpacity(.1),
                        borderRadius: const BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                        size: 23,
                      )),
                ),
                const SizedBox(width: 15,),
                 Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Notification on ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                            fontSize: 22),
                      ),
                      Text(
                        "${Strings.appName}.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: ColorList.appGreen,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('notification')
                    .where("email", isEqualTo: email)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.dotsTriangle(
                        color: ColorList.appGreen,
                        size: 200,
                      ),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      children: [
                        const Center(
                          child: Text(
                            "you currently have no notifications",
                            maxLines: 1,
                            style: TextStyle(
                              color: ColorList.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => notification(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget notification({required Map<String, dynamic> snap}) {


    IconData iconData = CupertinoIcons.wand_rays_inverse;

    if(snap["title"] == "Password Reset"){
      iconData = CupertinoIcons.refresh_thick;
    }else if(snap["title"] == "Event Creation"){
      iconData = CupertinoIcons.house_fill;
    }else if(snap["title"] == "Event Request"){
      iconData = CupertinoIcons.link;
    }else if(snap["title"] == "Account Registration"){
      iconData = CupertinoIcons.person_add_solid;
    }else if(snap["title"] == "Account Registration"){
      iconData = CupertinoIcons.person_add_solid;
    }else if(snap["title"] == "Account Authentication"){
      iconData = CupertinoIcons.lock_open_fill;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorList.appGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: ColorList.iconBackground,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child:  Icon(
                  iconData,
                  color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
                  size: 40,
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snap["title"],
                      maxLines: 2,
                      style: TextStyle(
                          color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(snap["message"],
                      maxLines: 3,
                      style:  TextStyle(
                          color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String email = "";

  final box = GetStorage();

  setData() async {
    final getEmail = box.read('email') ?? "";

    setState(() {
      email = getEmail;
    });
  }
}
