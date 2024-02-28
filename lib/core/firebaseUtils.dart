import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/Home/data/task_model.dart';


class FirebaseUtils{
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
      fromFirestore: (snapshot, _) => Task.fromFirestore(snapshot.data()!),
      toFirestore: (task, _) => task.toFirestore(),
    );
  }
   static Future<void>  addTaskToFirestore(Task task){
    CollectionReference<Task>  taskCollection = getTasksCollection();
   DocumentReference<Task> taskDoc=taskCollection.doc();
   task.id = taskDoc.id;
   print('task id :${task.id}');

   return  taskDoc.set(task);
   }
}
