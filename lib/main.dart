import 'package:azan/bloc/cubit.dart';
import 'package:azan/bloc/states.dart';
import 'package:azan/constants/constants.dart';
import 'package:azan/layout/screens/home.dart';
import 'package:azan/shared/bloc_observer.dart';
import 'package:azan/shared/helper/cachHelper.dart';
import 'package:azan/shared/network/dio.dart';
import 'package:azan/themes/app_theme.dart';
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
      create: (BuildContext context) => AlahdanCubit()..getPermission(),
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
              darkTheme: darkTheme,
              theme: lightTheme,
              themeMode: AlahdanCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: Home(),
            );
          }),
    );
  }
}
