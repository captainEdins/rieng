import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rieng/controller/taskController.dart';
import 'package:rieng/model/taskNew.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/service/themeService.dart';
import 'package:rieng/test/taskTile.dart';
import 'package:rieng/test/testPageAdd.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(convertDateTime(DateTime.now().toString()),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500))),
                buttonAddItem()
              ],
            ),
            Text(
              "Today",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            DatePicker(
              DateTime.now(),
              width: 60,
              height: 90,
              initialSelectedDate: DateTime.now(),
              selectionColor: ColorList.bluishClr,
              selectedTextColor: ColorList.white,
              dateTextStyle: TextStyle(color: Colors.grey, fontSize: 24),
              dayTextStyle: TextStyle(color: Colors.grey, fontSize: 11),
              monthTextStyle: TextStyle(color: Colors.grey, fontSize: 11),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            _showTaskAdded()
          ],
        ),
      ),
    );
  }

  bool changeIcon = Get.isDarkMode;

  appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          print("object");
          ThemeService().switchTheme();
          setState(() {
            changeIcon = !changeIcon;

            print("object $changeIcon");
          });
        },
        child: Icon(
          changeIcon ? Icons.sunny : Icons.nightlight,
          size: 20,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/bg-landing.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  String convertDateTime(String dateString) {
    // Parse the time string
    final DateTime date = DateTime.parse(dateString);
    final formatter = DateFormat('EE, dd MMMM yyyy');
    return formatter.format(date);
  }

  Widget buttonAddItem() {
    return InkWell(
      onTap: () async {
        await Get.to(() => TestPageAdd());
        refreshItems();
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorList.bluishClr,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: ColorList.white,
              size: 16,
            ),
            const Text(
              'Add Task',
              style: TextStyle(
                color: ColorList.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showTaskAdded() {

    return Expanded(child: Obx(() {
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: _taskController.taskListNew.length,
          itemBuilder: (_, index) {
            var itemHolder = _taskController.taskListNew[index];
            var getDateStore = stringToDate(dateString: itemHolder.date!);
            final differenceInDays = _selectedDate.difference(getDateStore).inDays;
            bool isWeekly = differenceInDays % 7 == 0;

            print(itemHolder.toJson());


            if(itemHolder.repeat == "Daily" || itemHolder.date == DateFormat.yMd().format(_selectedDate) ){
              return taskTileHolder(index: index, itemHolder: itemHolder);
            }else if(itemHolder.repeat == "Monthly" && itemHolder.date!.split("/")[1] == DateFormat.yMd().format(_selectedDate).split("/")[1]){
              return taskTileHolder(index: index, itemHolder: itemHolder);
            }else if(itemHolder.repeat == "Weekly" && isWeekly){
              return taskTileHolder(index: index, itemHolder: itemHolder);
            }else{
             return SizedBox();
            }

          });
    }));
  }

  Widget taskTileHolder({required int index, required TaskNew itemHolder}){

    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        child: FadeInAnimation(
          child: InkWell(
              onTap: () {
                _showBottomLayout(
                    task: itemHolder);
              },
              child: TaskTile(task: itemHolder, selectedDate: _selectedDate,)),
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
      height: !task.dailyInputDates!.contains(DateFormat.yMd().format(_selectedDate).toString()) ? screenSize * 0.32 : screenSize * 0.24,
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
                        color: Get.isDarkMode ? ColorList.white : ColorList.darkGreyClr,
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
                  await Get.to(() => TestPageAdd(taskNew: task, isEditable: true,));
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
                        color: Get.isDarkMode ? ColorList.white : ColorList.darkGreyClr,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Visibility(
            visible: !task.dailyInputDates!.contains(DateFormat.yMd().format(_selectedDate).toString()),
            child: Row(
              children: [
                Expanded(
                  child: buttonActions(
                      label: "Skip Task",
                      colorButton: ColorList.bluishClr,
                      tapInput: () async {

                        await _taskController.addTaskProgress(
                            task: {
                              "idTask": task.id,
                              "dailyInputType": 0,
                              "dailyInputDate": DateFormat.yMd().format(_selectedDate).toString()
                            }
                        );

                        refreshItems();
                        Get.back();
                      }),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: buttonActions(
                      label: "Complete Task",
                      colorButton: ColorList.yellowClr,
                      tapInput: () async {
                        await _taskController.addTaskProgress(
                            task: {
                              "idTask": task.id,
                              "dailyInputType": 1,
                              "dailyInputDate": DateFormat.yMd().format(_selectedDate).toString()
                            }
                        );
                        refreshItems();
                        Get.back();
                      }),
                ),
              ],
            ),
          ),
          buttonActions(
              label: "Delete Task",
              colorButton: ColorList.pinkClr,
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
            color: ColorList.white,
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

}
