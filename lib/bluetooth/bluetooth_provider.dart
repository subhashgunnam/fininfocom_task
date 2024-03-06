import 'package:flutter/services.dart';

Future<bool> enableBluetooth() async {
  var isEnabled = false;
  const platform = MethodChannel('bluetooth.flutter.dev/bluetooth');
  try {
    final result = await platform.invokeMethod<bool>('enableBluetooth');
    isEnabled = result ?? false;
  } on PlatformException catch (e) {
    isEnabled = false;
  }
  return isEnabled;
}
