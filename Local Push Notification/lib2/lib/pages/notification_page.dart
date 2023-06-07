import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import '../models/notif_data.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key, this.notifData, this.receivedAction}) : super(key: key);
  final NotifData? notifData;
  final ReceivedAction? receivedAction;

  @override
  Widget build(BuildContext context) {
    final notifId = receivedAction == null ? notifData?.notifId.toString() : receivedAction?.id.toString();
    final notifKey = receivedAction == null ? notifData?.notifKey : receivedAction!.payload?['notifKey'];
    final createdAt = receivedAction == null ? notifData?.createdAt : receivedAction!.payload?['notifKey'];
    final notifSchedule = receivedAction == null ? notifData?.createdAt : receivedAction!.payload?['notifSchedule'];
    final notifContent = receivedAction == null ? notifData?.notifContent : receivedAction!.payload?['notifContent'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContent(title: 'Notif ID', value: notifId!),
            buildContent(title: 'Notif key', value: notifKey!),
            buildContent(title: 'Created At', value: createdAt!),
            buildContent(title: 'Notif Schedule', value: notifSchedule!),

            const SizedBox(height: 40,),
            Center(
              child: Text(notifContent ?? "Notif content is empty")
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
