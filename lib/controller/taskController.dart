import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rieng/database/databaseHelper.dart';
import 'package:rieng/model/task.dart';
import 'package:rieng/model/taskNew.dart';

class TaskController extends GetxController{

  @override
  void onReady(){

     getTask();

    super.onReady();
  }

  var taskList = <Task>[].obs;
  var taskListNew = <TaskNew>[].obs;

  Future<int> addTask({required Task ? task}) async {
    return await DatabaseHelper.insert(task);
  }

  Future<int> addTaskProgress({required Map<String, dynamic> task}) async {
    return await DatabaseHelper.insertProgress(task);
  }

  void getTask() async{
    List<Map<String, dynamic>> task = await DatabaseHelper.query();
    taskListNew.assignAll(task.map((data) => TaskNew.fromJson(data)).toList());
  }

  void deleteTask({required TaskNew ? task}){
    DatabaseHelper.delete(task : task);
  }

  void updateTaskComplete({required int id}) async{
    await DatabaseHelper.updateComplete(id: id);
  }

  Future updateHabit({required Task task}) async{
    await DatabaseHelper.updateHabit(task: task);
  }
}