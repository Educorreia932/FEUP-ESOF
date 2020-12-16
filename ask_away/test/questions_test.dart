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

  group('Questions tests', () {

    setUp(() {
    // _mockContext = MockBuildContext();
    final key = GlobalKey<NavigatorState>();

    talkQuestions = MaterialApp(
        navigatorKey: key,
        home: Scaffold(
          body: Navigator(
            onGenerateRoute: (_) {
              return MaterialPageRoute<Widget>(
                builder: (context) {
                  bContext = context;
                  return TalkQuestionsScreen(true);
                },
                settings: RouteSettings(
                    arguments: TalkQuestionsArguments("testTalkId1")),
              );
            },
          ),
        ));
  });

    testWidgets('Verifies repeated question', (WidgetTester tester) async {
      await tester.pumpWidget(talkQuestions);

      final TalkQuestionsScreenState myWidgetState =
          tester.state(find.byType(TalkQuestionsScreen));

      myWidgetState.questions
          .add(new Question("test Question 1", 2, "id1", "user1", true));
      myWidgetState.questions
          .add(new Question("test Question 2", 6, "id2", "user2", true));

      bool result =
          myWidgetState.verifyEqualQuestions("test Question 3", bContext);
      expect(result, isTrue);

      result = myWidgetState.verifyEqualQuestions("test Question 2", bContext);
      expect(result, isFalse);

      result = myWidgetState.verifyEqualQuestions("test Question 1", bContext);
      expect(result, isFalse);

      result = myWidgetState.verifyEqualQuestions("test    Question \n2", bContext);
      expect(result, isFalse);

      result = myWidgetState.verifyEqualQuestions("test\nQuestion\n2", bContext);
      expect(result, isFalse);
    });

    testWidgets('Verifies question words', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      await tester.pumpWidget(talkQuestions);

      final TalkQuestionsScreenState myWidgetState =
          tester.state(find.byType(TalkQuestionsScreen));

      await loadCensoredWords();
      bool result =
          myWidgetState.verifyQuestionWords("this is a normal question :)");
      expect(result, isTrue);

      result = myWidgetState
          .verifyQuestionWords("goddamn this is a cool question :)");
      expect(result, isFalse);
    });

    testWidgets('Compares two questions', (WidgetTester tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();

      await tester.pumpWidget(talkQuestions);

      final TalkQuestionsScreenState myWidgetState =
      tester.state(find.byType(TalkQuestionsScreen));

      bool result = myWidgetState.compareQuestions("this is a normal question :)", "this is another question");
      expect(result, isFalse);

      result = myWidgetState.compareQuestions("this is a normal question :)", "this is a normal question :)");
      expect(result, isTrue);

      result = myWidgetState.compareQuestions("this is a normal    question :)", " this is   a normal question :)");
      expect(result, isTrue);

      result = myWidgetState.compareQuestions("this   is a normal   \nquestion :)", "this is a normal      question  :)");
      expect(result, isTrue);
    });
  });
}
