import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class ToDoStates extends Equatable {
  ToDoStates({this.toDoList, this.viewStatus = ViewStatus.initial, this.pickedDate});

  List<ToDoModel>? toDoList;
  final ViewStatus viewStatus;
  final DateTime? pickedDate;

  @override
  List<Object?> get props => [toDoList, viewStatus, pickedDate];

  ToDoStates copyWith({List<ToDoModel>? toDoList, ViewStatus? viewStatus, DateTime? pickedDate}) {
    return ToDoStates(
        toDoList: toDoList ?? this.toDoList,
        viewStatus: viewStatus ?? this.viewStatus,
        pickedDate: pickedDate ?? this.pickedDate);
  }
}
