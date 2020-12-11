import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckGivenWidgets
    extends Given3WithWorld<String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2, String input3) async {
    final emailfield = find.byValueKey(input1);
    final passfield = find.byValueKey(input2);
    final button = find.byValueKey(input3);
    await FlutterDriverUtils.isPresent(world.driver, emailfield);
    await FlutterDriverUtils.isPresent(world.driver, passfield);
    await FlutterDriverUtils.isPresent(world.driver, button);
  }

  @override
  RegExp get pattern => RegExp(r"I have {string} and {string} and {string}");
}

class ClickLoginScreen extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String loginbtn) async {
    final loginfinder = find.byValueKey(loginbtn);
    await FlutterDriverUtils.tap(world.driver, loginfinder);
  }

  @override
  RegExp get pattern => RegExp(r'I have {string}');
}

class FillFormField extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(
        world.driver, find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r'I fill {string} field with {string}');
}

class ClickLoginButton extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String loginbtn) async {
    final loginfinder = find.byValueKey(loginbtn);
    await FlutterDriverUtils.tap(world.driver, loginfinder);
  }

  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}


// import 'package:flutter_driver/flutter_driver.dart';
// import 'package:flutter_gherkin/flutter_gherkin.dart';
// import 'package:gherkin/gherkin.dart';
//
// StepDefinitionGeneric GivenIAmLoggedInStep() {
//   return given<FlutterWorld>(
//     'I have "loginButton"',
//         (context) async {
//       final loginButton = find.byValueKey("loginButton");
//       await FlutterDriverUtils.tap(context.world.driver, loginButton);
//
//       // final passLocator = find.byValueKey("passInput");
//       // await FlutterDriverUtils.enterText(
//       //     context.world.driver, passLocator, "nachosnomnom");
//       //
//       // final buttonLocator = find.byValueKey("loginButton");
//       // await FlutterDriverUtils.tap(context.world.driver, buttonLocator);
//     },
//   );
// }
