// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:handdx/main.dart';
import 'package:flutter/cupertino.dart';

void main() {
  testWidgets('App Initialization', (WidgetTester tester) async {
    const screen = HandDxApp();
    await tester.pumpWidget(const ProviderScope(child: screen));
    expect(find.byWidget(screen), findsOneWidget);
  });
}
