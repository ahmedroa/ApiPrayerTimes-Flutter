import 'package:azan/bloc/cubit.dart';
import 'package:azan/constants/constants.dart';
import 'package:flutter/material.dart';

class prayer extends StatelessWidget {
  const prayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AlahdanCubit.get(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[300],
          ),
          // color: Colors.green[100],
          width: double.infinity,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "10 : 9",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "4 مارس , الجمعة",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "12 شبعان 1444هـ",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: kTextColor,
                                ),
                                Text(
                                  "${AlahdanCubit.get(context).city}",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        size,
        buildPrayerTimes(time: '${cubit.fajr}', prayer: 'الفجر'),
        buildPrayerTimes(time: '${cubit.sunrise}', prayer: 'الشروق'),
        buildPrayerTimes(time: '${cubit.dhuhr}', prayer: 'الظهر'),
        buildPrayerTimes(time: '${cubit.asr}', prayer: 'العصر'),
        buildPrayerTimes(time: '${cubit.sunset}', prayer: 'الغروب'),
        buildPrayerTimes(time: '${cubit.maghrib}', prayer: 'المغرب'),
        buildPrayerTimes(time: '${cubit.isha}', prayer: 'العشاء'),
      ],
    );
  }
}
