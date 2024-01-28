import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';
import 'package:miotonus/src/presentation/pages/widgets/workout_table.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class DetailWorkoutPage extends StatefulWidget {
  const DetailWorkoutPage({super.key});

  @override
  State<DetailWorkoutPage> createState() => _DetailWorkoutPageState();
}

class _DetailWorkoutPageState extends State<DetailWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    int userID = currentAppStateCubit.state.userID;
    int tappedWorkoutID = currentAppStateCubit.state.tappedWorkoutID;
    print(tappedWorkoutID);
    List<WorkoutTableRow> rowLst =
        workoutHistoryLstCubit.state[tappedWorkoutID].workoutTable;
    // print(rowLst[1].id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали тренировки'),
      ),
      body: ListView(children: [
        Column(
          children: [
            support(
              userID,
              tappedWorkoutID,
              workoutHistoryLstCubit
                  .state[currentAppStateCubit.state.tappedWorkoutID]
                  .workoutTable,
            ),
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: [
                    standartTableCell(const Text(workoutColumnNameID)),
                    standartTableCell(const Text(workoutColumnNameTime)),
                    standartTableCell(const Text(workoutColumnNameHieghtMin)),
                    standartTableCell(const Text(workoutColumnNameHieghtMax)),
                    standartTableCell(const Text(workoutColumnNameMusculeTone)),
                  ],
                ),
                ...rowLst.sublist(0, rowLst.length).reversed.map(
                      //! Было -1, но когда выстаскиваешь из памяти, то пустой элемент не сохраняется.
                      (row) => TableRow(
                        children: [
                          standartTableCell(Text(row.id.toString())),
                          standartTableCell(
                              Text(DateFormat.Hms().format(row.time))),
                          standartTableCell(
                              Text(row.localMinHeight.toString())),
                          standartTableCell(
                              Text(row.localMaxHeight.toString())),
                          standartTableCell(
                            Text(
                                'Тонус ↑: ${row.muscleToneMaxHeight}\nТонус ↓: ${row.muscleToneMinHeight}'),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
