

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/Home/presentation/views/modal_sheet.dart';

Future<void> showModalSheet(BuildContext context) async{

  await showModalBottomSheet(

    context: context,
    builder: (context) {
      return ModalSheet();
    },
  );
}