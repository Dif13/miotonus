class WorkoutTableRow {
  int id;
  DateTime time;
  double localMin, localMax, muscleTone;
  WorkoutTableRow({
    required this.id,
    required this.time,
    required this.localMin,
    required this.localMax,
    required this.muscleTone,
  });
}
