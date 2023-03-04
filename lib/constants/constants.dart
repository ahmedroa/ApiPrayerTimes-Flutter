import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF219ebc);
const kSecondaryColor = Color(0xFFfcca46);
const kTextColor = Color(0xFF29445d);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xff4c53a5);
const DarkColor = Color(0xff051736);

const kDefaultPadding = 20.0;
Widget size = SizedBox(
  height: 15,
);
Widget buildPrayerTimes({
  required String time,
  required String prayer,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
      ),
    );
