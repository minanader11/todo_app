

import 'package:flutter/material.dart';
import 'package:todo_app/features/Home/presentation/views/modal_sheet.dart';

Future<void> showModalSheet(BuildContext context,Widget widget) async{

  await showModalBottomSheet(

    context: context,
    builder: (context) {
      return widget;
    },
  );
}