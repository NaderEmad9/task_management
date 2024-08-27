class Task {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool completed;
  static const String collectionName = "Task";
  Task(
      {this.id = "",
      required this.title,
      required this.description,
      required this.dateTime,
      this.completed = false});

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          dateTime:
              DateTime.fromMillisecondsSinceEpoch(data['dateTime'] as int),
          completed: data['completed'] as bool,
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'completed': completed
    };
  }
}
