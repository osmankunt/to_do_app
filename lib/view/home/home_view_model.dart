import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/utils/index.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';

class HomeViewModel extends Cubit<HomeViewModelStates> {
  HomeViewModel() : super(const HomeViewModelStates());

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

  submitToDo(String title, String toDoText, DateTime dateTime) {}
}
