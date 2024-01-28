import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/user.dart';

class UserCubit extends Cubit<User> {
  UserCubit()
      : super(
          User(
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
