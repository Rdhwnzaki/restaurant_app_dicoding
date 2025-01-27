import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/screen/home/home_appbar_widget.dart';
import 'package:restaurant_app/static/navigation_route.dart';

void main() {
  testWidgets('HomeAppbarWidget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          NavigationRoute.searchRoute.name: (_) => Container(),
        },
        home: Scaffold(
          appBar: const HomeAppbarWidget(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);

    expect(find.text('Restaurant'), findsOneWidget);

    expect(find.byIcon(Icons.search), findsOneWidget);

    expect(find.text('Recommended restaurant for you!'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(Container), findsOneWidget);
  });
}
