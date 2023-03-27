import 'package:animated_switch/getx/bindings/binding.dart';
import 'package:animated_switch/views/device_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Device List'),
              const Flexible(child: SizedBox(width: 40,)),
              Text('Switched: ${animatedSwitchCtrl?.getTotal()}'),
            ],
          );
        })
      ),
      body: const DeviceView(),
    );
  }
}
