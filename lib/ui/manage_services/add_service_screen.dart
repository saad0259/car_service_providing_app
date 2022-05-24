import 'package:car_service_providing_app/custom_widgets/custom_wrappers.dart';
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
import '../../models/service_shop.dart';
import '../../models/vehicle.dart';
import '../../models/vehicle_service.dart';
import '../../service_locator.dart';
import '../../stores/manage_service_store.dart';
import '../../stores/profile_store.dart';

class AddServiceScreen extends StatefulWidget {
  AddServiceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-service-screen';

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  //Form
  final _formKey = GlobalKey<FormState>();

  //Custom Utilities
  final CustomValidator _customValidator = getIt<CustomValidator>();

  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  final CustomAlerts _customAlerts = getIt<CustomAlerts>();

  final ConnectivityHelper _connectivityHelper = getIt<ConnectivityHelper>();

  final CustomImageHelper _customImageHelper = getIt<CustomImageHelper>();

  //Stores
  final ManageServiceStore _manageServiceStore = getIt<ManageServiceStore>();

  final ProfileStore _profileStore = getIt<ProfileStore>();

  @override
  void initState() {
    super.initState();
    _manageServiceStore.changeCoverImage('');
  }

  //Functions
  Future<void> changeCoverImage(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    try {
      _customAlerts.showLoaderDialog(context);

      fResponse = await _customImageHelper.pickUserImage(context);

      if (fResponse.success) {
        _manageServiceStore.changeCoverImage(fResponse.data);
        fResponse.passed(message: 'Uploaded new Image');
      }
    } catch (e) {
      fResponse.failed(message: 'Unable to change user Image : $e');
    }
    _customAlerts.popLoader(context);
  }

  Future<void> addNewService(BuildContext context) async {
    FunctionResponse fResponse = getIt<FunctionResponse>();

    if (!_formKey.currentState!.validate()) {
      fResponse.failed(message: 'Please enter valid inputs');
    } else if (_manageServiceStore.newVehicleService.coverImage.isEmpty) {
      fResponse.failed(message: 'Please add a cover image');
    } else {
      _customFormHelper.unfocusFormFields(context);
      _formKey.currentState!.save();
      _customAlerts.showLoaderDialog(context);
      fResponse = await _connectivityHelper.checkInternetConnection();
      if (fResponse.success) {
        fResponse = await _manageServiceStore.addNewService();
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

  @override
  Widget build(BuildContext context) {
    //ThemeData & constraints
    ThemeData theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        // backgroundColor: theme.colorScheme.primary,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Add New Vehicle',
                  style: theme.textTheme.headline2,
                ),
                const SizedBox(height: 10),
                customContainer(
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
                                      child: _manageServiceStore
                                              .newVehicleService
                                              .coverImage
                                              .isEmpty
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                  Text(
                                                    'Pick Cover Image',
                                                    style: theme
                                                        .textTheme.headline3,
                                                  ),
                                                  const Icon(
                                                    Icons.add,
                                                    size: 70,
                                                  )
                                                ])
                                          : buildImage(
                                              theme,
                                              _manageServiceStore
                                                  .newVehicleService
                                                  .coverImage));
                                }),
                              )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          serviceNameField(),
                          const SizedBox(height: 20),
                          serviceDescriptionField(),
                          const SizedBox(height: 20),
                          servicePriceField(),
                          const SizedBox(height: 20),
                          vehicleTypeDropdown(theme),
                          const SizedBox(height: 20),
                          serviceTypeDropdown(theme),
                          const SizedBox(height: 20),
                          saveButton(context),
                        ]),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceDescriptionField() {
    return TextFormField(
      validator: _customValidator.nonNullableString,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        _manageServiceStore.changeDescription(val);
      },
      // initialValue: _userProfileScreenStore.user.address,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Service Description',
      ),
    );
  }

  Widget serviceNameField() {
    return TextFormField(
      validator: _customValidator.nonNullableString,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        _manageServiceStore.changeServiceName(val);
      },
      // initialValue: _userProfileScreenStore.user.address,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Service Name',
      ),
    );
  }

  Widget servicePriceField() {
    return TextFormField(
      validator: _customValidator.validatePrice,
      onSaved: (String? val) {
        if (val == null) {
          return;
        }
        _manageServiceStore.changeCost(double.tryParse(val) ?? 0);
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Price',
      ),
    );
  }

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

  Widget vehicleTypeDropdown(ThemeData theme) {
    return Observer(builder: (_) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                  isExpanded: true,
                  value: _manageServiceStore.newVehicleService.vehicleType
                      .getName(),
                  onChanged: (String? newValue) {
                    _manageServiceStore.changeSelectedVehicleType(
                        newValue ?? VehicleType.bike.getName());
                  },
                  items: VehicleType.values.map((VehicleType classType) {
                    return DropdownMenuItem<String>(
                      value: classType.getName(),
                      child: Text(
                        classType.getName(),
                        style: theme.textTheme.headline4,
                      ),
                    );
                  }).toList()),
            ),
          ),
        ],
      );
    });
  }

  Widget serviceTypeDropdown(ThemeData theme) {
    return Observer(builder: (_) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String>(
                  isExpanded: true,
                  value: _manageServiceStore.newVehicleService.serviceType
                      .getName(),
                  onChanged: (String? newValue) {
                    _manageServiceStore.changeSelectedServiceType(
                        newValue ?? ServiceType.fullCarWash.getName());
                  },
                  items: ServiceType.values.map((ServiceType classType) {
                    return DropdownMenuItem<String>(
                      value: classType.getName(),
                      child: Text(
                        classType.getName(),
                        style: theme.textTheme.headline4,
                      ),
                    );
                  }).toList()),
            ),
          ),
        ],
      );
    });
  }
}
