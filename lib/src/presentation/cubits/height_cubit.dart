import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/hieght_class.dart';

class HeightCubit extends Cubit<Height> {
  HeightCubit() : super(Height(localMin: 0.0, localMax: 0.0));

  void update_state() {
    emit(Height(localMin: state.localMin, localMax: state.localMax));
  }
}
