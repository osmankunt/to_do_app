import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';

import '../../enum/pages.dart';
import '../../model/todo_model.dart';

class HomeViewModelStates extends Equatable {
  const HomeViewModelStates(
      {this.toDosList, this.viewStatus = ViewStatus.initial, this.index = Index.all, this.pickedDate, this.pages});

  final ViewStatus viewStatus;
  final Index? index;
  final DateTime? pickedDate;
  final List<ToDoModel>? toDosList;
  final Pages? pages;

  @override
  List<Object?> get props => [toDosList, viewStatus, index, pickedDate, pages];

  HomeViewModelStates copyWith(
      {List<ToDoModel>? toDosList, ViewStatus? viewStatus, Index? index, DateTime? pickedDate, Pages? pages}) {
    return HomeViewModelStates(
      toDosList: toDosList ?? this.toDosList,
      viewStatus: viewStatus ?? this.viewStatus,
      index: index ?? this.index,
      pickedDate: pickedDate ?? this.pickedDate,
      pages: pages ?? Pages.todo_view,
    );
  }
}
