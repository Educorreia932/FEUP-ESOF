import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenIAmLoggedInStep() {
  return given<FlutterWorld>(
     'I have "emailfield" and "passfield" and "loginbutton"',
        (context) async {
      final emailLocator = find.byValueKey("emailfield");
      await FlutterDriverUtils.enterText(
          context.world.driver, emailLocator, "escama@escama.pt");

      final passLocator = find.byValueKey("passfield");
      await FlutterDriverUtils.enterText(
          context.world.driver, passLocator, "escama");

      final buttonLocator = find.byValueKey("loginButton");
      await FlutterDriverUtils.tap(context.world.driver, buttonLocator);
    },
  );
}
