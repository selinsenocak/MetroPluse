import 'package:flutter_test/flutter_test.dart';

import 'package:metropulse/main.dart';

void main() {
  testWidgets('Panel seçim ekranı üç paneli listeler', (WidgetTester tester) async {
    await tester.pumpWidget(const MetroPulseApp());

    expect(find.text('MetroPulse'), findsOneWidget);
    expect(find.text('Vatandaş Paneli'), findsOneWidget);
    expect(find.text('İBB Personeli Paneli'), findsOneWidget);
    expect(find.text('Teknik Ekip Paneli'), findsOneWidget);
  });

  testWidgets('Vatandaş Paneline geçiş arızalı cihazları gösterir', (WidgetTester tester) async {
    await tester.pumpWidget(const MetroPulseApp());

    await tester.tap(find.text('Vatandaş Paneli'));
    await tester.pumpAndSettle();

    expect(find.text('ARIZALI'), findsWidgets);
    expect(find.text('Arıza Bildir'), findsOneWidget);
  });
}
