import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/todo_model.dart';
import 'done_states.dart';

class DoneViewModel extends Cubit<DoneStates> {
  DoneViewModel() : super(const DoneStates());

  static DoneViewModel get(context) => BlocProvider.of(context);
  List<ToDoModel>? toDoList = [];

  void changeIndex(int index) {
    emit(state.copyWith());
  }
}
