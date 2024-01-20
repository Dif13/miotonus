import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miotonus/src/utils/constants/strings.dart';

Widget workoutFormFieldHeight(
    GlobalKey myFormKey, String myHintText, Function(String?) callback) {
  return TextFormField(
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
    ],
    onChanged: callback,
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
