import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/constant/constants.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/utils/index.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';

class HomeViewModel extends Cubit<HomeViewModelStates> {
  HomeViewModel() : super(const HomeViewModelStates());

  static HomeViewModel get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  static Index indexEnum = Index.none;
  DateTime initialDate = DateTime.now();

  void setBottomIndex(int index) {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    indexEnum = IndexUtils.setIndex(index);
    currentIndex = index;
    changeState(viewStatus: ViewStatus.success, index: indexEnum);
  }

  changeState({required ViewStatus viewStatus, Index? index}) {
    emit(state.copyWith(viewStatus: viewStatus, index: index ?? Index.none));
  }

  datePicker(BuildContext context) {
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
      emit(state.copyWith(viewStatus: ViewStatus.add, pickedDate: initialDate));
    });
  }

  List<ToDoModel>? toDoList = [];
  List<int>? keys = [];

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
    //box.close();
    emit(state.copyWith(viewStatus: ViewStatus.success));
  }

  submitToDo(ToDoModel toDoModel) async {
    await Hive.openBox<ToDoModel>(Constants.toDoBox).then((todo) => todo.add(toDoModel)).then(
          (value) => getHiveBox(),
        );
  }

  deleteToDo(ToDoModel toDoModel) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
    final box = Hive.box<ToDoModel>(Constants.toDoBox);

    final Map<dynamic, ToDoModel> toDoMap = box.toMap();
    dynamic desiredKey;
    toDoMap.forEach((key, value) {
      if (value == toDoModel) desiredKey = key;
    });
    box.delete(desiredKey);
    getHiveBox();
    emit(state.copyWith(viewStatus: ViewStatus.success));
  }

  updateToDo(ToDoModel toDoModel) {
    emit(state.copyWith(viewStatus: ViewStatus.loading));
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
    emit(state.copyWith(viewStatus: ViewStatus.success));
  }
}
