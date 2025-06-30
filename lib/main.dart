import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oneup_noobs/Admin/addgames.dart';
import 'package:oneup_noobs/Admin/addkills.dart';
import 'package:oneup_noobs/Admin/addmatches.dart';
import 'package:oneup_noobs/Auth/login.dart';
import 'package:oneup_noobs/Pages/Account/accountpage.dart';
import 'package:oneup_noobs/Pages/Leaderboard/leaderboard.dart';
import 'package:oneup_noobs/Pages/ReferalSystem/myreferal.dart';
import 'package:oneup_noobs/Pages/Wallet/mywallet.dart';
import 'package:oneup_noobs/Pages/Wallet/paymentgateway.dart';
import 'package:oneup_noobs/Pages/Wallet/transaction_history.dart';
import 'package:oneup_noobs/Pages/homepage.dart';
import 'package:oneup_noobs/Pages/joiningmatch.dart';
import 'package:oneup_noobs/Pages/mainpage.dart';
import 'package:oneup_noobs/Pages/tournament_details.dart';
import 'package:oneup_noobs/Pages/tournament_page.dart';
import 'package:oneup_noobs/Splashscreen/splashscreen.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Oneup Noobs',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.bluecolor),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
