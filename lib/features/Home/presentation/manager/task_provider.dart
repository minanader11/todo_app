import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/firebaseUtils.dart';
import 'package:todo_app/features/Home/data/task_model.dart';

class TaskProvider extends ChangeNotifier{
  List<Task> tasks=[];
  List<Task> filteredTasks=[];
  DateTime date=DateTime.now();
  DateTime calendarDate= DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  changeDate(DateTime newDate,String id){
    date = newDate;
    getAllTasks(id);
  }
  addTask(Task task,String id){
    FirebaseUtils.addTaskToFirestore(task,id);
  }
  getAllTasks(String id)async{
    QuerySnapshot<Task> querySnapshots= await FirebaseUtils.getTasksCollection(id).get();
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
updateTask(Task task,String id)async{
    await FirebaseUtils.getTasksCollection(id).doc(task.id).update({ 'taskName': task.taskName,
      'taskDescriptions': task.taskDescription,
      'taskDate': task.taskDate?.millisecondsSinceEpoch,
      'taskStatus': task.taskStatus,});
    getAllTasks(id);

}
  deleteTask(Task task,String id) {
    FirebaseUtils.getTasksCollection(id).doc(task.id).delete();
    //getAllTasks();
    notifyListeners();
  }

}