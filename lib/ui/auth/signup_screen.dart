import 'package:flutter/material.dart';
import '../../service_locator.dart';
import '../../theme/my_app_colors.dart';
//UI
import 'login_screen.dart';
import '../../ui/home/home_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/signup-screen';

  final AppColors _appColors = getIt<AppColors>();

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    const double topPadding = 200;
    return SafeArea(
      child: Scaffold(
        backgroundColor: _appColors.loginScaffoldColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: topPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: _theme.textTheme.headline2?.copyWith(
                        color: _appColors.primaryColorLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // enabled: !_authStore.isAuthenticating,
                  // validator: _customValidator.validateName,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter(),
                  // ],
                  // onSaved: (String? val) {
                  //   if (val == null) {
                  //     return;
                  //   }
                  //   _formData['lastName'] = val;
                  // },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // enabled: !_authStore.isAuthenticating,
                  // validator: _customValidator.validateName,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter(),
                  // ],
                  // onSaved: (String? val) {
                  //   if (val == null) {
                  //     return;
                  //   }
                  //   _formData['lastName'] = val;
                  // },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // enabled: !_authStore.isAuthenticating,
                  // validator: _customValidator.validateName,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter(),
                  // ],
                  // onSaved: (String? val) {
                  //   if (val == null) {
                  //     return;
                  //   }
                  //   _formData['lastName'] = val;
                  // },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Phone'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // enabled: !_authStore.isAuthenticating,
                  // validator: _customValidator.validateName,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter(),
                  // ],
                  // onSaved: (String? val) {
                  //   if (val == null) {
                  //     return;
                  //   }
                  //   _formData['lastName'] = val;
                  // },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Address'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // enabled: !_authStore.isAuthenticating,
                  // validator: _customValidator.validateName,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter(),
                  // ],
                  // onSaved: (String? val) {
                  //   if (val == null) {
                  //     return;
                  //   }
                  //   _formData['lastName'] = val;
                  // },
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Password'),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // enabled: !_authStore.isAuthenticating,
                  // validator: _customValidator.validateName,
                  // inputFormatters: [
                  //   UpperCaseTextFormatter(),
                  // ],
                  // onSaved: (String? val) {
                  //   if (val == null) {
                  //     return;
                  //   }
                  //   _formData['lastName'] = val;
                  // },
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Confirm Password'),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          },
                          child: const Text('Register')),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Or',
                  style: _theme.textTheme.headline5,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                        child: const Text('Login'),
                        style: _theme.elevatedButtonTheme.style!.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              _appColors.accentColorLight),
                          foregroundColor: MaterialStateProperty.all(
                              _appColors.primaryTextColor2Light),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
