import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/firebaseUtils.dart';
import 'package:todo_app/features/Home/data/task_model.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> tasks=[];
  List<Task> filteredTasks=[];
  DateTime date=DateTime.now();
  DateTime calendarDate= DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  changeDate(DateTime newDate){
    date = newDate;
    getAllTasks();
  }
  addTask(Task task){
    FirebaseUtils.addTaskToFirestore(task);
  }
  getAllTasks()async{
    QuerySnapshot<Task> querySnapshots= await FirebaseUtils.getTasksCollection().get();
   tasks = querySnapshots.docs.map((doc) => doc.data()).toList();
   tasks = tasks.where((task) {
     if(date.day==task.taskDate!.day && date.month==task.taskDate!.month && date.year==task.taskDate!.year){
       return true;
     }
     return false;
   }).toList();
   tasks.sort((task1,task2){

      return task1.taskDate!.compareTo(task2.taskDate!);
    });
   notifyListeners();
  }
updateTask(Task task)async{
    await FirebaseUtils.getTasksCollection().doc(task.id).update({ 'taskName': task.taskName,
      'taskDescriptions': task.taskDescription,
      'taskDate': task.taskDate?.millisecondsSinceEpoch,
      'taskStatus': task.taskStatus,});
    getAllTasks();

}
  deleteTask(Task task) {
    FirebaseUtils.getTasksCollection().doc(task.id).delete();
    //getAllTasks();
    notifyListeners();
  }

}