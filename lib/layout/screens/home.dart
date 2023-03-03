import 'package:azan/bloc/cubit.dart';
import 'package:azan/bloc/states.dart';
import 'package:azan/constants/constants.dart';
import 'package:azan/shared/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kBackgroundColor,
      appBar: AppBar(
        // backgroundColor: kBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                AlahdanCubit.get(context).changeAppMode();
              },
              icon: Icon(Icons.brightness_4_outlined)),
        ],
        title: Text(
          'أوقات الصلاة ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            // color: kTextColor,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocProvider(
          create: (BuildContext context) => AlahdanCubit()..getData(),
          child: BlocConsumer<AlahdanCubit, AlahdanStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: prayer(),
                );
              })),
    );
  }
}

class prayer extends StatelessWidget {
  const prayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                fontSize: 34,
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
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.fajr}',
            prayer: 'الفجر'),
        size,
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.sunset}',
            prayer: 'الشروق'),
        size,
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.dhuhr}',
            prayer: 'الظهر'),
        size,
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.asr}',
            prayer: 'العصر'),
        size,
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.sunset}',
            prayer: 'الغروب'),
        size,
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.maghrib}',
            prayer: 'المغرب'),
        size,
        buildPrayerTimes(
            time: '${AlahdanCubit.get(context).prayerTimes?.isha}',
            prayer: 'العشاء'),
      ],
    );
  }
}
