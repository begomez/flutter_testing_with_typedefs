import 'package:testing_with_typedefs/app_runner.dart';

void main() async {
  // const initializer = AppRunnerV1();
  // await initializer.init();

  final initializer2 = AppRunnerV2();
  await initializer2.init(sdk: SomeStaticSDK.initSDK);
}
