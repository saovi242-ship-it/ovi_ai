import 'package:flutter_test/flutter_test.dart';
import 'package:ovi_ai/app/app.dart';

void main() {
  testWidgets('OVI AI opens on the Home foundation', (tester) async {
    await tester.pumpWidget(const OviAiApp());
    await tester.pumpAndSettle();

    expect(find.text('Good morning, Alex'), findsOneWidget);
    expect(find.text('Natasha is online'), findsOneWidget);
    expect(find.text('QUICK ACTIONS'), findsOneWidget);
  });
}
