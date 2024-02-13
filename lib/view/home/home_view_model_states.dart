import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class HomeViewModelStates extends Equatable {
  const HomeViewModelStates({this.toDo, this.viewStatus = ViewStatus.initial, this.index = Index.all});

  final ToDoModel? toDo;

  final ViewStatus viewStatus;
  final Index? index;

  @override
  List<Object?> get props => [toDo, viewStatus, index];

  HomeViewModelStates copyWith({ToDoModel? toDo, ViewStatus? viewStatus, Index? index}) {
    return HomeViewModelStates(toDo: toDo ?? this.toDo, viewStatus: viewStatus ?? this.viewStatus, index: index ?? this.index);
  }
}
