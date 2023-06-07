import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notif_data.dart';

class NotifDataController {
  static List<NotifData> notifDataList = [];
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void loadNotifDataFromStorage() {
    String? jsonNotifData = _prefs.getString('notifData');
    Map<String, dynamic> notifData = jsonDecode(jsonNotifData ?? '{}');
    // print('notif data from storage');
    // print(notifData);

    notifDataList = [];
    for (final data in notifData.entries) {
      notifDataList.add(NotifData.fromJson(data.value));
    }
    // print('\nnotif data list');
    // print(notifDataList);
  }

  static void saveNotifDataIntoStorage() async {
    Map<String, dynamic> allNotifData = {};

    for (final notifData in notifDataList) {
      allNotifData[notifData.notifKey] = notifData.toJson();
    }

    final jsonNotifDataString = jsonEncode(allNotifData);

    await _prefs.setString('notifData', jsonNotifDataString);
  }

  static NotifData? getSingleNotifData({required int notifId}) {
    NotifData? notif;
    for (int notifIndex=0; notifIndex < notifDataList.length; notifIndex++) {
      if (notifDataList[notifIndex].notifId == notifId) {
        notif = notifDataList[notifIndex];
        break;
      }
    }

    return notif;
  }

  // static void setNotifiedTime({required int notifId, required String notifTime}) {
  //   for (int notifIndex=0; notifIndex < notifDataList.length; notifIndex++) {
  //     if (notifDataList[notifIndex].notifId == notifId) {
  //       notifDataList[notifIndex].notifiedAt = notifTime;
  //       break;
  //     }
  //   }
  //
  //   saveNotifDataIntoStorage();
  // }
}