import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/modal_sheet.dart';

void showModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return ModalSheet();
    },
  );
}