import 'package:miotonus/src/domain/models/workout_table_row.dart';

class Workout {
  int id;
  List<WorkoutTableRow> workoutTable;

  Workout({
    required this.id,
    required this.workoutTable,
  });
}
