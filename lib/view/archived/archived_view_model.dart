import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/todo_model.dart';
import 'archived_states.dart';

class ArchivedViewModel extends Cubit<ArchivedStates> {
  ArchivedViewModel() : super(const ArchivedStates());

  static ArchivedViewModel get(context) => BlocProvider.of(context);

  List<ToDoModel>? toDoList = [];

  void changeIndex(int index) {
    emit(state.copyWith());
  }
}
