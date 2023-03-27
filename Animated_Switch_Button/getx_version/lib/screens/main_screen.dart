import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getx/bindings/binding.dart';

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
            const Text('Total device:', style: TextStyle(fontSize: 18),),
            const SizedBox(height: 20,),
            SizedBox(
              width: 100,
              height: 40,
              child: TextField(
                onChanged: (value) {
                  deviceCtrl.totalDevice = int.parse(value);
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {

                  await Get.toNamed('/deviceScreen');
                },
                child: const Text('Process')
            )
          ],
        ),
      ),
    );
  }
}