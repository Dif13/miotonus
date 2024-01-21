import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';

class WorkoutTableRowLstCubit extends Cubit<List<WorkoutTableRow>> {
  WorkoutTableRowLstCubit()
      : super(
          [
            WorkoutTableRow(
                id: -1,
                time: DateTime.now(),
                localHieghtMin: 0.0,
                localHieghtMax: 0.0,
                muscleTone: 5),
          ],
        );

  void updateState(
    UserCubit userCubit,
    double localHieghtMin,
    double localHieghtMax,
  ) {
    state.last = WorkoutTableRow(
        id: state.last.id,
        time: DateTime.now(),
        localHieghtMin: localHieghtMin,
        localHieghtMax: localHieghtMax,
        muscleTone: state.last.muscleTone);
    //print(localHieghtMin);
    // print(state.last.id);

    emit([...state]);
    state.last.id++;
    state.add(
      WorkoutTableRow(
          id: state.last.id,
          time: DateTime.now(),
          localHieghtMin: state.last.localHieghtMin,
          localHieghtMax: state.last.localHieghtMax,
          muscleTone: 5),
    );
  }
}

/*
Макс. рост
1) нисходящий 1-25
Y = 4,40-0,1*x
2) Восходящий 25 - 50
Y = 2,107 +0,09908*x


Мин рост
1) 1-25
Y = 0,08969*x-0,2243
2) 25-32
Y = 1,818-0,2821*x  
3) 32 - 50
Y = 0,6532+0,2303*x


    1. Зона индивидуальных минимальных и максимальных значений роста (с 1 по 5 градацию);
    2. Зона оптимальных значений тонуса мышц (с 6 по 13 градацию);
    3. Рабочая зона (с 14 по 21 градацию);
    4. Зона резко повышенного тонуса всех скелетных мышц (с 22 по 27 градацию);
    5. Зона "второго дыхания" (с 28 по 36 градацию);
    6. Зона повышенного тонуса (с 37 по 50 градацию) 
*/