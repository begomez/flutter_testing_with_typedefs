import 'package:flutter/material.dart';
import 'package:testing_with_typedefs/my_app.dart';

///
/// Alias for method signature
///
typedef SdkRunner = Future<bool> Function({
  required String logName,
  required int sessionDuration,
  required Credentials creds,
});

///
/// Class supposed to do some complex initialization before
/// running the Flutter app
///
class AppRunnerV1 {
  Future<void> init() async {
    debugPrint("Initializing app");

    //XXX: the offending dependency...
    final sdkReady = await SomeStaticSDK.initSDK(
      logName: "AppLogger",
      sessionDuration: 60 * 60 * 1000,
      creds: const Credentials("user@mail.com", "qwerty"),
    );

    if (sdkReady) {
      debugPrint("All good!");
      runApp(const MyApp());
    } else {
      debugPrint("Houston... we have a problem");
      //TODO: we will have to deal with the error!
    }
  }
}

///
/// Enhancement on previous class
///
class AppRunnerV2 {
  List<String> logs = [];

  //XXX: no more dependency here
  Future<void> init({
    required SdkRunner sdk,
  }) async {
    debugPrint("Initializing app");

    final sdkReady = await sdk.call(
      logName: "AppLogger",
      sessionDuration: 60 * 60 * 1000,
      creds: const Credentials("user@mail.com", "qwerty"),
    );

    if (sdkReady) {
      debugPrint("All good!");
      runApp(const MyApp());
    } else {
      debugPrint("Houston... we have a problem");
      logs.addAll(["Some error happen..."]);
    }
  }
}

///
/// Class pretending to be some external dependency hard to mock
///
abstract class SomeStaticSDK {
  static Future<bool> initSDK({
    required String logName,
    required int sessionDuration,
    required Credentials creds,
  }) {
    try {
      debugPrint("Initializing SDK for ${creds.toString()}");
      //XXX: very complex initialization is supposed to happen here...
      return Future.value(true);
    } on Exception {
      return Future.value(false);
    }
  }
}

class Credentials {
  final String user;
  final String token;

  const Credentials(this.user, this.token);

  @override
  String toString() => {
        "user": user,
        "token": token,
      }.toString();
}
