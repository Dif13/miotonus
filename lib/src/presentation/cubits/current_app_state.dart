import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/current_app_state.dart';

class CurrentAppStateCubit extends Cubit<CurrentAppState> {
  CurrentAppStateCubit(int userID)
      : super(
          CurrentAppState(
            userID: userID,
            tappedWorkoutID: -1,
          ),
        );
}
