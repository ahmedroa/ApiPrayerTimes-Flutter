import 'package:azan/bloc/states.dart';
import 'package:azan/constants/constants.dart';
import 'package:azan/models/date_model.dart';
import 'package:azan/models/preyer_time.dart';
import 'package:azan/shared/helper/cachHelper.dart';
import 'package:azan/shared/network/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AlahdanCubit extends Cubit<AlahdanStates> {
  AlahdanCubit() : super(AlahadnInitialState());

  static AlahdanCubit get(context) => BlocProvider.of(context);
  var city = cachHelper.getDate(key: 'city');
  var fajr = cachHelper.getDate(key: 'Fajr');
  var sunrise = cachHelper.getDate(key: 'Sunrise');
  var asr = cachHelper.getDate(key: 'Asr');
  var dhuhr = cachHelper.getDate(key: 'Dhuhr');
  var maghrib = cachHelper.getDate(key: 'Maghrib');
  var sunset = cachHelper.getDate(key: 'Sunset');
  var isha = cachHelper.getDate(key: 'Isha');
  var lat;
  var lang;
  Position? cl;

  bool isDark = false;
  List<Placemark> placemarks = [];
  checkInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      getPermission();
    } else if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: 'تحقق من اتصال الانترنت',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  changeAppMode() {
    isDark = !isDark;
    emit(AppCheanModeState());
  }

  getPermission() async {
    emit(AladanPrayerTimeLoadingState());
    LocationPermission? per;

    late bool services;
    services = await Geolocator.isLocationServiceEnabled();
    print(services);
    if (services == true) {
      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
      } else {
        await getLatAndLong();
      }
    }
    getLatAndLong();
  }

  getLatAndLong() async {
    Fluttertoast.showToast(
      msg: 'جاري تحديث الموقع ...',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      // timeInSecForIosWeb: 1,
      backgroundColor: kTextColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl!.latitude;
    lang = cl!.longitude;
    getcountry();
  }

  var administrativeArea;
  var country;
  getcountry() async {
    placemarks = await placemarkFromCoordinates(cl!.latitude, cl!.longitude);
    country = placemarks[0].country;
    administrativeArea = placemarks[0].administrativeArea;
    cachHelper.saveDate(key: 'city', value: '$country');
    cachHelper.saveDate(
        key: 'administrativeArea', value: '$administrativeArea');
    getData();
  }

  var cityS = cachHelper.getDate(key: 'city');
  var countrS = cachHelper.getDate(key: 'administrativeArea');
  void getData() {
    emit(AladanPrayerTimeLoadingState());
    PrayerTimes? prayerTimes;
    DateModel? dateModel;
    DioHelper.getData(
      url: 'v1/timingsByCity',
      query: {
        'city': '$cityS',
        'country': '$countrS',
      },
    ).then((value) {
      emit(AladanPrayerTimeSuccessState());

      prayerTimes = PrayerTimes.fromJson(value.data['data']['timings']);
      cachHelper.saveDate(
          key: 'Fajr', value: value.data['data']['timings']['Fajr']);
      cachHelper.saveDate(
          key: 'Sunrise', value: value.data['data']['timings']['Sunrise']);
      cachHelper.saveDate(
          key: 'Dhuhr', value: value.data['data']['timings']['Dhuhr']);
      cachHelper.saveDate(
          key: 'Asr', value: value.data['data']['timings']['Asr']);
      cachHelper.saveDate(
          key: 'Maghrib', value: value.data['data']['timings']['Maghrib']);
      cachHelper.saveDate(
          key: 'Sunset', value: value.data['data']['timings']['Sunset']);
      cachHelper.saveDate(
          key: 'Isha', value: value.data['data']['timings']['Isha']);
      Fluttertoast.showToast(
        msg: 'تم تحديد الموقع على ${cityS}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 1,
        backgroundColor: kTextColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }).catchError((error) {
      emit(AladanPrayerTimeErrorState(error));
    });
  }
}
