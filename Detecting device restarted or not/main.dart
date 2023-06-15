import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_clock/system_clock.dart';

void main() {
  runApp(const MyApp());
}

DateTime _lastBootDatetime() {
  final bootSinceEpoch = DateTime.now().microsecondsSinceEpoch - SystemClock.elapsedRealtime().inMicroseconds;
  return DateTime.fromMicrosecondsSinceEpoch(bootSinceEpoch);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Detecting last time device restarted'),
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
  bool _isRestarted = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> isDeviceRestarted() async {
    bool result = false;

    final newRebootTime = _lastBootDatetime();

    final SharedPreferences prefs = await _prefs;
    String? lastRebootTime = prefs.getString('lastRebootTime');

    // jika nilai dari prefs.getString('lastRebootTime') == null, maka ambil nilainya dari newRebootTime.toString()
    if (lastRebootTime == null) {
      print('last reboot time is null');
      lastRebootTime = newRebootTime.toString();
      await prefs.setString('lastRebootTime', lastRebootTime); // save lastRebootTime into storage
    } else {
      print('last reboot time value is: $lastRebootTime');
    }

    // cek nilai string lastRebootTime dan ubah ke datetime kemudian bandingkan dengan nilai newRebootTime
    // check lastRebootTime value and change to dateTime and then compare it with newRebootTime value
    final duration = DateTime.parse(lastRebootTime).difference(newRebootTime);

    // jika nilai durasi dalam detik < 0, berarti perangkat di restart karena nilai dari newRebootTime diperbarui / berbeda dengan nilai lastRebootTime
    // if duration value in seconds < 0, that's mean the device is restarted (newRebootTime value is updated)
    if (duration.inSeconds < 0) {
      result = true;
    }

    print('different boot time: ${duration.inSeconds}');

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle(
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              child: Column(
                children: [
                  Text(_isRestarted ? 'Last restart time: ' : ''),
                  Text(_isRestarted ? _lastBootDatetime().toString() : ''),
                  const SizedBox(height: 50),
                  Text(_isRestarted ? 'Perangkat di-restart' : 'Perangkat tidak di-restart'),
                  Text(_isRestarted ? 'Device restarted' : 'Device not restarted')

                ],
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                _isRestarted = await isDeviceRestarted();

                if (_isRestarted) {
                  _prefs.then((SharedPreferences prefs) {
                    prefs.setString('lastRebootTime', _lastBootDatetime().toString());
                  });
                }

                setState(() {

                });

              },
              child: const Text('Check Status'),
            )
          ],
        ),
      ),
    );
  }
}
