import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miotonus/src/domain/models/workout_table_row.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/presentation/widgets/workout_form_field_height.dart';
import 'package:miotonus/src/utils/constants/nums.dart';
import 'package:miotonus/src/utils/constants/strings.dart';
import 'package:intl/intl.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  WorkoutTableRowLstCubit workoutTableRowLstCubit = WorkoutTableRowLstCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              formFields(),
              BlocBuilder<WorkoutTableRowLstCubit, List<WorkoutTableRow>>(
                  bloc: workoutTableRowLstCubit,
                  builder: (context, row) {
                    return Column(
                      children: [
                        support(row),
                        Table(
                          border: TableBorder.all(),
                          // columnWidths: const <int, TableColumnWidth>{
                          //   0: IntrinsicColumnWidth(),
                          //   1: FlexColumnWidth(),
                          //   2: FixedColumnWidth(64),
                          // },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[
                            TableRow(
                              children: [
                                _standartTableCell(const Text('id')),
                                _standartTableCell(
                                    const Text(workoutColumnNameTime)),
                                _standartTableCell(
                                    const Text(workoutColumnNameHieghtMin)),
                                _standartTableCell(
                                    const Text(workoutColumnNameHieghtMax)),
                                _standartTableCell(
                                    const Text(workoutColumnNameMusculeTone)),
                              ],
                            ),
                            ...workoutTableRowLstCubit.state
                                .sublist(
                                    0, workoutTableRowLstCubit.state.length - 1)
                                .map((row) => TableRow(
                                      children: [
                                        _standartTableCell(
                                            Text(row.id.toString())),
                                        _standartTableCell(Text(
                                            DateFormat.Hms().format(row.time))),
                                        _standartTableCell(
                                            Text(row.localMin.toString())),
                                        _standartTableCell(
                                            Text(row.localMax.toString())),
                                        _standartTableCell(
                                            Text(row.muscleTone.toString())),
                                      ],
                                    )),
                          ],
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget formFields() {
    // TODO: add controllers for validate max >= min.
    // final minHieghtController = TextEditingController();
    // final maxHieghtController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          workoutFormFieldHeight(
            _formKey,
            workoutFormHintTextMinHeight,
            (value) {
              workoutTableRowLstCubit.state.last.localMin =
                  double.tryParse(value ?? '') ?? 0.0;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: standartEdge)),
          workoutFormFieldHeight(
            _formKey,
            workoutFormHintTextMaxHeight,
            (value) {
              workoutTableRowLstCubit.state.last.localMax =
                  double.tryParse(value ?? '') ?? 0.0;
            },
          ),
          const Padding(padding: EdgeInsets.only(top: standartEdge)),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                workoutTableRowLstCubit.updateState();
              }
            },
            child: const Text(workoutFormTextButtonConfirm),
          ),
          const Padding(padding: EdgeInsets.only(top: standartEdge)),
        ],
      ),
    );
  }

  Widget _standartTableCell(child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Center(child: child),
      ),
    );
  }

  Widget support(List<WorkoutTableRow> rowLst) {
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
          Text(rowLst[rowLst.length - 1].localMin.toString()),
          Text(rowLst[rowLst.length - 1].localMax.toString()),
        ],
      );
    }
  }
}
