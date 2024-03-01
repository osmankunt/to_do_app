import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'archived_states.dart';

class ArchivedViewModel extends Cubit<ArchivedStates> {
  ArchivedViewModel() : super(ArchivedStates()) {
    getFilteredList();
  }

  List<ToDoModel>? toDoList = [];
  List<ToDoModel>? filteredList = [];

  // get hive box
  getFilteredList() async {
    toDoList?.clear();
    await getHiveBox();
    emit(state.copyWith(archivedList: toDoList, viewStatus: ViewStatus.loading));
    if (toDoList != null) {
      filteredList?.clear();
      for (var item in toDoList!) {
        if (item.isArchived) {
          filteredList?.add(item);
        }
      }
    }
    emit(state.copyWith(archivedList: filteredList, viewStatus: ViewStatus.success));
  }

  // get hive box
  getHiveBox() async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    var box = await Hive.openBox<ToDoModel>(Constants.toDoBox);
    var keys = [];
    keys = box.keys.cast<int>().toList();
    toDoList = [];
    for (var key in keys) {
      toDoList!.add(box.get(key)!);
    }
    emit(state.copyWith(archivedList: toDoList, viewStatus: ViewStatus.success));
  }

  deleteToDo(ToDoModel toDoModel) async {
    final box = Hive.box<ToDoModel>(Constants.toDoBox);
    final Map<dynamic, ToDoModel> toDoMap = box.toMap();
    dynamic desiredKey;

    toDoMap.forEach((key, value) {
      if (value == toDoModel) {
        desiredKey = key;
      }
    });
    box.delete(desiredKey);
    getFilteredList();
  }
}
