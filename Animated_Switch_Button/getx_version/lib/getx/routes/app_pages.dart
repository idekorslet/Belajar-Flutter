import 'package:animated_switch/getx/routes/route_names.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../../main.dart';
import '../../screens/devices_screen.dart';
import '../bindings/binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.main,
      page: () => const MyApp(),
      binding: InitialBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),

    GetPage(
      name: RouteName.deviceScreen,
      page: () => const DeviceScreen(),
      binding: AnimatedSwitchBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}