import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodehash_assignment/config/route.dart';
import 'package:kodehash_assignment/firebase_options.dart';

Future<void> main() async {
  ///This will enable full screen for whole project
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kodehash Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Routes.getRoute(),
      initialRoute: Routes.loginRoute,
    );
  }
}
