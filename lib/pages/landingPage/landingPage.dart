import 'package:flutter/material.dart';
import 'package:rieng/pages/authentication/signIn.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/resources/string.dart';
import 'package:rieng/util/openPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  bool nextPage = false;

  late AssetImage assetImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      pageList(
          "Effortless Habit Tracking",
          "${Strings.appName} makes it easy to build and maintain healthy habits. Track your progress, stay motivated, and achieve your goals.",
          0),
      pageList(
          "Your Journey to Better Habits Starts Here",
          "${Strings.appName} empowers you to create a personalized habit tracking plan that fits your unique lifestyle. Let's build lasting positive change together.",
          1),
      pageList(
          "Join the ${Strings.appName} Community & Thrive",
          "Track your habits, find inspiration, and connect with a community of like-minded individuals. ${Strings.appName} is here to support you on your journey to a better you.",
          2),
    ];

    return Scaffold(
      backgroundColor: ColorList.backgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/bg-landing.jpg'),
                    ),
                  ))),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.bottomCenter, colors: [
                  ColorList.appBlack,
                  ColorList.appBlack.withOpacity(.3),
                ])),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                child: Center(
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          dotHeight: 6,
                          dotWidth: 6,
                          activeDotColor: ColorList.white,
                          dotColor: ColorList.appGreen,
                          type: WormType.thin,
                          // strokeWidth: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 240,
                        child: PageView.builder(
                          controller: controller,
                          onPageChanged: (indexed) {
                            var index = indexed % pages.length;
                            setState(() {
                              if (index == 2) {
                                nextPage = true;
                              } else {
                                nextPage = false;
                              }
                            });
                          },
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget buttonSkip() {
    return Visibility(
      visible: nextPage,
      child: InkWell(
        onTap: () {
          pushReplacement( classReplace: const SignIn());
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            padding: const EdgeInsets.all(15),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorList.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                color: ColorList.appBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pageList(String title, String more, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: ColorList.white,
                  fontSize: 22),
            ),
            Text(
              more,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: ColorList.white,
                  fontSize: 13),
            ),
            buttonSkip()
          ],
        ),
      ),
    );
  }
}
