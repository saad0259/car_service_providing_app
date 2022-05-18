import 'package:flutter/material.dart';
import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../custom_utils/custom_validator.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../resources/app_images.dart';
import '../../service_locator.dart';
import '../../stores/auth_store.dart';
import '../../theme/my_app_colors.dart';
//UI
import 'signup_screen.dart';
import '../../ui/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';

  final AppColors _appColors = getIt<AppColors>();

  //Form
  final _formKey = GlobalKey<FormState>();

  //Custom Utils
  final CustomValidator _customValidator = getIt<CustomValidator>();
  final CustomAlerts _customAlerts = getIt<CustomAlerts>();
  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  //Stores
  final AuthStore _authStore = getIt<AuthStore>();

  //Functions
  Future<void> tryLogin(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        // fResponse = _authStore.trySignup();
        fResponse.message = 'Login Successfull';
      }
      _customAlerts.popLoader(context);
    }

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Go to Home
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData _theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    const double topPadding = 200;
    return SafeArea(
      child: Scaffold(
        backgroundColor: _appColors.loginScaffoldColor,
        body: Stack(
          children: [
            Container(
              height: screenHeight * 0.35,
              color: _theme.colorScheme.primary,
              child: Center(
                child: Image.asset(
                  appLogo,
                  height: 100,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: screenHeight,
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: customContainer(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const SizedBox(height: topPadding),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: _theme.textTheme.headline2?.copyWith(
                                    color: _appColors.primaryColorLight,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              // enabled: !_authStore.isAuthenticating,
                              validator: _customValidator.nonNullableString,

                              // inputFormatters: [
                              //   UpperCaseTextFormatter(),
                              // ],
                              // onSaved: (String? val) {
                              //   if (val == null) {
                              //     return;
                              //   }
                              //   _formData['lastName'] = val;
                              // },
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              // enabled: !_authStore.isAuthenticating,
                              validator: _customValidator.nonNullableString,
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
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(
                                label: Text('Password'),
                                prefixIcon: Icon(Icons.lock),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await tryLogin(context);
                                      },
                                      child: const Text('Login')),
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
                                          .pushReplacementNamed(
                                              SignupScreen.routeName);
                                    },
                                    child: const Text('Register'),
                                    style: _theme.elevatedButtonTheme.style!
                                        .copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              _appColors.accentColorLight),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              _theme.colorScheme.primary),
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: _theme.primaryColor)),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
