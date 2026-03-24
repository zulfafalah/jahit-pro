import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jahit_pro/main.dart';

void main() {
  testWidgets('HomeScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: JahitProApp()),
    );
    await tester.pump();
    expect(find.text("Jahit Pro"), findsOneWidget);
  });
}
