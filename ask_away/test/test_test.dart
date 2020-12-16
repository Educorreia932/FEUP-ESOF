import 'package:ask_away/components/cards/TalkCard.dart';
import 'package:ask_away/models/Question.dart';
import 'package:ask_away/screens/talks_screen/TalkQuestionsScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// class MockBuildContext extends Mock implements BuildContext {}

void main() {
  // MockBuildContext _mockContext;
  Widget talkQuestions;
  BuildContext bContext;

  setUp(() {
    // _mockContext = MockBuildContext();
    final key = GlobalKey<NavigatorState>();

    talkQuestions = MaterialApp(
        navigatorKey: key,
        home: Scaffold(
          body: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (context) { bContext = context; return TalkQuestionsScreen(true);},
                settings: RouteSettings(arguments: TalkQuestionsArguments("testTalkId1")),
              );
            },
          ),
        )
    );
  });


  testWidgets('Verifies equal questions', (WidgetTester tester) async {
    await tester.pumpWidget(talkQuestions);

    final TalkQuestionsScreenState myWidgetState = tester.state(find.byType(TalkQuestionsScreen));

    myWidgetState.questions.add(new Question("testQuestion1", 2, "id1", "user1", true));
    myWidgetState.questions.add(new Question("testQuestion2", 6, "id2", "user2", true));

    bool result = myWidgetState.verifyEqualQuestions("testQuestion3", bContext);
    expect(result, isTrue);

    result = myWidgetState.verifyEqualQuestions("testQuestion2", bContext);
    expect(result, isFalse);
  });

  testWidgets('Verifies question words', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.pumpWidget(talkQuestions);

    final TalkQuestionsScreenState myWidgetState = tester.state(find.byType(TalkQuestionsScreen));

    await loadCensoredWords();
    bool result = myWidgetState.verifyQuestionWords("this is a normal question :)");
    expect(result, isTrue);

    result = myWidgetState.verifyQuestionWords("goddamn this is a cool question :)");
    expect(result, isFalse);
  });

}
