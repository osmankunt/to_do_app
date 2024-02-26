import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';

import 'todos_states.dart';

class ToDoViewModel extends Cubit<ToDoStates> {
  ToDoViewModel() : super(ToDoStates());

  static ToDoViewModel get(context) => BlocProvider.of(context);
  DateTime initialDate = DateTime.now();
  List<ToDoModel>? toDoList = [];
  List<int>? keys = [];

  // change state
  changeState({List<ToDoModel>? toDoList, ViewStatus? viewStatus, DateTime? pickedDate}) {
    emit(state.copyWith(toDoList: toDoList, viewStatus: viewStatus, pickedDate: pickedDate));
  }

  datePicker(BuildContext context) {
    changeState(viewStatus: ViewStatus.loading);
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
      changeState(viewStatus: ViewStatus.success, pickedDate: initialDate);
    });
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

  // add new to do to hive box
  submitToDo(ToDoModel toDoModel) async {
    await Hive.openBox<ToDoModel>(Constants.toDoBox).then((todo) => todo.add(toDoModel)).then(
          (value) => getHiveBox(),
        );
  }

  // delete an item from hive box
  deleteToDo(ToDoModel toDoModel) async {
    changeState(viewStatus: ViewStatus.loading);
    final box = Hive.box<ToDoModel>(Constants.toDoBox);

    final Map<dynamic, ToDoModel> toDoMap = box.toMap();
    dynamic desiredKey;
    toDoMap.forEach((key, value) {
      if (value == toDoModel) desiredKey = key;
    });
    box.delete(desiredKey);
    getHiveBox();
    changeState(viewStatus: ViewStatus.success);
  }

  // update item on hive box
  updateToDo(ToDoModel toDoModel) {
    changeState(viewStatus: ViewStatus.loading);
    final box = Hive.box<ToDoModel>(Constants.toDoBox);

    final Map<dynamic, ToDoModel> toDoMap = box.toMap();
    dynamic desiredKey;
    toDoMap.forEach((key, value) {
      if (value.title == toDoModel.title) {
        desiredKey = key;
      }
    });
    box.put(desiredKey, toDoModel);
    getHiveBox();
    changeState(viewStatus: ViewStatus.success);
  }
}
