class ToDoModel {
  final String title;
  final String toDo;
  final DateTime date;
  final bool isDone;

  ToDoModel({
    required this.title,
    required this.toDo,
    required this.date,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'toDo': toDo,
      'date': date.millisecondsSinceEpoch,
      'isDone': isDone,
    };
  }

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      title: json['title'] ?? '',
      toDo: json['toDo'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      isDone: json['isDone'] ?? false,
    );
  }
}
