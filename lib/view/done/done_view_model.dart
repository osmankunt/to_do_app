import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'done_states.dart';

class DoneViewModel extends Cubit<DoneStates> {
  DoneViewModel() : super(DoneStates()) {
    getFilteredList();
  }

  getFilteredList() async {
    toDoList?.clear();
    await getHiveBox();
    emit(state.copyWith(doneList: toDoList, viewStatus: ViewStatus.loading));
    if (toDoList != null) {
      filteredList?.clear();
      for (var item in toDoList!) {
        if (item.isDone) {
          filteredList?.add(item);
        }
      }
    }
    emit(state.copyWith(doneList: filteredList, viewStatus: ViewStatus.success));
  }

  List<ToDoModel>? toDoList = [];
  List<ToDoModel>? filteredList = [];

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
    emit(state.copyWith(doneList: toDoList, viewStatus: ViewStatus.success));
  }

  // update item on hive box
  updateToDo(ToDoModel toDoModel) async {
    final box = Hive.box<ToDoModel>(Constants.toDoBox);

    final Map<dynamic, ToDoModel> toDoMap = box.toMap();
    dynamic desiredKey;
    toDoMap.forEach((key, value) {
      if (value.title == toDoModel.title) {
        desiredKey = key;
      }
    });
    box.put(desiredKey, toDoModel);
    await getFilteredList();
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
    await getFilteredList();
  }
}
