import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/pages.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class DoneStates extends Equatable {
  DoneStates({this.doneList, this.viewStatus = ViewStatus.initial, this.page = Pages.todo_view});

  final ViewStatus viewStatus;
  List<ToDoModel>? doneList;
  Pages? page;

  @override
  List<Object?> get props => [viewStatus, doneList, page];

  DoneStates copyWith({List<ToDoModel>? doneList, ViewStatus? viewStatus, Pages? page}) {
    return DoneStates(doneList: doneList ?? this.doneList, viewStatus: viewStatus ?? this.viewStatus, page: page ?? this.page);
  }
}
