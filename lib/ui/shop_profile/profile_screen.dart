import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../custom_utils/custom_validator.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/google_maps_helper.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../custom_widgets/get_location_screen.dart';
import '../../models/service_shop.dart';
import '../../resources/app_images.dart';
import '../../service_locator.dart';
import '../../stores/profile_store.dart';
import '../../theme/my_app_colors.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile-screen';

  //Form
  final _formKey = GlobalKey<FormState>();
  String name = '';
  final TextEditingController _locationController = TextEditingController();

  //Theme
  final AppColors _appColors = getIt<AppColors>();

  //Custom Utilities
  final CustomValidator _customValidator = getIt<CustomValidator>();

  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  final CustomAlerts _customAlerts = getIt<CustomAlerts>();

  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  //Stores
  final ProfileStore _profileStore = getIt<ProfileStore>();
  // final AuthStore _profileStore = getIt<AuthStore>();

  //Functions
  Future<void> changeCoverImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        _profileStore.updateCoverImage(fResponse.data);
        fResponse.passed(message: 'Uploaded new Image');
      }
      _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to change user Image : $e');
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_profileStore.currentUser.coverImage.isEmpty) {
      fResponse.failed(message: 'Please add a cover image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = await _profileStore.updateProfile();
      }
      _customAlerts.popLoader(context);
    }

    fResponse.printResponse();
    //show snackbar
    _customAlerts.showSnackBar(context, fResponse.message,
        success: fResponse.success);
    if (fResponse.success) {
      //Pop edit screen
      Navigator.of(context).pop();
    }
  }

  Future<void> getLocation(context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();

      if (fResponse.success) {
        final LatLng? newLocation = await Navigator.of(context).pushNamed(
            GetLocationScreen.routeName,
            arguments: {'startLocation': _profileStore.shopLocation}) as LatLng;
        print('recieved : $newLocation');
        if (newLocation != null) {
          _profileStore.updateLocation(newLocation);
          _locationController.text =
              '${_profileStore.shopLocation.latitude.toStringAsFixed(5)},  ${_profileStore.shopLocation.longitude.toStringAsFixed(5)}';
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

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    ServiceShop currentUser = _profileStore.currentUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: _appColors.loginScaffoldColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * 1.5,
            width: screenWidth,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: screenHeight * 0.35,
                    width: screenWidth,
                    color: theme.colorScheme.primary,
                    child: Center(
                      child: Image.asset(
                        appLogo,
                        // height: 100,
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
                                        'Edit Profile',
                                        style:
                                            theme.textTheme.headline2?.copyWith(
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
                                              child: currentUser
                                                      .coverImage.isEmpty
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                          Text(
                                                            'Pick Cover Image',
                                                            style: theme
                                                                .textTheme
                                                                .headline3,
                                                          ),
                                                          const Icon(
                                                            Icons.add,
                                                            size: 70,
                                                          )
                                                        ])
                                                  : buildImage(theme,
                                                      currentUser.coverImage));
                                        }),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: currentUser.name,
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _profileStore.updateName(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Name'),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  TextFormField(
                                    initialValue: currentUser.phone,
                                    validator: _customValidator.phone,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _profileStore.updatePhone(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                      label: Text('+92'),
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    initialValue: currentUser.address,
                                    validator:
                                        _customValidator.nonNullableString,
                                    onSaved: (String? val) {
                                      if (val == null) {
                                        return;
                                      }
                                      _profileStore.updateAddress(val);
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      label: Text('Address'),
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Observer(builder: (_) {
                                    print(
                                        ' observer recieved location :${_profileStore.shopLocation}');
                                    return TextField(
                                      readOnly: true,
                                      controller: _locationController,
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
                                              await updateProfile(context);
                                            },
                                            child: const Text('Update')),
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
