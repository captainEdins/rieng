import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rieng/model/taskNew.dart';
import 'package:rieng/resources/color.dart';

class HabitTile extends StatelessWidget {
  final TaskNew? task;
  final DateTime selectedDate;
  HabitTile({required this.task, required this.selectedDate});

  @override
  Widget build(BuildContext context) {

    List<String> dateList = task!.dailyInputDates!.split(',');
    List<String> typeList = task!.dailyInputTypes!.split(',');

    int indexDate = dateList.indexOf(DateFormat.yMd().format(selectedDate).toString());


    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  task?.note ?? "",
                  style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              indexDate == -1 ? "TODO" : typeList[indexDate] == "0" ? "SKIPPED" : "COMPLETED",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return ColorList.appGreenOne;
      case 1:
        return ColorList.appGreen;
      case 2:
        return ColorList.yellowClr;
      default:
        return ColorList.appGreenOne;
    }
  }
}
