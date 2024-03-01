import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

import 'todos_states.dart';

class ToDoViewModel extends Cubit<ToDoStates> {
  ToDoViewModel() : super(ToDoStates()) {
    getFilteredList();
  }

  DateTime initialDate = DateTime.now();
  List<ToDoModel>? toDoList = [];
  List<ToDoModel>? filteredList = [];
  List<int>? keys = [];

  datePicker(BuildContext context) {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    showDatePicker(
      context: context,
      currentDate: initialDate,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value != null) {
        initialDate = value;
      }
      emit(state.copyWith(viewStatus: ViewStatus.success, pickedDate: initialDate));
    });
  }

  getFilteredList() async {
    toDoList?.clear();
    await getHiveBox();
    emit(state.copyWith(toDoList: toDoList, viewStatus: ViewStatus.loading));
    if (toDoList != null) {
      filteredList?.clear();
      for (var item in toDoList!) {
        if (!item.isArchived && !item.isDone) {
          filteredList?.add(item);
        }
      }
    }
    emit(state.copyWith(toDoList: filteredList, viewStatus: ViewStatus.success));
  }

  // get hive box
  getHiveBox() async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    var box = await Hive.openBox<ToDoModel>(Constants.toDoBox);

    // Empty the HiveBox
    //box.deleteFromDisk();
    var keys = [];
    keys = box.keys.cast<int>().toList();
    toDoList = [];
    for (var key in keys) {
      toDoList!.add(box.get(key)!);
    }
    emit(state.copyWith(toDoList: toDoList, viewStatus: ViewStatus.success));
  }

  // add new to do to hive box
  submitToDo(ToDoModel toDoModel) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    await Hive.openBox<ToDoModel>(Constants.toDoBox).then((todo) => todo.add(toDoModel)).then(
          (value) => getHiveBox(),
        );
    await getFilteredList();
  }

  // delete an item from hive box
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
}
