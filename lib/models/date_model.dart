import 'package:flutter/material.dart';

class DateModel {
  final String readable;
  final String dayHijri;
  final String monthHijri;
  final String yearHijri;
  DateModel({
    required this.readable,
    required this.dayHijri,
    required this.monthHijri,
    required this.yearHijri,
  });
  //from json
  factory DateModel.fromJson(Map<String, dynamic> json) {
    return DateModel(
      readable: json['readable'],
      dayHijri: json['hijri']['day'],
      monthHijri: json['hijri']['month']['en'],
      yearHijri: json['hijri']['year'],
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      'readable': readable,
      'day_hijri': dayHijri,
      'month_hijri': monthHijri,
      'year_hijri': yearHijri,
    };
  }
}
