import 'package:azan/bloc/cubit.dart';
import 'package:azan/bloc/states.dart';
import 'package:azan/layout/widgets/prayer.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AlahdanCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    cubit.checkInternet();
                  },
                  icon: Icon(Icons.location_on_outlined)),
              IconButton(
                  onPressed: () {
                    cubit.changeAppMode();
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
              listener: (context, state) {
            if (state is AladanPrayerTimeLoadingState) {
              Center(child: CircularProgressIndicator());
            }
          }, builder: (context, state) {
            return ConditionalBuilder(
              condition: true,
              builder: ((context) => ListView(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(14.0), child: prayer()),
                    ],
                  )),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            );
          })),
    );
  }
}
