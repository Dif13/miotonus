import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

Widget workoutTable(
  UserCubit userCubit,
  WorkoutTableRowLstCubit workoutTableRowLstCubit,
  BoxConstraints constraint,
) {
  return BlocBuilder<WorkoutTableRowLstCubit, List<WorkoutTableRow>>(
      bloc: workoutTableRowLstCubit,
      builder: (context, row) {
        return SizedBox(
          height: constraint.maxHeight * 0.5,
          child: ListView(children: [
            Column(
              children: [
                support(currentAppStateCubit.state.userID, -1, row),
                Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: [
                        standartTableCell(const Text(workoutColumnNameID)),
                        standartTableCell(const Text(workoutColumnNameTime)),
                        standartTableCell(
                            const Text(workoutColumnNameHieghtMin)),
                        standartTableCell(
                            const Text(workoutColumnNameHieghtMax)),
                        standartTableCell(
                            const Text(workoutColumnNameMusculeTone)),
                      ],
                    ),
                    ...workoutTableRowLstCubit.state
                        .sublist(0, workoutTableRowLstCubit.state.length - 1)
                        .reversed
                        .map(
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
      });
}

Widget standartTableCell(child) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      child: Center(child: child),
    ),
  );
}

Widget support(
  int userID,
  int trindID,
  List<WorkoutTableRow> rowLst,
) {
  if (rowLst.isEmpty) {
    return const Column(
      children: [
        Text('EmptyList'),
        Text('EmptyList'),
      ],
    );
  } else {
    return Column(
      children: [
        Text('UserID: $userID'),
        Text('trindID: $userID'),
        Text('maxHieght: ${rowLst[max(rowLst.length - 2, 0)].localMaxHeight}'),
        Text('minHieght: ${rowLst[max(rowLst.length - 2, 0)].localMinHeight}'),
      ],
    );
  }
}
