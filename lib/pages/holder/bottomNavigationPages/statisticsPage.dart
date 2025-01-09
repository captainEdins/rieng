import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rieng/controller/taskController.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/resources/string.dart';


class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  final _taskController = Get.put(TaskController());
  final _taskControllerHabits = Get.put(TaskController());

  Map<DateTime,int> mapGeneral = {};
  Map<DateTime,int> mapSkipped = {};
  Map<DateTime,int> mapCompleted = {};
  int completedCount = 0;
  int skippedCount = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top > 0 ? 35 : 5,
            left: 10,
            right: 10),
        child: Column(
          children: [
            appBarItems(),
            SizedBox(
              height: 10,
            ),
            title(first: 'General overview', second: ' Data.'),
            SizedBox(
              height: 5,
            ),
            topSummaryData(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  HeatMap(
                    datasets: mapGeneral,
                    colorMode: ColorMode.opacity,
                    showText: false,
                    startDate: DateTime.now().subtract(const Duration(days: 50)),
                    endDate: DateTime.now().add(const Duration(days: 50)),
                    scrollable: true,
                    colorsets: {
                      1: ColorList.appGreen.withOpacity(.1),
                      2: ColorList.appGreen.withOpacity(.2),
                      3: ColorList.appGreen.withOpacity(.3),
                      4: ColorList.appGreen.withOpacity(.4),
                      5: ColorList.appGreen.withOpacity(.5),
                      6: ColorList.appGreen.withOpacity(.6),
                      7: ColorList.appGreen.withOpacity(.7),
                      8: ColorList.appGreen.withOpacity(.8),
                      9: ColorList.appGreen.withOpacity(.9),
                      10: ColorList.appGreen,
                    },
                    // onClick: (value) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text(value.toString())));
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  title(first: 'Completed overview', second: ' Data.'),
                  HeatMap(
                    datasets: mapCompleted,
                    colorMode: ColorMode.opacity,
                    showText: false,
                    startDate: DateTime.now().subtract(const Duration(days: 50)),
                    endDate: DateTime.now().add(const Duration(days: 50)),
                    scrollable: true,
                    colorsets: {
                      1: ColorList.appGreen.withOpacity(.1),
                      2: ColorList.appGreen.withOpacity(.2),
                      3: ColorList.appGreen.withOpacity(.3),
                      4: ColorList.appGreen.withOpacity(.4),
                      5: ColorList.appGreen.withOpacity(.5),
                      6: ColorList.appGreen.withOpacity(.6),
                      7: ColorList.appGreen.withOpacity(.7),
                      8: ColorList.appGreen.withOpacity(.8),
                      9: ColorList.appGreen.withOpacity(.9),
                      10: ColorList.appGreen,
                    },
                    // onClick: (value) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text(value.toString())));
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  title(first: 'Skipped overview', second: ' Data.'),
                  HeatMap(
                    datasets: mapSkipped,
                    colorMode: ColorMode.opacity,
                    showText: false,
                    startDate: DateTime.now().subtract(const Duration(days: 50)),
                    endDate: DateTime.now().add(const Duration(days: 50)),
                    scrollable: true,
                    colorsets: {
                      1: ColorList.appGreen.withOpacity(.1),
                      2: ColorList.appGreen.withOpacity(.2),
                      3: ColorList.appGreen.withOpacity(.3),
                      4: ColorList.appGreen.withOpacity(.4),
                      5: ColorList.appGreen.withOpacity(.5),
                      6: ColorList.appGreen.withOpacity(.6),
                      7: ColorList.appGreen.withOpacity(.7),
                      8: ColorList.appGreen.withOpacity(.8),
                      9: ColorList.appGreen.withOpacity(.9),
                      10: ColorList.appGreen,
                    },
                    // onClick: (value) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text(value.toString())));
                    // },
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarItems() {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistics on ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Get.isDarkMode
                              ? ColorList.white
                              : ColorList.appBlack,
                          fontSize: 24),
                    ),
                    Text(
                      "${Strings.appName}.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: ColorList.appGreen,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? ColorList.iconBackground
                          : ColorList.appBlack.withOpacity(.1),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Icon(
                      Icons.notifications_rounded,
                      color:
                          Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                      size: 23,
                    )),
              )
            ],
          );
        });
  }

  Widget topSummaryData() {
    return Row(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorList.appGreen,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Text(
                _taskControllerHabits.taskListNew.length.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ColorList.white,
                    fontSize: 18),
              ),
              Text(
                "Habits",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorList.appBlack,
                    fontSize: 14),
              )
            ],
          ),
        )),
        Expanded(
            child: Container(
          color: Get.isDarkMode ? ColorList.appGreenOne : ColorList.appBlack,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                completedCount.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ColorList.white,
                    fontSize: 18),
              ),
              Text(
                "Completed",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode
                        ? ColorList.appBlack
                        : ColorList.appGreen,
                    fontSize: 14),
              )
            ],
          ),
        )),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorList.appGreen,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Text(
                skippedCount.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: ColorList.white,
                    fontSize: 18),
              ),
              Text(
                "Skipped",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorList.appBlack,
                    fontSize: 14),
              )
            ],
          ),
        )),
      ],
    );
  }



  void getData() {
    _taskController.getSkippedCompleted();
    _taskControllerHabits.getTask();

    for(var itemData in _taskController.dailyInput){
      setState(() {

        DateFormat formatter = DateFormat('M/d/yyyy');
        DateTime date = formatter.parse(itemData.dailyInputDate!);

        mapGeneral[date] = (mapGeneral[date] ?? 0) + 1;

        if(itemData.dailyInputType == 0){
          skippedCount++;
          mapSkipped[date] = (mapSkipped[date] ?? 0) + 1;
        }else{
          completedCount++;
          mapCompleted[date] = (mapCompleted[date] ?? 0) + 1;
        }

      });
    }

    setState(() {
      mapGeneral;
      mapSkipped;
      mapCompleted;
    });

  }

  Widget title({required String first, required String second}){

    return Row(
      children: [
        Text(
          first,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
              fontSize: 18),
        ),
        Text(
          second,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorList.appGreen,
              fontSize: 18),
        ),
      ],
    );
  }
}
