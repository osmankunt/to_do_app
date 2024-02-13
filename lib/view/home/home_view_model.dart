import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';
import 'package:to_do_app/view/home/home_view_model_states.dart';
import 'package:to_do_app/view/todos/todos_view.dart';

class HomeViewModel extends Cubit<HomeViewModelStates> {
  HomeViewModel() : super(const HomeViewModelStates());

  static HomeViewModel get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void setBottomIndex(int index) {
    emit(state.copyWith(viewStatus: ViewStatus.initial));
    currentIndex = index;
    emit(state.copyWith(viewStatus: ViewStatus.success));
  }

  changeState() {}

  Index setIndex(int index) {
    switch (index) {
      case 0:
        return Index.all;
      case 1:
        return Index.done;
      case 2:
        return Index.active;
      default:
        return Index.all;
    }
  }

  int getIndex(Index index) {
    switch (index) {
      case Index.all:
        return 0;
      case Index.done:
        return 1;
      case Index.active:
        return 2;
      default:
        return 0;
    }
  }
}
