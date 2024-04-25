import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:frontend/util/notification_controller.dart';

Future<void> initializeNotifications() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: 'group_1',
      channelKey: 'channel_1',
      channelName: 'channel_1',
      channelDescription: 'channel_1',
    )
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: 'group_1',
      channelGroupName: 'group_1',
    )
  ]);

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
}
