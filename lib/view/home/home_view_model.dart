import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/utils/index.dart';
import 'package:to_do_app/view/home/home_states.dart';

class HomeViewModel extends Cubit<HomeViewModelStates> {
  HomeViewModel() : super(const HomeViewModelStates()) {
    getHiveBox();
  }

  int currentIndex = 0;
  static Index indexEnum = Index.none;
  DateTime initialDate = DateTime.now();
  List<ToDoModel>? toDoList = [];
  List<int>? keys = [];

  // set bottom navigation bar index
  void setBottomIndex(int index) {
    changeState(viewStatus: ViewStatus.loading);
    indexEnum = IndexUtils.setIndex(index);
    currentIndex = index;
    changeState(viewStatus: ViewStatus.success, index: indexEnum);
  }

  // change state
  changeState({List<ToDoModel>? toDoList, ViewStatus? viewStatus, Index? index, DateTime? pickedDate}) {
    emit(state.copyWith(toDosList: toDoList, viewStatus: viewStatus, index: index ?? Index.none, pickedDate: pickedDate));
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
