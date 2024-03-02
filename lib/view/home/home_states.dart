import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class HomeViewModelStates extends Equatable {
  const HomeViewModelStates({this.toDosList, this.viewStatus = ViewStatus.initial, this.index = Index.all, this.pickedDate});

  final ViewStatus viewStatus;
  final Index? index;
  final DateTime? pickedDate;
  final List<ToDoModel>? toDosList;

  @override
  List<Object?> get props => [toDosList, viewStatus, index, pickedDate];

  HomeViewModelStates copyWith({List<ToDoModel>? toDosList, ViewStatus? viewStatus, Index? index, DateTime? pickedDate}) {
    return HomeViewModelStates(
      toDosList: toDosList ?? this.toDosList,
      viewStatus: viewStatus ?? this.viewStatus,
      index: index ?? this.index,
      pickedDate: pickedDate ?? this.pickedDate,
    );
  }
}
