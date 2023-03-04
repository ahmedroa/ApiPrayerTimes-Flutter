import 'package:azan/bloc/states.dart';
import 'package:azan/models/date_model.dart';
import 'package:azan/models/preyer_time.dart';
import 'package:azan/shared/network/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AlahdanCubit extends Cubit<AlahdanStates> {
  AlahdanCubit() : super(AlahadnInitialState());

  static AlahdanCubit get(context) => BlocProvider.of(context);
  var administrativeArea;

  var country;
  var district;
  var lat;
  var lang;

  Position? cl;
  LocationPermission? per;
  PrayerTimes? prayerTimes;
  DateModel? dateModel;
  bool isDark = false;
  List<Placemark> placemarks = [];
  changeAppMode() {
    isDark = !isDark;
    emit(AppCheanModeState());
  }

  getPermission() async {
    late bool services;
    services = await Geolocator.isLocationServiceEnabled();
    print(services);
    if (services == true) {
      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
      } else {
        getLatAndLong();
      }
    }
  }

  getLatAndLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    lang = cl!.longitude;

    print(lat);
    print(lang);
    getcountry();
  }

  getcountry() async {
    placemarks = await placemarkFromCoordinates(cl!.latitude, cl!.longitude);
    district = placemarks[0].locality;
    country = placemarks[0].country;
    administrativeArea = placemarks[0].administrativeArea;
    print(country);
    print(administrativeArea);
    print(district);
    getData();
  }

// LatLng location
  void getData() {
    emit(AladanPrayerTimeLoadingState());
    DioHelper.getData(
      url: 'v1/timingsByCity',
      query: {
        'city': '$country',
        'country': '$administrativeArea',
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
