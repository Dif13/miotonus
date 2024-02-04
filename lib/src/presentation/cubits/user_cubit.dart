import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/profile.dart';

class UserCubit extends Cubit<Profile> {
  UserCubit()
      : super(
          Profile(
            id: 0,
            maxHeight: 184.4,
            minHeight: 180.0,
          ),
        );

  void updateUserHeight(
    double maxHeight,
    double minHeight,
  ) {
    state.maxHeight = maxHeight;
    state.minHeight = minHeight;
    emit(state);
  }
}
