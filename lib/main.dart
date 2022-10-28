import 'dart:io';

import 'package:cloud_tiffin/provider/get_cart_data_provider.dart';
import 'package:cloud_tiffin/provider/new_cart_provider.dart';
import 'package:cloud_tiffin/provider/quick_category_provider.dart';
import 'package:cloud_tiffin/provider/sign_in_provider.dart';
import 'package:cloud_tiffin/provider/theme_provider.dart';
import 'package:cloud_tiffin/screens/Login_Page.dart';
import 'package:cloud_tiffin/screens/bottom_navigation.dart';
import 'package:cloud_tiffin/screens/more_page.dart';
import 'package:cloud_tiffin/screens/new_cart_page.dart';
import 'package:cloud_tiffin/screens/new_home_page.dart';
import 'package:cloud_tiffin/screens/offers_page.dart';
import 'package:cloud_tiffin/screens/otp_verify.dart';
import 'package:cloud_tiffin/screens/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'helper/routes.dart';
import 'provider/Kitchenprovider.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            // apiKey: "AIzaSyBkMxQiJJRT26GWYuTlrXvKRyBJiOwhk_c",
            apiKey: "AIzaSyA8s_IwJpZdcLuMpBAoI5oxNgBmvWYuJbM",
            appId: "1:838547456848:ios:01ccd1e1c96e7e9a872255",
            messagingSenderId: "838547456848",
            projectId: "fir-apps-7f3ea"));
  } else {
    await Firebase.initializeApp();
  }
  //await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // eachFrame()
  //     .take(10)
  //     .transform(const ComputeFps())
  //     .listen(print);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => NewCartProvider()),
          ChangeNotifierProvider(create: (context) => KitchenProvider()),
          ChangeNotifierProvider(create: (context) => QuickProvider()),
          ChangeNotifierProvider(create: (context) => GetCartProvider()),
          ChangeNotifierProvider(create: (context) => SignInProvider())
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, theme, snapshot) {
            return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Food app',
                theme: ThemeData(
                  bottomSheetTheme: BottomSheetThemeData(
                    backgroundColor: Colors.black.withOpacity(0),
                  ),
                ),
                routes: {
                  // MyRoutes.splashPage : (context) => SplashPage(),
                  MyRoutes.BotnavPage: (context) => const BotNav(),
                  MyRoutes.HomePage: (context) => const NewHomePage(),
                  MyRoutes.OffersPage: (context) => const OffersPage(),
                  MyRoutes.MorePage: (context) => const MorePAge(),
                  // MyRoutes.KitchenPage: (context) => KitchenPage(),
                  MyRoutes.LoginPage: (context) => const LoginPage(),
                  MyRoutes.VerifyOtpPage: (context) => const VerifyOtpPage(),
                  MyRoutes.CartListPage: (context) => const NewCartPage(),
                  MyRoutes.SplashPage: (context) => SplashPage(),
                });
          },
        ));
  }
}
