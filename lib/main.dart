import 'package:chatapp/app/controllers/auth_controller.dart';
import 'package:chatapp/app/utils/error_screen.dart';
import 'package:chatapp/app/utils/loading_screen.dart';
import 'package:chatapp/app/utils/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC5VF5i6ebn83J-RUjA6NFsR_4M65OALcs',
        appId: '1:118720572883:web:7989cce03d70c79764d326',
        messagingSenderId: '118720572883',
        projectId: 'chatapp-rama',
        storageBucket: 'chatapp-rama.appspot.com',
      ),
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorScreen();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: "chat app",
            initialRoute: Routes.PROFILE,
            getPages: AppPages.routes,
          );
          // return FutureBuilder(
          //   future: Future.delayed(
          //     const Duration(seconds: 3),
          //   ),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return Obx(
          //         () => GetMaterialApp(
          //           title: "ChatApp",
          //           initialRoute: authC.isSkipIntro.isTrue
          //               ? authC.isAuth.isTrue
          //                   ? Routes.HOME
          //                   : Routes.LOGIN
          //               : Routes.INTRODUCTION,
          //           getPages: AppPages.routes,
          //         ),
          //       );
          //     }
          //     return const SplashScreen();
          //   },
          // );
        }

        return const LoadingScreen();
      },
    );
  }
}
