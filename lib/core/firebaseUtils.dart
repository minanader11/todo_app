import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/features/Home/data/task_model.dart';
import 'package:todo_app/features/Home/data/user_model.dart';


class FirebaseUtils{
  static CollectionReference<Task> getTasksCollection(String id) {
    return getUserCollection().doc(id).collection('tasks').withConverter<Task>(
      fromFirestore: (snapshot, _) => Task.fromFirestore(snapshot.data()!),
      toFirestore: (task, _) => task.toFirestore(),
    );
  }
   static Future<void>  addTaskToFirestore(Task task,String id){
    CollectionReference<Task>  taskCollection = getTasksCollection(id);
   DocumentReference<Task> taskDoc=taskCollection.doc();
   task.id = taskDoc.id;
   print('task id :${task.id}');

   return  taskDoc.set(task);
   }
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
      fromFirestore: (snapshot, _) => MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (user, _) => user.toFireStore(user),
    );
  }
  static Future<void>  addUserToFirestore(MyUser user){
    CollectionReference<MyUser>  userCollection = getUserCollection();
    return userCollection.doc(user.id).set(user);
  }
  static Future<MyUser?>readUserFromFirestore(String id)async {
    var querySnapshots=await getUserCollection().doc(id).get();
    return querySnapshots.data();
  }
}
