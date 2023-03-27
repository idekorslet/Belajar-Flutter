import 'package:animated_switch/getx/bindings/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceView extends StatelessWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (deviceCtrl.deviceList.isNotEmpty) {
      return ListView.builder(
          itemCount: deviceCtrl.deviceList.length,
          itemBuilder: (context, index) {

            return Container(
              height: 80,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.blueAccent)
                ),
              child: InkWell(
                onTap: () {
                  print('Switch no ${deviceCtrl.deviceList[index].no} status is: ${deviceCtrl.deviceList[index].animatedSwitch.getSwitchStatus()}');
                },
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text('Device No#${index + 1}', style: const TextStyle(fontSize: 20),),
                        const Expanded(child: SizedBox()),
                        deviceCtrl.deviceList[index].animatedSwitch
                      ],
                    ),
                  ),
              ),
            );
          }
      );
    } else {
      return Center(child: GestureDetector(
        onTap: () {

        },
        child: Obx(() {
          return Text('No device found: ${animatedSwitchCtrl!.getTotal()}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        })
        )
      );
    }

  }
}
