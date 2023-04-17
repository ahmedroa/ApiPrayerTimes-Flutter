import 'package:azan/bloc/states.dart';
import 'package:azan/constants/constants.dart';
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
  var city = CachHelper.getDate(key: 'city');
  var fajr = CachHelper.getDate(key: 'Fajr');
  var sunrise = CachHelper.getDate(key: 'Sunrise');
  var asr = CachHelper.getDate(key: 'Asr');
  var dhuhr = CachHelper.getDate(key: 'Dhuhr');
  var maghrib = CachHelper.getDate(key: 'Maghrib');
  var sunset = CachHelper.getDate(key: 'Sunset');
  var isha = CachHelper.getDate(key: 'Isha');
  var lat;
  var lang;
  Position? cl;

  bool isDark = false;
  List<Placemark> placemarks = [];
  checkInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      await getPermission();
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
      if (per == LocationPermission.always) {
        per = await getLatAndLong();
      }
      if (per == LocationPermission.whileInUse) {
        per = await getLatAndLong();
      }
    }
    await getLatAndLong();
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
    await getcountry();
  }

  var administrativeArea;
  var country;
  getcountry() async {
    placemarks = await placemarkFromCoordinates(cl!.latitude, cl!.longitude);
    country = placemarks[0].country;
    administrativeArea = placemarks[0].administrativeArea;
    CachHelper.saveDate(key: 'city', value: '$country');
    CachHelper.saveDate(
        key: 'administrativeArea', value: '$administrativeArea');
    await getData();
  }

  var cityS;
  var countrS;
  PrayerTimes? prayerTimes;

  getData() async {
    var city = CachHelper.getDate(key: 'city');
    var countrS = CachHelper.getDate(key: 'administrativeArea');
    print(city);
    print('========================');
    print(countrS);
    emit(AladanPrayerTimeLoadingState());

    await DioHelper.getData(
      url: 'v1/timingsByCity',
      query: {
        'city': '$city',
        'country': '$countrS',
      },
    ).then((value) {
      emit(AladanPrayerTimeSuccessState());

      prayerTimes = PrayerTimes.fromJson(value.data['data']['timings']);
      CachHelper.saveDate(
          key: 'Fajr', value: value.data['data']['timings']['Fajr']);
      CachHelper.saveDate(
          key: 'Sunrise', value: value.data['data']['timings']['Sunrise']);
      CachHelper.saveDate(
          key: 'Dhuhr', value: value.data['data']['timings']['Dhuhr']);
      CachHelper.saveDate(
          key: 'Asr', value: value.data['data']['timings']['Asr']);
      CachHelper.saveDate(
          key: 'Maghrib', value: value.data['data']['timings']['Maghrib']);
      CachHelper.saveDate(
          key: 'Sunset', value: value.data['data']['timings']['Sunset']);
      CachHelper.saveDate(
          key: 'Isha', value: value.data['data']['timings']['Isha']);
      Fluttertoast.showToast(
        msg: 'تم تحديد الموقع على $city',
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
