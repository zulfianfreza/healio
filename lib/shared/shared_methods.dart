import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:healio/shared/theme.dart';
import 'package:health/health.dart';

int getValueFromHealthValue(HealthValue healthValue) {
  List<String> value = healthValue.toString().split('.');
  return int.parse(value[0]);
}

void customShowSnackBar(BuildContext context, String message) {
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    backgroundColor: kRedColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String setCategory(
  int value,
  String category,
  int age,
) {
  String label = "";

  if (category == 'heart_rate') {
    if (age <= 1) {
      if (value < 70) {
        label = 'rendah';
      } else if (value >= 70 && value < 190) {
        label = 'normal';
      } else {
        label = 'tinggi';
      }
    } else if (age > 1 && age <= 10) {
      if (value < 80) {
        label = 'rendah';
      } else if (value >= 80 && value < 110) {
        label = 'normal';
      } else {
        label = 'tinggi';
      }
    } else if (age > 10) {
      if (value < 60) {
        label = 'rendah';
      } else if (value >= 60 && value < 100) {
        label = 'normal';
      } else {
        label = 'tinggi';
      }
    }
  } else if (category == 'blood_oxygen') {
    if (value < 95) {
      label = 'rendah';
    } else {
      label = 'normal';
    }
  }

  return label;
}

calculateAge(DateTime dateOfBirth) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - dateOfBirth.year;
  int month1 = currentDate.month;
  int month2 = dateOfBirth.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = dateOfBirth.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
