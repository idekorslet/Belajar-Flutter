import 'package:animated_switch/getx/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'getx/bindings/binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Test animated switch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppPages.pages,
      home: const MyHomePage(title: 'Test animated switch'),

      initialBinding: InitialBinding(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Create new device list:', style: TextStyle(fontSize: 18),),
            const SizedBox(height: 20,),
            SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                onChanged: (value) {
                  int newValue = 0;
                  try {
                    newValue = int.parse(value);
                  } catch (e) {
                    print('error to convert to int');
                    newValue = 0;
                  }
                  deviceCtrl.totalDevice = newValue;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  deviceCtrl.buildDeviceList();
                  await Get.toNamed('/deviceScreen');
                },
                child: const Text('Process')
            ),


            const SizedBox(height: 60,),
            ElevatedButton(
                onPressed: () async {
                  await Get.toNamed('/deviceScreen');
                },
                child: const Text('Show Previous Device List')
            )
          ],
        ),
      ),
    );
  }
}