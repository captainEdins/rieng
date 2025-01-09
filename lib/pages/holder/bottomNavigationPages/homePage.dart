import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rieng/controller/taskController.dart';
import 'package:rieng/model/taskNew.dart';
import 'package:rieng/pages/holder/bottomNavigationPages/commonPage/notificationPage.dart';
import 'package:rieng/pages/holder/bottomNavigationPages/home/createHabit.dart';
import 'package:rieng/pages/holder/bottomNavigationPages/widgets/habitTile.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/resources/string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var name = "John Kimathi";
  var daySelected = "Today";
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
      body: Column(
        children: [
          appBarItems(),
          toolBarItems(),
          scrollDateHolder(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 10, top: 10),
            child: stateHabitDay(),
          ),
          SizedBox(
            height: 13,
          ),
          _showTaskAdded()
        ],
      ),
    );
  }

  Widget appBarItems() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top > 0 ? 35 : 5,
          left: 10,
          right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discover the most",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color:
                          Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                      fontSize: 24),
                ),
                Row(
                  children: [
                    Text(
                      "with ",
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
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => NotificationPage());
            },
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
                  color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                  size: 23,
                )),
          )
        ],
      ),
    );
  }

  Widget toolBarItems() {
    var timeNow = DateTime.now().hour;

    var greetings = "";

    if (timeNow <= 12) {
      greetings = 'Good Morning,';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      greetings = 'Good Afternoon,';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      greetings = 'Good Evening,';
    } else {
      greetings = 'Good Night,';
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetings,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color:
                        Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: ColorList.appGreen,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          buttonAddItem()
        ],
      ),
    );
  }

  Widget buttonAddItem() {
    return InkWell(
      onTap: () async {
        await Get.to(() => CreateHabit());
        refreshItems();
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorList.appGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
              size: 16,
            ),
            Text(
              'Add Task',
              style: TextStyle(
                color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scrollDateHolder() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      child: DatePicker(
        DateTime.now(),
        width: 60,
        height: 90,
        initialSelectedDate: DateTime.now(),
        selectionColor: ColorList.appGreen,
        selectedTextColor:
            Get.isDarkMode ? ColorList.appBlack : ColorList.white,
        dateTextStyle: TextStyle(color: Colors.grey, fontSize: 24),
        dayTextStyle: TextStyle(color: Colors.grey, fontSize: 11),
        monthTextStyle: TextStyle(color: Colors.grey, fontSize: 11),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;

            int dayDifference = _daysBetween(DateTime.now(), date);

            if (dayDifference == 0) {
              daySelected = "Today";
            } else if (dayDifference == 1) {
              daySelected = "Tomorrow";
            } else {
              daySelected = DateFormat.yMd().format(date);
            }
          });
        },
      ),
    );
  }

  int _daysBetween(DateTime from, DateTime to) {
    // Consider only dates, discard time components
    DateTime fromOnlyDate = DateTime(from.year, from.month, from.day);
    DateTime toOnlyDate = DateTime(to.year, to.month, to.day);
    return toOnlyDate.difference(fromOnlyDate).inDays;
  }

  Widget stateHabitDay() {
    return Row(
      children: [
        Text(
          "Your habit for ",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
              fontSize: 18),
        ),
        Text(
          "$daySelected.",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: ColorList.appGreen,
              fontSize: 18),
        ),
      ],
    );
  }

  Widget _showTaskAdded() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          padding: EdgeInsets.only(left: 10, right: 10),
          itemCount: _taskController.taskListNew.length,
          itemBuilder: (_, index) {
            var itemHolder = _taskController.taskListNew[index];
            var getDateStore = stringToDate(dateString: itemHolder.date!);
            final differenceInDays =
                _selectedDate.difference(getDateStore).inDays;
            bool isWeekly = differenceInDays % 7 == 0;

            if (itemHolder.repeat == "Daily" ||
                itemHolder.date == DateFormat.yMd().format(_selectedDate)) {
              return taskTileHolder(index: index, itemHolder: itemHolder);
            } else if (itemHolder.repeat == "Monthly" &&
                itemHolder.date!.split("/")[1] ==
                    DateFormat.yMd().format(_selectedDate).split("/")[1]) {
              return taskTileHolder(index: index, itemHolder: itemHolder);
            } else if (itemHolder.repeat == "Weekly" && isWeekly) {
              return taskTileHolder(index: index, itemHolder: itemHolder);
            } else {
              return SizedBox();
            }
          });
    }));
  }

  Widget taskTileHolder({required int index, required TaskNew itemHolder}) {
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        child: FadeInAnimation(
          child: InkWell(
              onTap: () {
                _showBottomLayout(task: itemHolder);
              },
              child: HabitTile(
                task: itemHolder,
                selectedDate: _selectedDate,
              )),
        ),
      ),
    );
  }

  void refreshItems() {
    _taskController.getTask();
  }

  _showBottomLayout({required TaskNew task}) {
    double screenSize = MediaQuery.of(context).size.height;

    Get.bottomSheet(Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? ColorList.darkGreyClr : ColorList.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      height: !task.dailyInputDates!
              .contains(DateFormat.yMd().format(_selectedDate).toString())
          ? screenSize * 0.32
          : screenSize * 0.24,
      child: Column(
        children: [
          Container(
              height: 3,
              width: 70,
              decoration: BoxDecoration(
                color: ColorList.lightGreyBest,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? ColorList.white.withOpacity(.1)
                          : ColorList.darkGreyClr.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 29,
                      width: 29,
                      child: Icon(
                        CupertinoIcons.arrow_turn_left_down,
                        size: 24,
                        color: Get.isDarkMode
                            ? ColorList.white
                            : ColorList.darkGreyClr,
                      ),
                    )),
              ),
              Expanded(
                child: Text(
                  "Action Habit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Get.isDarkMode
                          ? ColorList.white
                          : ColorList.darkGreyClr,
                      fontSize: 20),
                ),
              ),
              InkWell(
                onTap: () async {
                  Get.back();
                  await Get.to(() => CreateHabit(taskNew: task, isEditable: true,));
                  refreshItems();
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? ColorList.white.withOpacity(.1)
                          : ColorList.darkGreyClr.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 29,
                      width: 29,
                      child: Icon(
                        CupertinoIcons.pen,
                        size: 24,
                        color: Get.isDarkMode
                            ? ColorList.white
                            : ColorList.darkGreyClr,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: !task.dailyInputDates!
                .contains(DateFormat.yMd().format(_selectedDate).toString()),
            child: Row(
              children: [
                Expanded(
                  child: buttonActions(
                      label: "Skip Task",
                      colorButton: ColorList.yellowClr,
                      tapInput: () async {
                        await _taskController.addTaskProgress(task: {
                          "idTask": task.id,
                          "dailyInputType": 0,
                          "dailyInputDate":
                              DateFormat.yMd().format(_selectedDate).toString()
                        });

                        refreshItems();
                        Get.back();
                      }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: buttonActions(
                      label: "Complete Task",
                      colorButton: ColorList.appGreen,
                      tapInput: () async {
                        await _taskController.addTaskProgress(task: {
                          "idTask": task.id,
                          "dailyInputType": 1,
                          "dailyInputDate":
                              DateFormat.yMd().format(_selectedDate).toString()
                        });
                        refreshItems();
                        Get.back();
                      }),
                ),
              ],
            ),
          ),
          buttonActions(
              label: "Delete Task",
              colorButton: ColorList.red,
              tapInput: () {
                _taskController.deleteTask(task: task);
                refreshItems();
                Get.back();
              }),
        ],
      ),
    ));
  }

  Widget buttonActions(
      {required String label, Function()? tapInput, Color? colorButton}) {
    return InkWell(
      onTap: tapInput,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: colorButton,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  DateTime stringToDate({required String dateString}) {
    try {
      return DateFormat("MM/dd/yyyy").parse(dateString);
    } catch (e) {
      // Handle invalid date string format
      print('Invalid date string format: $dateString');
      return DateTime.now(); // Or handle the error differently
    }
  }

  final box = GetStorage();

  setData() {
    final getName = box.read('name') ?? "";

    setState(() {
      name = getName;
    });
  }
}
