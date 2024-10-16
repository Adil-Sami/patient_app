import 'package:flutter/material.dart';

class IDatePicker {

  static Future datePicker(BuildContext context) async {
    DateTime _selectedDate = DateTime.now();
    String date = "";
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate, // Refer step 1
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      print(picked.day);
        String month=picked.month>9?picked.month.toString():"0"+picked.month.toString();
      String day=picked.day>9?picked.day.toString():"0"+picked.day.toString();
      date = "${picked.year}-${month}-${day}";
    }

    return date;
  }
}