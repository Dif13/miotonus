import 'package:flutter/material.dart';
import 'package:miotonus/src/presentation/cubits/user_cubit.dart';
import 'package:miotonus/src/presentation/cubits/workout_table_row_lst_cubit.dart';
import 'package:miotonus/src/presentation/pages/workout_page/widgets/workout_form_field_height.dart';
import 'package:miotonus/src/utils/constants/nums.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

Widget workoutFormFields(
  UserCubit userCubit,
  WorkoutTableRowLstCubit workoutTableRowLstCubit,
) {
  final minHieghtController =
      TextEditingController(text: userCubit.state.minHeight.toString());
  final maxHieghtController =
      TextEditingController(text: userCubit.state.maxHeight.toString());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        workoutFormFieldHeight(
          formKey,
          maxHieghtController,
          workoutFormHintTextMaxHeight,
        ),
        const Padding(padding: EdgeInsets.only(top: standartEdge)),
        workoutFormFieldHeight(
          formKey,
          minHieghtController,
          workoutFormHintTextMinHeight,
        ),
        const Padding(padding: EdgeInsets.only(top: standartEdge)),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // TODO: add  validate max >= min.
              workoutTableRowLstCubit.addRowTableState(
                userCubit,
                double.parse(maxHieghtController.text),
                double.parse(minHieghtController.text),
              );
            }
          },
          child: const Text(workoutFormTextButtonConfirm),
        ),
        const Padding(padding: EdgeInsets.only(top: standartEdge)),
      ],
    ),
  );
}
