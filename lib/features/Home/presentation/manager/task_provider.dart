import 'package:flutter/material.dart';
import 'package:todo_app/features/Home/data/task_model.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> tasks=[];
  List<Task> filteredTasks=[];
  DateTime date=DateTime.now();
  DateTime calendarDate= DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  void filteringTasks(DateTime date){
    filteredTasks = tasks.where((element) => element.taskDate==date).toList();
    notifyListeners();
  }

}