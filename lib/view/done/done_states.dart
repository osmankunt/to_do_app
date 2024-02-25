import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';

import '../../model/todo_model.dart';

class DoneStates extends Equatable {
  DoneStates({this.toDoList, this.viewStatus = ViewStatus.initial});

  final ViewStatus viewStatus;
  List<ToDoModel>? toDoList = [];

  @override
  List<Object?> get props => [viewStatus];

  DoneStates copyWith({List<ToDoModel>? toDoList, ViewStatus? viewStatus}) {
    return DoneStates(toDoList: toDoList ?? this.toDoList, viewStatus: viewStatus ?? this.viewStatus);
  }
}
