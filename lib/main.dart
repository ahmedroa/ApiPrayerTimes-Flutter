import 'package:azan/bloc/cubit.dart';
import 'package:azan/bloc/states.dart';
import 'package:azan/constants/constants.dart';
import 'package:azan/layout/screens/home.dart';
import 'package:azan/shared/bloc_observer.dart';
import 'package:azan/shared/helper/cachHelper.dart';
import 'package:azan/shared/network/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cachHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.inIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AlahdanCubit(),
      child: BlocConsumer<AlahdanCubit, AlahdanStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              localizationsDelegates: [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [Locale("ar", "AE")],
              locale: Locale("ar", "AE"),
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: DarkColor,
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.white),
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xff6a737b),
                        statusBarIconBrightness: Brightness.light,
                      ),
                      backgroundColor: DarkColor,
                      elevation: 0.0,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed, elevation: 20.0)),
              theme: ThemeData(
                scaffoldBackgroundColor: kBackgroundColor,
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: kTextColor),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: kBackgroundColor,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: kBackgroundColor,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              themeMode: AlahdanCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: home(),
            );
          }),
    );
  }
}
