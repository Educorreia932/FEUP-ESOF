
import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/test_steps.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = new Duration(seconds: 50)
    ..features = [Glob(r"test/features/Login.feature")]
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [
      CheckGivenWidgets(),
      FillFormField(),
      ClickLoginButton()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/app.dart"
    ..exitAfterTestRun = true;

  return GherkinRunner().execute(config);
}