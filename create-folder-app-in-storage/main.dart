import 'dart:convert';
import 'dart:typed_data';
import 'package:access_phone_storage/access_phone_storage.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test save file to internal storage'),
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
  final fileCont = TextEditingController();
  final subFolderCont = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? imageFile;

  @override
  void dispose() {
    fileCont.dispose();
    subFolderCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const Text('Nama sub foder: '),
                    Flexible(
                      child: TextField(
                        controller: subFolderCont,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await AccessPhoneStorage.instance.createSubDirectory(folderName: subFolderCont.text);
                        },
                        child: const Text('Create')
                    ),
                  ],
                ),

                const SizedBox(height: 26,),
                const Text('Nama file: '),
                TextField(
                  controller: fileCont,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await screenshotController.capture().then((Uint8List? image) {
                          imageFile = image;
                          debugPrint('Screenshot done');
                        }).catchError((onError) {
                          debugPrint(onError);
                        });

                        bool isOk = await AccessPhoneStorage.instance.saveIntoStorage(fileName: fileCont.text, data: imageFile);

                        if (isOk) {
                          debugPrint('${fileCont.text} berhasil dibuat');
                        }
                      },
                      child: const Text('Screenshot')
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> data = {
                            "nama": "Doni",
                            "umur": 20,
                            "alamat": "Jakarta"
                          };

                          bool isOk = await AccessPhoneStorage.instance.saveIntoStorage(fileName: fileCont.text, data: json.encode(data), writeAsString: true);

                          if (isOk) {
                            debugPrint('${fileCont.text} berhasil dibuat');
                          }
                        },
                        child: const Text('Create JSON')
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
