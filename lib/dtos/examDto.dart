import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamDto{
  String subject;
  DateTime date;
  TimeOfDay time;

  ExamDto(this.subject, this.date, this.time);

  String getDateFormatted() => DateFormat("dd-mm-yyyy").format(date);

  String getFormattedTime() => "${time.hour}:${time.minute}";
}