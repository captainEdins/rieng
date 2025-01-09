class Input {
  int? dailyInputId;
  int? dailyInputType;
  String? dailyInputDate;
  int? idTask;


  Input(
      {this.dailyInputType,
      this.dailyInputId,
      this.dailyInputDate,
      this.idTask});

  Input.fromJson(Map<String, dynamic> json){
    dailyInputType = json['dailyInputType'];
    dailyInputId = json['dailyInputId'];
    dailyInputDate = json['dailyInputDate'];
    idTask = json['idTask'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dailyInputType'] = dailyInputType;
    data['dailyInputId'] = dailyInputId;
    data['dailyInputDate'] = dailyInputDate;
    data['idTask'] = idTask;
    return data;
  }
}
