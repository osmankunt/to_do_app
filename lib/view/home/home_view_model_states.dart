import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

class HomeViewModelStates extends Equatable {
  const HomeViewModelStates({this.toDo, this.viewStatus = ViewStatus.initial});

  final ToDoModel? toDo;
  final ViewStatus viewStatus;

  @override
  List<Object?> get props => [toDo, viewStatus];
}
