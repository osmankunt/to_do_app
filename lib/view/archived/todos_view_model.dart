import 'package:flutter_bloc/flutter_bloc.dart';

import 'todos_states.dart';

class ToDoViewModel extends Cubit<ToDoStates> {
  ToDoViewModel() : super(const ToDoStates(index: 0));

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }
}
