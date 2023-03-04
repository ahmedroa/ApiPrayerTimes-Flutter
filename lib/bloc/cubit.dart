import 'package:azan/bloc/states.dart';
import 'package:azan/models/date_model.dart';
import 'package:azan/models/preyer_time.dart';
import 'package:azan/shared/network/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlahdanCubit extends Cubit<AlahdanStates> {
  AlahdanCubit() : super(AlahadnInitialState());

  static AlahdanCubit get(context) => BlocProvider.of(context);
  PrayerTimes? prayerTimes;
  DateModel? dateModel;
  bool isDark = false;
  changeAppMode() {
    isDark = !isDark;
    emit(AppCheanModeState());
  }
// LatLng location
  void getData() {
    emit(AladanPrayerTimeLoadingState());
    DioHelper.getData(
      url: 'v1/timingsByCity',
      query: {
        'city': 'SA',
        'country': 'akkah alMuKaramah',
      },
    ).then((value) {
      emit(AladanPrayerTimeSuccessState());
      prayerTimes = PrayerTimes.fromJson(value.data['data']['timings']);
      dateModel = DateModel.fromJson(value.data["data"]["date"]);
    }).catchError((error) {
      emit(AladanPrayerTimeErrorState(error));
      print(error.toString());
    });
    emit(state);
  }
}
