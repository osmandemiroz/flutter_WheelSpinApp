import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carkuygulamasi/constants/constants.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WheelSpinApp',
      home: const MainScreen(),
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 233, 233, 233),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          )),
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              toolbarHeight: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60))))),
      debugShowCheckedModeBanner: false,
    );
  }
}
