import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

//Theme
import 'service_locator.dart';
import 'theme/light_theme.dart';
//Screens
import 'ui/home/home_screen.dart';
import 'ui/auth/signup_screen.dart';
import 'ui/auth/login_screen.dart';
import 'ui/manage_services/add_service_screen.dart';
import 'ui/service_requests/service_request_list_screen.dart';
import 'ui/shop_profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      routes: {
        '/': (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AddServiceScreen.routeName: (ctx) => AddServiceScreen(),
        ServiceRequestListScreen.routeName: (ctx) => ServiceRequestListScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
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
