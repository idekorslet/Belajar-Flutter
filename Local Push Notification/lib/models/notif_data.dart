class NotifData {
  final int notifId;
  final String notifTitle;
  final String notifBody;
  final String createdAt;
  final String notifSchedule;
  final String notifContent;
  // String? notifiedAt;
  late String notifKey;

  NotifData({
    required this.notifId, required this.createdAt, required this.notifSchedule,
    required this.notifTitle, required this.notifBody, required this.notifContent,
    // this.notifiedAt
  }) {
    notifKey = createdAt;
  }

  static NotifData fromJson(Map<String, dynamic> data) => NotifData(
    notifId: data['notifId'],
    notifTitle: data['notifTitle'],
    notifBody: data['notifBody'],
    createdAt: data['createdAt'],
    notifSchedule: data['notifSchedule'],
    notifContent: data['notifContent'],
    // notifiedAt: data['notifiedAt'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'notifId': notifId,
    'notifTitle': notifTitle,
    'notifBody': notifBody,
    'createdAt': createdAt,
    'notifSchedule': notifSchedule,
    'notifContent': notifContent,
    'notifKey': notifKey,
    // 'notifiedAt': notifiedAt ?? ''
  };
}