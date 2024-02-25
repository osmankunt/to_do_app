import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../constant/constants.dart';
import '../../enum/states.dart';
import '../../model/todo_model.dart';
import 'archived_states.dart';

class ArchivedViewModel extends Cubit<ArchivedStates> {
  ArchivedViewModel() : super(ArchivedStates()) {
    getHiveBox();
  }

  static ArchivedViewModel get(context) => BlocProvider.of(context);

  List<ToDoModel>? toDoList = [];

  // change state
  changeState({List<ToDoModel>? toDoList, ViewStatus? viewStatus}) {
    emit(state.copyWith(toDoList: toDoList, viewStatus: viewStatus));
  }

  // get hive box
  getHiveBox() async {
    changeState(viewStatus: ViewStatus.loading);
    var box = await Hive.openBox<ToDoModel>(Constants.toDoBox);

    // Empty the HiveBox
    //box.deleteFromDisk();
    var keys = [];
    keys = box.keys.cast<int>().toList();
    toDoList = [];
    for (var key in keys) {
      toDoList!.add(box.get(key)!);
    }
    changeState(toDoList: toDoList, viewStatus: ViewStatus.success);
  }
}
