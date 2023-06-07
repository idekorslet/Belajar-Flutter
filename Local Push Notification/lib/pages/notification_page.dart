import 'package:flutter/material.dart';
import '../models/notif_data.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key, this.notifData}) : super(key: key);
  final NotifData? notifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContent(title: 'Notif ID', value: notifData?.notifId.toString() ?? ""),
            buildContent(title: 'Notif key', value: notifData?.notifKey ?? ""),
            buildContent(title: 'Created At', value: notifData?.createdAt ?? ""),
            buildContent(title: 'Notif Schedule', value: notifData?.notifSchedule ?? ""),

            const SizedBox(height: 40,),
            Center(
              child: Text(notifData?.notifContent ?? 'Notif content is empty')
            )
          ],
        ),
      ),
    );
  }

  buildContent({required String title, required String value}) {
    return
      Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(title),
          ),
          const Text(' : '),
          Text(value)
        ],
      );
  }
}
