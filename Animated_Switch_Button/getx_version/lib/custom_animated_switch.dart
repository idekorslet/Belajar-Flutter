import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx/bindings/binding.dart';

//ignore: must_be_immutable
class CustomAnimatedSwitch extends StatelessWidget {
  final RxDouble _leftPos = (-40.0).obs;
  bool _isSliding = false;
  final switchStatus = false.obs;
  int buttonIndex;

  CustomAnimatedSwitch({Key? key,
    required this.buttonIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    animatedSwitchCtrl?.currentButtonIndex = buttonIndex;
    return buildAnimatedSwitch();
  }

  bool getSwitchStatus() => switchStatus.value;

  buildAnimatedSwitch() {
    return Center(
      child: GestureDetector(
          onTap: () {
            if (_isSliding == false) {
              _isSliding = true;
              animatedSwitchCtrl?.toggleSwitch.value = !animatedSwitchCtrl!.toggleSwitch.value;

              animatedSwitchCtrl?.currentButtonIndex = buttonIndex;
              print('');
              print('[custom_animated_switch] on click --> buttonIndex: $buttonIndex / currentButtonIndex: ${animatedSwitchCtrl?.currentButtonIndex}');
              switchStatus.value = !switchStatus.value;

              if (switchStatus.isTrue) {
                animatedSwitchCtrl?.onSwitchOn.call();
                _leftPos.value = 0.0;
              } else {
                animatedSwitchCtrl?.onSwitchOff.call();
                _leftPos.value = -40.0;
              }
            }

          },
          child: Obx(() {
            return
              Container(
                  width: 100,
                  height: 40,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(color: switchStatus.isTrue ? Colors.green : Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: switchStatus.isTrue ? Colors.green : Colors.grey
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 250),
                        left: _leftPos.value,
                        onEnd: () {
                          _isSliding = false;
                        },
                        child: Row(
                          children: [
                            buildContainer(title: 'ON', rightMargin: 4),
                            buildContainer(),
                            buildContainer(title: 'OFF', leftMargin: 4),
                          ],
                        ),
                      )
                    ],
                  )
              );
          })
      ),
    );
  }

  buildContainer({String title='', double leftMargin=0, double rightMargin=0}) {
    return
      Container(
          width: 40,
          height: 28,
          margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
          decoration: title == ''
              ? BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: Colors.white,
          )
              : const BoxDecoration(),
          child: Center(
            child: Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          )
      );
  }
}

