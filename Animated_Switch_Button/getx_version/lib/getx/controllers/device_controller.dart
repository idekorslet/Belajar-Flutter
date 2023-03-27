import 'package:animated_switch/custom_animated_switch.dart';
import 'package:get/get.dart';
import '../../models/devices.dart';
import '../bindings/binding.dart';

class DeviceController extends GetxController {
  RxList<Devices> deviceList = <Devices>[].obs;
  int totalDevice = 0;

  buildDeviceList() {
    if (animatedSwitchCtrl == null) {
      print('[device_controller] animatedSwitchCtrl is null');
    }
    deviceList.clear();

    for (int i=0; i < totalDevice; i++) {
      deviceList.add(
          Devices(
              no: i + 1,
              name: 'Device No ${i + 1}',
              animatedSwitch: CustomAnimatedSwitch(buttonIndex: i),

          )
      );
    }
  }
}