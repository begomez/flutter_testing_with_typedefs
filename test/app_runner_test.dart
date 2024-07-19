import 'package:flutter_test/flutter_test.dart';
import 'package:testing_with_typedefs/app_runner.dart';

class MockSDK {
  final bool flag;
  late final SdkRunner runner;

  MockSDK(this.flag);
}

void main() async {
  group("AppRunner", () {
    test("When initializing SDK (success) then no logs stored", () async {
      final mock = MockSDK(true);
      mock.runner = (
              {required String logName,
              required int sessionDuration,
              required Credentials creds}) async =>
          mock.flag;

      final obj = AppRunnerV2();

      await obj.init(sdk: mock.runner);

      assert(obj.logs.isEmpty);
    });

    test("When initializing SDK (error) then a new log stored", () async {
      final mock = MockSDK(false);
      mock.runner = (
              {required String logName,
              required int sessionDuration,
              required Credentials creds}) async =>
          mock.flag;

      final obj = AppRunnerV2();

      await obj.init(sdk: mock.runner);

      assert(obj.logs.isNotEmpty);
    });
  });
}
