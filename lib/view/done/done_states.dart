import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class DoneStates extends Equatable {
  DoneStates({this.doneList, this.viewStatus = ViewStatus.initial});

  final ViewStatus viewStatus;
  List<ToDoModel>? doneList;

  @override
  List<Object?> get props => [viewStatus, doneList];

  DoneStates copyWith({List<ToDoModel>? doneList, ViewStatus? viewStatus}) {
    return DoneStates(doneList: doneList ?? this.doneList, viewStatus: viewStatus ?? this.viewStatus);
  }
}
