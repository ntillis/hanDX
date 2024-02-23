import 'dart:developer';

import 'package:handdx/models/decision_tree_model.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:handdx/repositories/decision_tree_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Use for exceptions that should be displayed in a snack bar
final decisionTreeListExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final decisionTreeListControllerProvider = StateNotifierProvider<
    DecisionTreeListController, AsyncValue<List<DecisionTree>>>((ref) {
  return DecisionTreeListController(ref);
});

class DecisionTreeListController
    extends StateNotifier<AsyncValue<List<DecisionTree>>> {
  final Ref _ref;

  DecisionTreeListController(this._ref)
      : super(const AsyncLoading()) {
    retrieveDecisionTrees();
  }

  Future<void> retrieveDecisionTrees({bool isRefreshing = false}) async {
    log('RETRIEVE');
    if (isRefreshing) state = const AsyncLoading();
    try {
      log('TRY');
      final decisionTrees = await _ref
          .read(decisionTreeRepositoryProvider)
          .retrieveDecisionTrees();
      log('SUCCESS');
      state = AsyncData(decisionTrees);
    } on CustomException catch (e, st) {
      log('EXCEPTION');
      // display no decision tree content, only error message (no snack bar)
      state = AsyncError(e, st);
    }
  }
}
