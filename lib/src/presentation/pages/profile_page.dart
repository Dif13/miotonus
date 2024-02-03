import 'package:flutter/material.dart';
import 'package:miotonus/src/config/router.dart';
import 'package:miotonus/src/presentation/pages/widgets/workout_form_field_height.dart';
import 'package:miotonus/src/utils/constants/nums.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final minHieghtController =
      TextEditingController(text: userCubit.state.minHeight.toString());
  final maxHieghtController =
      TextEditingController(text: userCubit.state.maxHeight.toString());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(profileTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
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
                        // TODO: add  validate max >= min. and Max != min
                        userCubit.updateUserHeight(
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
            )
          ],
        ),
      ),
    );
  }
}
