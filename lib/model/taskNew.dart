class TaskNew {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  // String? dailyInputDate;
  // int? dailyInputType;
  // int? dailyInputId;
  String? dailyInputDates;
  String? dailyInputTypes;

  TaskNew(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat,
      // this.dailyInputDate,
      // this.dailyInputType,
      // this.dailyInputId,
      this.dailyInputDates,
      this.dailyInputTypes
      });

  TaskNew.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
    // dailyInputDate = json['dailyInputDate'];
    // dailyInputType = json['dailyInputType'];
    // dailyInputId = json['dailyInputId'];
    dailyInputDates = json['dailyInputDates'] ?? "";
    dailyInputTypes = json['dailyInputTypes'] ?? "";
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['date'] = date;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    // data['dailyInputDate'] = dailyInputDate;
    // data['dailyInputType'] = dailyInputType;
    // data['dailyInputId'] = dailyInputId;
    data['dailyInputDates'] = dailyInputDates ?? "";
    data['dailyInputTypes'] = dailyInputTypes ?? "";
    return data;
  }
}
