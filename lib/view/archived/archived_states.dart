import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class ArchivedStates extends Equatable {
  ArchivedStates({this.archivedList, this.viewStatus = ViewStatus.initial});

  List<ToDoModel>? archivedList;
  final ViewStatus viewStatus;

  @override
  List<Object?> get props => [archivedList, viewStatus];

  ArchivedStates copyWith({
    List<ToDoModel>? archivedList,
    ViewStatus? viewStatus,
  }) {
    return ArchivedStates(archivedList: archivedList ?? this.archivedList, viewStatus: viewStatus ?? this.viewStatus);
  }
}
