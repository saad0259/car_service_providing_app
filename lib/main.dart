import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

//Theme
import 'service_locator.dart';
import 'theme/light_theme.dart';
//Screens
import 'custom_widgets/get_location_screen.dart';
import 'ui/home/home_screen.dart';
import 'ui/auth/signup_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/manage_services/add_service_screen.dart';
import 'ui/service_requests/service_request_details_screen.dart';
import 'ui/service_requests/service_request_list_screen.dart';
import 'ui/shop_profile/profile_screen.dart';
import './constants/firebase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();

  _setupLogging();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => HomeScreen()),
      home: StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (ctx, userSnapshot) {
          print('user found');
          if (userSnapshot.hasData) {
            return HomeScreen();
          }
          print('user lost');

          return LoginScreen();
        },
      ),
      routes: {
        // '/': (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AddServiceScreen.routeName: (ctx) => AddServiceScreen(),
        ServiceRequestListScreen.routeName: (ctx) => ServiceRequestListScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        GetLocationScreen.routeName: (ctx) => GetLocationScreen(),
        ServiceRequestDetailsScreen.routeName: (ctx) =>
            ServiceRequestDetailsScreen(),
      },
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
