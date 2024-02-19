import 'package:flutter/material.dart';

Future<DateTime> selectDate(BuildContext context,DateTime selectedDate) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101));
  if (picked != null ) {
      return picked;
  }
  return DateTime.now();
}