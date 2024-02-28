class Task {
  String? id;
  String? taskName;
  String? taskDescription;
  DateTime? taskDate;
  bool? taskStatus = false;

  Task(
      {this.id ,
      required this.taskDate,
      required this.taskName,
      required this.taskDescription,
      this.taskStatus = false});

  Task.fromFirestore(Map<String, dynamic> data)
      : this(
               id: data['id'],
            taskName: data['taskName'] as String,
            taskDescription: data['taskDescriptions'] as String,
            taskDate: DateTime.fromMillisecondsSinceEpoch(data['taskDate']),
            taskStatus: data['taskStatus'] as bool);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescriptions': taskDescription,
      'taskDate': taskDate?.millisecondsSinceEpoch,
      'taskStatus': taskStatus,
    };
  }
}
