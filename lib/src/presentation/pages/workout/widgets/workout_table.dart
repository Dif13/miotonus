import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                support(userCubit, row),
                Table(
                  border: TableBorder.all(),
                  // columnWidths: const <int, TableColumnWidth>{
                  //   0: IntrinsicColumnWidth(),
                  //   1: FlexColumnWidth(),
                  //   2: FixedColumnWidth(64),
                  // },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: [
                        _standartTableCell(const Text('id')), //TODO: fix this
                        _standartTableCell(const Text(workoutColumnNameTime)),
                        _standartTableCell(
                            const Text(workoutColumnNameHieghtMin)),
                        _standartTableCell(
                            const Text(workoutColumnNameHieghtMax)),
                        _standartTableCell(
                            const Text(workoutColumnNameMusculeTone)),
                      ],
                    ),
                    ...workoutTableRowLstCubit.state
                        .sublist(0, workoutTableRowLstCubit.state.length - 1)
                        .reversed
                        .map(
                          (row) => TableRow(
                            children: [
                              _standartTableCell(Text(row.id.toString())),
                              _standartTableCell(
                                  Text(DateFormat.Hms().format(row.time))),
                              _standartTableCell(
                                  Text(row.localMinHeight.toString())),
                              _standartTableCell(
                                  Text(row.localMaxHeight.toString())),
                              _standartTableCell(
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

Widget _standartTableCell(child) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      child: Center(child: child),
    ),
  );
}

Widget support(
  UserCubit userCubit,
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
        Text('UserID: ${userCubit.state.id}'),
        Text('maxHieght: ${rowLst[max(rowLst.length - 2, 0)].localMaxHeight}'),
        Text('minHieght: ${rowLst[max(rowLst.length - 2, 0)].localMinHeight}'),
      ],
    );
  }
}
