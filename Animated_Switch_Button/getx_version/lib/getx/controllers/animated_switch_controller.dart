import 'package:get/get.dart';
import '../bindings/binding.dart';
import 'package:flutter/material.dart';

class CustomAnimatedSwitchCtrl extends GetxController {
  bool currentSwitchStatus = false;
  var toggleSwitch = false.obs;
  int currentButtonIndex = -1;
  var _total = 0.obs;

  void incrementTotal(val) {
    _total++;
  }

  RxInt getTotal() {
    return _total;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('[animated_controller] on init executed');
  }

  @override
  onReady() {
    super.onReady();
    print('[animated_controller] ever function is ready');

    /// ever function berguna seperti listener,
    /// jika nilai variabel toggleSwitch berubah, maka akan mengeksekusi fungsi incrementTotal
    /// ever function is like a listener
    /// if toggleSwitch value changes, then the incrementTotal function will be executed
    ever(toggleSwitch, incrementTotal);
  }

  VoidCallback? onSwitchOn() {
    String commandToTurnOn = deviceCtrl.deviceList[currentButtonIndex].animatedSwitch.getSwitchStatus().toString();
    print('[devices_view] To turn On Command: $commandToTurnOn / device index: $currentButtonIndex');

    // BluetoothData.instance.sendMessageToBluetooth(commandToTurnOn, false);
    return null;
  }

  VoidCallback? onSwitchOff() {
    String commandToTurnOff = deviceCtrl.deviceList[currentButtonIndex].animatedSwitch.getSwitchStatus().toString();
    print('[devices_view] To turn Off Command: $commandToTurnOff / device index: $currentButtonIndex');

    // BluetoothData.instance.sendMessageToBluetooth(commandToTurnOff, false);
    return null;
  }
}
