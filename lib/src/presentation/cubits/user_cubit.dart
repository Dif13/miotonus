import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/user.dart';

class UserCubit extends Cubit<User> {
  UserCubit()
      : super(
          User(
            id: 0,
            minHieght: 0.0,
            maxHieght: 0.0,
          ),
        );
}
