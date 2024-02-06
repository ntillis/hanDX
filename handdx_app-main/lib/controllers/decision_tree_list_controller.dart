import 'dart:developer';

import 'package:handdx/controllers/auth_controller.dart';
import 'package:handdx/models/decision_tree_model.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:handdx/repositories/decision_tree_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Use for exceptions that should be displayed in a snack bar
final decisionTreeListExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final decisionTreeListControllerProvider = StateNotifierProvider<
    DecisionTreeListController, AsyncValue<List<DecisionTree>>>((ref) {
  // Update decision tree controller when auth state changes
  final user = ref.watch(authControllerProvider);
  return DecisionTreeListController(ref, user?.uid);
});

class DecisionTreeListController
    extends StateNotifier<AsyncValue<List<DecisionTree>>> {
  final Ref _ref;
  final String? uid;

  DecisionTreeListController(this._ref, this.uid)
      : super(const AsyncLoading()) {
    // retrieve only when signed in to firebase
    if (uid != null) {
      retrieveDecisionTrees();
    }
  }

  Future<void> retrieveDecisionTrees({bool isRefreshing = false}) async {
    log('RETRIEVE');
    if (isRefreshing) state = const AsyncLoading();
    try {
      log('TRY');
      final decisionTrees = await _ref
          .read(decisionTreeRepositoryProvider)
          .retrieveDecisionTrees();
      if (mounted) {
        log('MOUNTED');
        state = AsyncData(decisionTrees);
      }
    } on CustomException catch (e, st) {
      log('EXCEPTION');
      // display no decision tree content, only error message (no snack bar)
      state = AsyncError(e, st);
    }
  }
}
