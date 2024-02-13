import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class ToDoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String toDo;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final bool isDone;
  @HiveField(4)
  final bool isArchived;

  ToDoModel({
    required this.title,
    required this.toDo,
    required this.date,
    required this.isDone,
    required this.isArchived,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'toDo': toDo,
      'date': date.millisecondsSinceEpoch,
      'isDone': isDone,
      'isArchived': isArchived,
    };
  }

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
      title: json['title'] ?? '',
      toDo: json['toDo'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      isDone: json['isDone'] ?? false,
      isArchived: json['isArchived'] ?? false,
    );
  }
}
