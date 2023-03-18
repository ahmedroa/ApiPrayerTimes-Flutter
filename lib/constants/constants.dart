import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF1EFF1);
const kTextColor = Color(0xFF29445d);
const DarkColor = Color.fromARGB(255, 1, 11, 20);

Widget size = SizedBox(
  height: 15,
);
Widget buildPrayerTimes({
  required String time,
  required String prayer,
}) =>
    Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[300],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      prayer,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        size,
      ],
    );
