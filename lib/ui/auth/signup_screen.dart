import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../custom_utils/custom_validator.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../custom_widgets/get_location_screen.dart';
import '../../resources/app_images.dart';
import '../../service_locator.dart';
import '../../stores/auth_store.dart';
import '../../theme/my_app_colors.dart';
//UI
import 'login_screen.dart';
import '../../ui/home/home_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  static const routeName = '/signup-screen';

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
  Future<void> changeCoverImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        _authStore.updateCoverImage(fResponse.data);
        fResponse.passed(message: 'Added new Image');
      }
      _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to add cover Image : $e');
    }
  }

  Future<void> getLocation(context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();

      if (fResponse.success) {
        final LatLng? newLocation = await Navigator.of(context)
            .pushNamed(GetLocationScreen.routeName) as LatLng;
        print('recieved : $newLocation');
        if (newLocation != null) {
          _authStore.updateLocation(newLocation);
          print('updated location');
          fResponse.passed(message: 'Location Updated');
        }
      }
    } catch (e) {
      print(e);
    }
    _customAlerts.popLoader(context);

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
  }

  Future<void> signup(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_authStore.newServiceShop.coverImage.isEmpty) {
      fResponse.failed(message: 'Please add a cover image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = _authStore.trySignup();
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
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight * 1.5,
            width: screenWidth,
            child: Stack(
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: screenHeight * 0.35,
                    width: screenWidth,
                    color: _theme.colorScheme.primary,
                    child: Center(
                      child: Image.asset(
                        appLogo,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.20,
                  child: Column(
                    children: [
                      Container(
                        // height: screenHeight,
                        width: screenWidth,
                        padding: const EdgeInsets.all(18.0),
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
                                        'Sign Up',
                                        style: _theme.textTheme.headline2
                                            ?.copyWith(
                                          color: _appColors.primaryColorLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          await changeCoverImage(context);
                                        },
                                        child: Observer(builder: (_) {
                                          return customContainer(
                                              height: 150,
                                              child: _authStore.newServiceShop
                                                      .coverImage.isEmpty
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                          Text(
                                                            'Pick Cover Image',
                                                            style: _theme
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          const Icon(
                                                            Icons.add,
                                                            size: 70,
                                                          )
                                                        ])
                                                  : buildImage(
                                                      _theme,
                                                      _authStore.newServiceShop
                                                          .coverImage));
                                        }),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator:
                                        _customValidator.validateAlphaNmeric,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.updateName(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Name'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator: _customValidator.validateEmail,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.updateEmail(val);
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      label: Text('Email'),
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.updatePassword(val);
                                    },
                                    maxLength: 10,
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Password'),
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    validator: _customValidator.phone,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _authStore.updatePassword(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('+92'),
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Observer(builder: (_) {
                                    return TextFormField(
                                      readOnly: true,
                                      validator:
                                          _customValidator.nonNullableString,
                                      initialValue:
                                          ' ${_authStore.newServiceShop.shopLocation.latitude.toStringAsFixed(5)} ${_authStore.newServiceShop.shopLocation.longitude.toStringAsFixed(5)} ',
                                      decoration: InputDecoration(
                                          label: const Text('Location'),
                                          prefixIcon:
                                              const Icon(Icons.location_on),
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                await getLocation(context);
                                              },
                                              icon: const Icon(
                                                  Icons.map_outlined))),
                                    );
                                  }),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              await signup(context);
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
                                                .pushReplacementNamed(
                                                    SignupScreen.routeName);
                                          },
                                          child: const Text('Login'),
                                          style: _theme
                                              .elevatedButtonTheme.style!
                                              .copyWith(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    _appColors
                                                        .accentColorLight),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    _theme.colorScheme.primary),
                                            side: MaterialStateProperty.all(
                                                BorderSide(
                                                    color:
                                                        _theme.primaryColor)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
