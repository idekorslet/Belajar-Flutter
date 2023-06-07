import 'package:flutter/material.dart';
import 'package:local_push_notification/controllers/notification_controller.dart';
import '../controllers/notif_data_controller.dart';
import '../models/notif_data.dart';
import 'notification_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _minute = 0;
  String _errorText = '';
  final _textFieldMinuteController = TextEditingController();
  int selectedNotifId = -1;

  @override
  void initState() {
    super.initState();
    _textFieldMinuteController.addListener(setNewMinute);

    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    await NotifDataController.init();
    setState(() {
      NotifDataController.loadNotifDataFromStorage();
    });
  }

  @override
  void dispose() {
    _textFieldMinuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Push Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // height: 80,
                // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
                margin: const EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text('Minutes: ')
                    ),
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: TextField(
                        controller: _textFieldMinuteController,
                        keyboardType: TextInputType.number,
                        // decoration: InputDecoration(
                          // labelText: 'Minutes'
                          // errorText: errorText
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(_errorText, style: const TextStyle(color: Colors.red),),
              const SizedBox(
                height: 30,
              ),

              Text('Create new notification $_minute minutes from now'),
              const SizedBox(
                height: 30,
              ),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      onCreateButtonPressed();
                    });
                  },
                  child: const Text('Create')
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 40,),

              /// *********************** Notification Table ******************* ///
              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 10,
                        headingRowHeight: 30,
                        showCheckboxColumn: false,
                        columns: const [
                          DataColumn(label: Text('No.')),
                          DataColumn(label: Text('Created At')),
                          DataColumn(label: Text('Notif Schedule')),
                        ],
                        rows: tableContents()
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> tableContents() {
    List<DataRow> result = [];
    String createdAt;
    String notifSchedule;

    for (int i=0; i < NotifDataController.notifDataList.length; i++) {
      createdAt = NotifDataController.notifDataList[i].createdAt.substring(0, 19);
      notifSchedule = NotifDataController.notifDataList[i].notifSchedule.substring(0, 19);

      result.add(
        DataRow(
          onSelectChanged: (bool? selected) {
            if (selected!) {
              onSelectTableRow(notifIndex: i);
            }
          },
          cells: [
            DataCell(Text('${i + 1}')),
            DataCell(Text(createdAt)),
            DataCell(Text(notifSchedule)),
          ]
        )
      );
    }

    return result;
  }

  void onSelectTableRow({required int notifIndex}) {
    print('selected notif index: $notifIndex');
    final notifId = NotifDataController.notifDataList[notifIndex].notifId;
    selectedNotifId = notifId;
    final dataToSend = NotifDataController.getSingleNotifData(notifId: notifId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationPage(notifData: dataToSend)
      )
    );
  }

  void setNewMinute() {
    setState(() {
      try {
        if (_textFieldMinuteController.text != '') {
          _minute = int.parse(_textFieldMinuteController.text);
        } else {
          _minute = 0;
        }

        _errorText = '';
      } catch (e) {
        _errorText = 'Please input numeric only';
        // print(e);
      }
    });
  }

  Future<void> onCreateButtonPressed() async {
    final notifId = NotifDataController.notifDataList.length + 1;
    final notifKey = DateTime.now().toString();
    final notifSchedule = DateTime.now().add(Duration(minutes: _minute)).toString();

    NotifDataController.notifDataList.add(NotifData(
        notifId: notifId,
        createdAt: notifKey,
        notifSchedule: notifSchedule,
        notifTitle: 'Notif title for notif id: $notifId',
        notifBody: 'This is notif body example',
        notifContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    ));

    NotifDataController.saveNotifDataIntoStorage();

    if (_minute <= 0) {
      NotificationController.createNewNotification(
          notifId: notifId,
          title: 'Notif title for notif id: $notifId',
          body: 'This is notif body example',
          payload: {
            "notifContent": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            "notifKey": notifKey,
            "notifSchedule": notifSchedule
          }
      );
    } else {
      NotificationController.scheduleNewNotification(
          notifId: notifId,
          title: 'Notif title for notif id: $notifId',
          body: 'This is notif body example',
          payload: {
            "notifContent": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            "notifKey": notifKey,
            "notifSchedule": notifSchedule
          },
          minuteCount: _minute
      );
    }

    _textFieldMinuteController.clear();
  }
}
