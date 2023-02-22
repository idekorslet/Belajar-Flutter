import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test animated switch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test animated switch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // double leftPos = -40;
  // bool isOn = false;
  List<String> data = ['1', '2', '3', '4', '5'];
  List<CustomAnimatedSwitch> switchList = [];

  @override
  Widget build(BuildContext context) {
    switchList = List.generate(data.length, (index) => CustomAnimatedSwitch());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('Switch no $index status is: ${switchList[index].getSwitchStatus()}');
              // print('Switch no $index status is: ${CustomAnimatedSwitch().getSwitchStatus()}');
            },
            child: Container(
              height: 80,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.blueAccent)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text('Switch No#${index + 1}', style: const TextStyle(fontSize: 20),),
                    const Expanded(child: SizedBox()),
                    // CustomAnimatedSwitch()
                    switchList[index]
                  ],
                ),
              )
            ),
          );
        }
      )
    );
  }
}

//ignore: must_be_immutable
class CustomAnimatedSwitch extends StatelessWidget {
  double _leftPos = -40;
  bool _isOn = false;
  bool _isSliding = false;

  CustomAnimatedSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return buildAnimatedSwitch(setState);
      }
    );
  }

  bool getSwitchStatus() => _isOn;

  buildAnimatedSwitch(Function setState) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (_isSliding == false) {
            _isSliding = true;
            setState(() {
              _isOn = !_isOn;
              _leftPos = _isOn ? 0 : -40;
            });
          }

        },
        child: Container(
            width: 100,
            height: 40,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: _isOn ? Colors.green : Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: _isOn ? Colors.green : Colors.grey
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  left: _leftPos,
                  onEnd: () {
                    _isSliding = false;
                  },
                  child: Row(
                    children: [
                      // Container(
                      //     width: 40,
                      //     height: 28,
                      //     margin: const EdgeInsets.only(right: 4),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.white),
                      //       borderRadius: const BorderRadius.all(Radius.circular(6)),
                      //       color: Colors.white,
                      //     ),
                      //     child: const Center(
                      //       child: Text('ON',
                      //         style: TextStyle(
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold
                      //         ),
                      //       ),
                      //     )
                      // ),
                      buildContainer(title: 'ON', rightMargin: 4),

                      // Container(
                      //   width: 40,
                      //   height: 28,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.white),
                      //     borderRadius: const BorderRadius.all(Radius.circular(6)),
                      //     color: Colors.white,
                      //   ),
                      // ),
                      buildContainer(),

                      buildContainer(title: 'OFF', leftMargin: 4),

                      // Container(
                      //     width: 40,
                      //     height: 28,
                      //     margin: const EdgeInsets.only(left: 4),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.white),
                      //       borderRadius: const BorderRadius.all(Radius.circular(6)),
                      //       color: Colors.white,
                      //     ),
                      //     child: const Center(
                      //       child: Text('OFF',
                      //         style: TextStyle(
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold
                      //         ),
                      //       ),
                      //     )
                      // ),
                    ],
                  ),
                )
              ],
            )
        ),
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
