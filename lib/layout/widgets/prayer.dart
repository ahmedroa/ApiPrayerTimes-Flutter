import 'package:azan/bloc/cubit.dart';
import 'package:azan/constants/constants.dart';
import 'package:flutter/material.dart';

class prayer extends StatelessWidget {
  const prayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AlahdanCubit.get(context).prayerTimes;
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
                              "45 : 11",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "3 مارس , الجمعة",
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "11 شبعان 1444هـ",
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
                                  "مكة المكرمة ",
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
        buildPrayerTimes(time: '${cubit?.fajr}', prayer: 'الفجر'),
        size,
        buildPrayerTimes(time: '${cubit?.sunset}', prayer: 'الشروق'),
        size,
        buildPrayerTimes(time: '${cubit?.dhuhr}', prayer: 'الظهر'),
        size,
        buildPrayerTimes(time: '${cubit?.asr}', prayer: 'العصر'),
        size,
        buildPrayerTimes(time: '${cubit?.sunset}', prayer: 'الغروب'),
        size,
        buildPrayerTimes(time: '${cubit?.maghrib}', prayer: 'المغرب'),
        size,
        buildPrayerTimes(time: '${cubit?.isha}', prayer: 'العشاء'),
      ],
    );
  }
}
