import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bazatrainer/Presentation/loginView.dart';
import 'package:bazatrainer/Presentation/profileView.dart';
import 'package:bazatrainer/Data/loginService.dart';
import 'mocks.mocks.dart';

@GenerateMocks([LoginService])
void main() {
  late MockLoginService mockLoginService;

  setUp(() {
    mockLoginService = MockLoginService();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: loginView(),
      ),
      routes: {
        ProfilePage.routeName: (context) => ProfilePage(),
      },
    );
  }

  testWidgets('should display error message when login fails', (WidgetTester tester) async {
    when(mockLoginService.login(any, any)).thenAnswer((_) async => 'Неверные данные для входа');

    await tester.pumpWidget(createWidgetUnderTest());

    // Введите почту и пароль
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'wrongpassword');

    // Нажмите кнопку "ПРОДОЛЖИТЬ"
    await tester.tap(find.text('ПРОДОЛЖИТЬ'));
    await tester.pumpAndSettle();

    // Проверяем, что отображается сообщение об ошибке
    expect(find.text('Неверные данные для входа'), findsOneWidget);
  });

  testWidgets('should navigate to ProfilePage on successful login', (WidgetTester tester) async {
    when(mockLoginService.login(any, any)).thenAnswer((_) async => null);

    await tester.pumpWidget(createWidgetUnderTest());

    // Введите почту и пароль
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'correctpassword');

    // Нажмите кнопку "ПРОДОЛЖИТЬ"
    await tester.tap(find.text('ПРОДОЛЖИТЬ'));
    await tester.pumpAndSettle();

    // Проверяем, что мы перешли на ProfilePage
    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
