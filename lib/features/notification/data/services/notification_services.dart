import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationServices{
static init(){
  OneSignal.initialize("2b1b0c21-e174-4a32-92da-9e42b9636976");
  OneSignal.Notifications.requestPermission(true);

}
}