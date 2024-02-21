import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/index.dart';
import 'package:to_do_app/enum/states.dart';

class HomeViewModelStates extends Equatable {
  const HomeViewModelStates({this.viewStatus = ViewStatus.initial, this.index = Index.all, this.pickedDate});

  final ViewStatus viewStatus;
  final Index? index;
  final DateTime? pickedDate;

  @override
  List<Object?> get props => [viewStatus, index, pickedDate];

  HomeViewModelStates copyWith({ViewStatus? viewStatus, Index? index, DateTime? pickedDate}) {
    return HomeViewModelStates(
        viewStatus: viewStatus ?? this.viewStatus, index: index ?? this.index, pickedDate: pickedDate ?? this.pickedDate);
  }
}
