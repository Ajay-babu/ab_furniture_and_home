import 'package:flutter_test/flutter_test.dart';
import 'package:ab_furniture_and_home/main.dart';

void main() {
  testWidgets('ABFurnitureApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ABFurnitureApp());

    // Verify that the title text is found
    expect(find.text('AB Furniture & Home'), findsOneWidget);
  });
}
