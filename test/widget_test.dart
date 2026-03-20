import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/app/lifeos_app.dart';

void main() {
  testWidgets('LifeOS shell renders and shows emergency action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: LifeOsApp()));

    expect(find.text('LifeOS'), findsOneWidget);
    expect(find.text('EMERGENCY'), findsOneWidget);
  });
}
