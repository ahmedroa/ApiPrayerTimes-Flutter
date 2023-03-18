import 'package:azan/bloc/cubit.dart';
import 'package:azan/bloc/states.dart';
import 'package:azan/layout/widgets/prayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    AlahdanCubit.get(context).getPermission();
                  },
                  icon: Icon(Icons.location_on_outlined)),
              IconButton(
                  onPressed: () async {
                    AlahdanCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
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
                return ListView(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(14.0), child: prayer()),
                  ],
                );
              })),
    );
  }
}
