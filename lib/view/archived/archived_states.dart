import 'package:equatable/equatable.dart';
import 'package:to_do_app/enum/states.dart';

class ArchivedStates extends Equatable {
  const ArchivedStates({this.viewStatus = ViewStatus.initial});

  final ViewStatus viewStatus;

  @override
  List<Object?> get props => [viewStatus];

  ArchivedStates copyWith({ViewStatus? viewStatus}) {
    return ArchivedStates(viewStatus: viewStatus ?? this.viewStatus);
  }
}
