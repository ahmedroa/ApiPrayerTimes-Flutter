import 'package:azan/bloc/cubit.dart';
import 'package:azan/bloc/states.dart';
import 'package:azan/constants/constants.dart';
import 'package:azan/layout/widgets/prayer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                AlahdanCubit.get(context).changeAppMode();
              },
              icon: Icon(Icons.brightness_4_outlined)),
        ],
        title: Text(
          'أوقات الصلاة ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: BlocProvider(
          create: (BuildContext context) => AlahdanCubit()..getPermission(),
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
