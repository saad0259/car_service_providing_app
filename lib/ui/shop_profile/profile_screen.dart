import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../custom_utils/connectivity_helper.dart';
import '../../custom_utils/custom_alerts.dart';
import '../../custom_utils/custom_form_helper.dart';
import '../../custom_utils/custom_validator.dart';
import '../../custom_utils/function_response.dart';
import '../../custom_utils/google_maps_helper.dart';
import '../../custom_utils/image_helper.dart';
import '../../custom_widgets/custom_wrappers.dart';
import '../../service_locator.dart';
import '../../stores/manage_service_store.dart';
import '../../stores/profile_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Form
  final _formKey = GlobalKey<FormState>();
  String name = '';

  //Custom Utilities
  final CustomValidator _customValidator = getIt<CustomValidator>();

  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  final CustomAlerts _customAlerts = getIt<CustomAlerts>();

  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();
  final GoogleMapsHelper _googleMapsHelper = getIt<GoogleMapsHelper>();

  //Stores
  final ProfileStore _profileStore = getIt<ProfileStore>();

  @override
  void initState() {
    super.initState();
    _profileStore.changeShopCoverImage(_profileStore.serviceShop.coverImage);
    _profileStore.changeShopAddress(_profileStore.serviceShop.address);
    _profileStore.changeShopLocation(_profileStore.serviceShop.shopLocation);
  }

  //Functions
  Future<void> changeCoverImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        _profileStore.changeShopCoverImage(fResponse.data);
        fResponse.passed(message: 'Uploaded new Image');
      }
      _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to change user Image : $e');
    }
  }

  Future<void> addNewService(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_profileStore.shopCoverImage.isEmpty) {
      fResponse.failed(message: 'Please add a cover image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = _profileStore.updateProfile(name);
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

  Future<void> changeUserLatLng(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      // _customAlerts.showLoaderDialog(context);

      fResponse = _googleMapsHelper.showPlacePicker(context);

      if (fResponse.success) {
        final PickResult pickResult = fResponse.data;
        // fResponse =
        _profileStore.changeShopLocation(LatLng(
            pickResult.geometry!.location.lat,
            pickResult.geometry!.location.lng));
      }
      // _customAlerts.popLoader(context);
    } catch (e) {
      fResponse.failed(message: 'Unable to change user LatLng : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Edit Shop Profile',
                style: theme.textTheme.headline3,
              ),
              const SizedBox(height: 20),
              Card(
                  child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
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
                                    child: buildImage(
                                        theme, _profileStore.shopCoverImage));
                              }),
                            )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        shopNameField(),
                        const SizedBox(height: 20),
                        Observer(builder: (_) {
                          return buildUserInfoDisplay(
                            context,
                            theme,
                            _profileStore.shopLocation.toString(),
                            'User Location',
                            '',
                            onPressed: () {
                              changeUserLatLng(context);
                            },
                          );
                        }),
                        const SizedBox(height: 20),
                        saveButton(context),
                      ]),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget shopNameField() {
    return TextFormField(
      validator: _customValidator.validateNonNullableString,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        name = val;
      },
      // initialValue: _userProfileScreenStore.user.address,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Service Name',
      ),
    );
  }

  //todo: add phone number
  Widget saveButton(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 320,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              await addNewService(context);
            },
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ));
  }
}

Widget buildUserInfoDisplay(BuildContext context, ThemeData theme,
        String getValue, String title, String editPage,
        {VoidCallback? onPressed}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          // const SizedBox(
          //   height: 5.0,
          // ),
          Row(
            children: [
              Expanded(
                child: Text(getValue,
                    style: theme.textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
              ),
              IconButton(
                onPressed: onPressed ??
                    () {
                      Navigator.of(context).pushNamed(editPage);
                    },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
