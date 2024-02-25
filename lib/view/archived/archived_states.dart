import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class ArchivedStates extends Equatable {
  ArchivedStates({this.toDoList, this.viewStatus = ViewStatus.initial});

  List<ToDoModel>? toDoList;
  final ViewStatus viewStatus;

  @override
  List<Object?> get props => [toDoList, viewStatus];

  ArchivedStates copyWith({
    List<ToDoModel>? toDoList,
    ViewStatus? viewStatus,
  }) {
    return ArchivedStates(toDoList: toDoList ?? this.toDoList, viewStatus: viewStatus ?? this.viewStatus);
  }
}
