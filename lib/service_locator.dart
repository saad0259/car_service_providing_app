import 'package:get_it/get_it.dart';

//UI and Theme
import 'custom_utils/google_maps_helper.dart';

//Custom Utilities
import 'custom_utils/function_response.dart';
import 'custom_utils/connectivity_helper.dart';
import 'custom_utils/custom_alerts.dart';
import 'custom_utils/custom_validator.dart';
import 'custom_utils/custom_form_helper.dart';
import 'custom_utils/image_helper.dart';
import 'stores/auth_store.dart';
import 'stores/home_screen_store.dart';
import 'stores/manage_service_store.dart';
import 'stores/profile_store.dart';
import 'stores/service_request_store.dart';
import 'theme/my_app_colors.dart';

//Stores

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  //Custom Utilities
  getIt.registerFactory(() => FunctionResponse());
  getIt.registerFactory(() => CustomAlerts());
  getIt.registerFactory(() => CustomValidator());
  getIt.registerFactory(() => CustomImageHelper());
  getIt.registerFactory(() => ConnectivityHelper());
  getIt.registerFactory(() => CustomFormHelper());
  getIt.registerFactory(() => GoogleMapsHelper());

  //UI and Theme
  getIt.registerFactory(() => AppColors());

  //Services
  // getIt.registerSingletonAsync<SharedPreferences>(
  //   () => LocalModule.provideSharedPreferences(),
  // );

  //Stores
  getIt.registerSingleton(AuthStore(
    getIt<CustomImageHelper>(),
  ));
  getIt.registerSingleton(ProfileStore(
    getIt<AuthStore>(),
    getIt<CustomImageHelper>(),
  ));
  getIt.registerSingleton(ServiceRequestStore());
  getIt.registerSingleton(HomeScreenStore(
    getIt<ProfileStore>(),
  ));
  getIt.registerSingleton(ManageServiceStore(
    getIt<ProfileStore>(),
    getIt<CustomImageHelper>(),
  ));
}
