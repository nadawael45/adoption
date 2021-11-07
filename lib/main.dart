import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petsadoption/Views/Screens/Sign_up.dart';
import 'package:petsadoption/Views/Screens/all_animals_screen.dart';
import 'package:petsadoption/Views/Screens/cereate_pet_profile.dart';
import 'package:petsadoption/Views/Screens/forget_passworg.dart';
import 'package:petsadoption/Views/Screens/home_screen.dart';
import 'package:petsadoption/Views/Screens/login.dart';
import 'package:petsadoption/Views/Screens/splash_screen.dart';
import 'package:petsadoption/constants.dart';
import 'package:provider/provider.dart';
import 'Views/Screens/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Views/Screens/pet_details.dart';
import 'controller/provider/langProv.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      path: 'languages', // <-- change the path of the translation files
      fallbackLocale: Locale('en', ''),
      child: MultiProvider
        (
          providers: [

            ChangeNotifierProvider(create: (context)=>LangProv())
          ],
          child: MyApp())));
}

class MyApp extends StatelessWidget {

   MaterialColor kPrimaryColor = const MaterialColor(
     0xFFFF877F,
    const <int, Color>{
      50:  const Color(0xFFFF877F),
      100: const Color(0xFFFF877F),
      200: const Color(0xFFFF877F),
      300:  const Color(0xFFFF877F),
      400: const Color(0xFFFF877F),
      500: const Color(0xFFFF877F),
      600: const Color(0xFFFF877F),
      700: const Color(0xFFFF877F),
      800: const Color(0xFFFF877F),
      900: const Color(0xFFFF877F),
    },
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      builder: () => MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: kPrimaryColor,

        ),
        home: SplashScreen(),
        routes: {
          SignUp.id: (context) => SignUp(),
          OnBoardingScreen.id: (context) => OnBoardingScreen(),
          Login.id: (context) => Login(),
          ForgotPass.id: (context) => ForgotPass(),
          HomePage.id: (context) => HomePage(),
          AllAnimals.id: (context) => AllAnimals(),
          CreatePetProfile.id: (context) => CreatePetProfile(),


        },
      ),
    );
  }
}
