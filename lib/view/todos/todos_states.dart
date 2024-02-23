import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';

class ToDoStates extends Equatable {
  const ToDoStates({this.viewStatus = ViewStatus.initial, required this.index});

  final ViewStatus viewStatus;
  final int index;

  @override
  List<Object?> get props => [viewStatus, index];

  ToDoStates copyWith({ViewStatus? viewStatus, int? index}) {
    return ToDoStates(viewStatus: viewStatus ?? this.viewStatus, index: index ?? this.index);
  }
}
