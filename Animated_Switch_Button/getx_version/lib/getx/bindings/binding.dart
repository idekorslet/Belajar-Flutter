import 'package:animated_switch/getx/controllers/device_controller.dart';
import 'package:get/get.dart';
import '../controllers/animated_switch_controller.dart';

late DeviceController deviceCtrl;
CustomAnimatedSwitchCtrl? animatedSwitchCtrl;

class InitialBinding implements Bindings {

  @override
  void dependencies() {
    deviceCtrl = DeviceController();
    Get.put(deviceCtrl);

    // animatedSwitchCtrl = CustomAnimatedSwitchCtrl();


    // AnimatedSwitchBinding();
  }
}

class AnimatedSwitchBinding implements Bindings {
  @override
  void dependencies() {
    animatedSwitchCtrl = CustomAnimatedSwitchCtrl();
    Get.put(animatedSwitchCtrl);
  }
}