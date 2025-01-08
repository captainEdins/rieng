import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rieng/controller/taskController.dart';
import 'package:rieng/model/task.dart';
import 'package:rieng/model/taskNew.dart';
import 'package:rieng/resources/color.dart';
import 'package:rieng/service/notificationService.dart';

class CreateHabit extends StatefulWidget {
  final bool isEditable;
  TaskNew? taskNew;
  CreateHabit({super.key, this.isEditable = false, this.taskNew});

  @override
  State<CreateHabit> createState() => _CreateHabitState();
}

class _CreateHabitState extends State<CreateHabit> {


  final TaskController _taskController = Get.put(TaskController());

  TextEditingController getTitle = TextEditingController();
  TextEditingController getNote = TextEditingController();
  TextEditingController getDate = TextEditingController();
  TextEditingController getStartTime = TextEditingController();
  TextEditingController getEndTime = TextEditingController();
  TextEditingController getReminder = TextEditingController();
  TextEditingController getRepeat = TextEditingController();

  int _selectedReminder = 5;
  List<int> reminderList = [5, 10, 15, 20, 30, 60];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int selectedColor = 0;

  @override
  void initState() {
    addStaticData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top > 0 ? 40 : 10,
            left: 10,
            right: 10),
        child: Column(
          children: [
            appBarItems(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 40),
                children: [
                  textInput(
                      controllerText: getTitle,
                      hintText: "Habit",
                      iconData: Icons.title_rounded),
                  textInput(
                      controllerText: getNote,
                      hintText: "Note",
                      iconData: Icons.note),
                  textInput(
                      controllerText: getDate,
                      hintText: "Select Date",
                      iconData: Icons.date_range_rounded,
                      readOnly: true,
                      tapInput: () {
                        _getDateFromUser();
                      }),
                  Row(
                    children: [
                      Expanded(
                        child: textInput(
                            controllerText: getStartTime,
                            hintText: "Start Time",
                            iconData: Icons.watch_later_rounded,
                            readOnly: true,
                            tapInput: () {
                              _getTimeFromUser(isStartTime: true);
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: textInput(
                            controllerText: getEndTime,
                            hintText: "End Time",
                            iconData: Icons.watch_later_rounded,
                            readOnly: true,
                            tapInput: () {
                              _getTimeFromUser();
                            }),
                      ),
                    ],
                  ),
                  textInput(
                    controllerText: getReminder,
                    hintText: "Select Reminder",
                    iconData: Icons.alarm_rounded,
                    readOnly: true,
                    comboBox: true,
                    tapWidget: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                      ),
                      iconSize: 32,
                      underline: SizedBox(
                        height: 0,
                      ),
                      items: reminderList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedReminder = int.parse(value!);
                          getReminder.text = "$_selectedReminder minutes early";
                        });
                      },
                    ),
                  ),
                  textInput(
                    controllerText: getRepeat,
                    hintText: "Select Repeat",
                    iconData: Icons.repeat,
                    readOnly: true,
                    comboBox: true,
                    tapWidget: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                      ),
                      iconSize: 32,
                      underline: SizedBox(
                        height: 0,
                      ),
                      items: repeatList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedRepeat = value!;
                          getRepeat.text = "Repeats $_selectedRepeat";
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Color",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 6,
                            ),
                            Wrap(
                              children: List<Widget>.generate(3, (int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: index == 0
                                          ? ColorList.appGreenOne
                                          : index == 1
                                          ? ColorList.appGreen
                                          : ColorList.yellowClr,
                                      child: selectedColor == index
                                          ? Icon(
                                        Icons.done,
                                        color: ColorList.white,
                                        size: 16,
                                      )
                                          : null,
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                      buttonAddItem()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarItems(){
    return  Row(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            child:  Icon(
              CupertinoIcons.arrow_left_circle_fill,
              color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
              size: 40,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              widget.isEditable ? "Edit " : "Add ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                  fontSize: 24),
            ),
            Text(
              "Habit",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: ColorList.appGreen,
                  fontSize: 24),
            ),
          ],
        ),
      ],
    );
  }

  Widget textInput(
      {required TextEditingController controllerText,
        required String hintText,
        required IconData iconData,
        Widget? tapWidget,
        bool readOnly = false,
        bool comboBox = false,
        Function()? tapInput}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            TextField(
              onTap: tapInput,
              readOnly: readOnly,
              keyboardType: TextInputType.text,
              cursorColor:
              Get.isDarkMode ? ColorList.white : ColorList.appBlack,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                fontSize: 15,
              ),
              controller: controllerText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Get.isDarkMode
                    ? ColorList.white.withOpacity(.1)
                    : ColorList.appBlack.withOpacity(.1),
                border: InputBorder.none,
                prefixIcon: Icon(
                  iconData,
                  size: 24,
                  color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                ),
                suffixIcon: comboBox ? tapWidget : null,
                hintText: "${!readOnly ? "Enter " : ""}$hintText",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 1,
                      color: Get.isDarkMode
                          ? ColorList.white.withOpacity(.1)
                          : ColorList.appBlack.withOpacity(.1)), //<-- SEE HERE
                ),
                labelText: hintText,
                labelStyle: TextStyle(
                  color: Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                  fontSize: 15,
                ),
                hintStyle: TextStyle(
                    color:
                    Get.isDarkMode ? ColorList.white : ColorList.appBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 1,
                      color: Get.isDarkMode
                          ? ColorList.white.withOpacity(.1)
                          : ColorList.appBlack.withOpacity(.1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (pickerDate != null) {
      setState(() {
        getDate.text = DateFormat.yMd().format(pickerDate);
      });
    }
  }

  _getTimeFromUser({bool isStartTime = false}) async {
    var pickedTime = await _showTimePicker();

    String formatedTime = pickedTime.format(context);

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          getStartTime.text = formatedTime;
        } else {
          getEndTime.text = formatedTime;
        }
      });
    }
  }

  _showTimePicker() {
    String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

    return showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(":")[0]),
            minute: int.parse(startTime.split(":")[1].split(" ")[0])));
  }

  Widget buttonAddItem() {
    return InkWell(
      onTap: () {
        _validateInput();
      },
      child: Container(
        padding: const EdgeInsets.all(7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorList.appGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.isEditable ? 'Update Habit' : "Add Habit",
          style: TextStyle(
            color: Get.isDarkMode ? ColorList.appBlack : ColorList.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  _validateInput() {
    if (getTitle.text.isNotEmpty &&
        getNote.text.isNotEmpty &&
        getDate.text.isNotEmpty &&
        getStartTime.text.isNotEmpty &&
        getEndTime.text.isNotEmpty) {

      if(!widget.isEditable){
        _addTaskToDB();
      }else{
        _updateTaskToDB();
      }
      Get.back();
    } else {
      Get.snackbar("Required", "All fields are required",
          icon: Icon(Icons.warning_amber_rounded));
    }
  }

  _addTaskToDB() async {
    await _taskController.addTask(
        task: Task(
            note: getNote.text,
            title: getTitle.text,
            date: getDate.text,
            startTime: getStartTime.text,
            endTime: getEndTime.text,
            remind: _selectedReminder,
            repeat: _selectedRepeat,
            color: selectedColor,
            isCompleted: 0));

    String dateString = "${getDate.text} ${getStartTime.text}";

    DateTime dateTime = DateFormat("MM/dd/yyyy hh:mm a").parse(dateString);

    DateTime scheduleTime =
    dateTime.subtract(Duration(minutes: _selectedReminder));

    if (scheduleTime.isAfter(DateTime.now())) {
      NotificationService().scheduleNotification(
          id: getRandomIntWithinIntLimits(),
          title: "${getTitle.text} $_selectedReminder Minutes Reminder",
          body: getNote.text,
          scheduledNotificationDateTime: scheduleTime);
    }

    if (dateTime.isAfter(DateTime.now())) {
      NotificationService().scheduleNotification(
          id: getRandomIntWithinIntLimits(),
          title: getTitle.text,
          body: getNote.text,
          scheduledNotificationDateTime: dateTime);
    }
  }
  _updateTaskToDB() async {
    await _taskController.updateHabit(
        task: Task(
            note: getNote.text,
            title: getTitle.text,
            date: getDate.text,
            startTime: getStartTime.text,
            endTime: getEndTime.text,
            remind: _selectedReminder,
            repeat: _selectedRepeat,
            color: selectedColor,
            id: widget.taskNew!.id!,
            isCompleted: 0));

    String dateString = "${getDate.text} ${getStartTime.text}";

    DateTime dateTime = DateFormat("MM/dd/yyyy hh:mm a").parse(dateString);

    DateTime scheduleTime =
    dateTime.subtract(Duration(minutes: _selectedReminder));

    if (scheduleTime.isAfter(DateTime.now())) {
      NotificationService().scheduleNotification(
          id: getRandomIntWithinIntLimits(),
          title: "${getTitle.text} $_selectedReminder Minutes Reminder",
          body: getNote.text,
          scheduledNotificationDateTime: scheduleTime);
    }

    if (dateTime.isAfter(DateTime.now())) {
      NotificationService().scheduleNotification(
          id: getRandomIntWithinIntLimits(),
          title: getTitle.text,
          body: getNote.text,
          scheduledNotificationDateTime: dateTime);
    }
  }

  int getRandomIntWithinIntLimits() {
    // Define the maximum and minimum values for a 32-bit signed integer
    const minInt32 = -2147483648; // -2^31
    const maxInt32 = 2147483647; // 2^31 - 1

    // Create a Random instance
    final random = Random();

    // Generate a random integer within the valid range
    int randomInt = random.nextInt(maxInt32 - minInt32) + minInt32;

    return randomInt;
  }

  void addStaticData() {

    if(widget.isEditable) {
      setState(() {
        getTitle.text = widget.taskNew!.title!;
        getNote.text = widget.taskNew!.note!;
        getDate.text = widget.taskNew!.date!;
        getStartTime.text = widget.taskNew!.startTime!;
        getEndTime.text = widget.taskNew!.endTime!;
        getReminder.text =
        "${widget.taskNew!.remind!.toString()} minutes early";
        getRepeat.text = "Repeats ${widget.taskNew!.repeat!}";

        _selectedReminder = widget.taskNew!.remind!;

        _selectedRepeat = widget.taskNew!.repeat!;

        selectedColor = widget.taskNew!.color!;
      });
    }
  }

}
