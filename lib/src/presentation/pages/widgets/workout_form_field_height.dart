import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

Widget workoutFormFieldHeight(
  GlobalKey myFormKey,
  TextEditingController controller,
  String myHintText,
) {
  return TextFormField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
    ],
    decoration: InputDecoration(
      hintText: myHintText,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return workoutFormTextValidatorEmpty;
      }
      return null;
    },
  );
}
