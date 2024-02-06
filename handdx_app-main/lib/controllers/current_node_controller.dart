import 'dart:developer';

import 'package:handdx/controllers/decision_tree_controller.dart';
import 'package:handdx/models/node_history_model.dart';
import 'package:handdx/models/node_model.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentNodeExceptionProvider =
    StateProvider<CustomException?>((_) => null);
final currentNodeProvider =
    StateNotifierProvider<CurrentNodeController, AsyncValue<Node?>>(
        (ref) => CurrentNodeController(ref));

// Used for determine direction of page animation
final movedForwardNodeProvider = StateProvider<bool>((_) => true);

final historyProvider = StateProvider<List<NodeHistory>>((_) => []);

class CurrentNodeController extends StateNotifier<AsyncValue<Node?>> {
  final Ref _ref;

  CurrentNodeController(this._ref) : super(const AsyncLoading());

  setCurrentNode(Node node) {
    log("current node: $node");
    try {
      _pushHistory(
          node, _ref.read(decisionTreeControllerProvider)!.decisionTree.id!);
      state = AsyncData(node);
    } on CustomException catch (e) {
      _ref.read(currentNodeExceptionProvider.notifier).state = e;
    }
  }

  setCurrentNodeById(String treeId, String nodeId) async {
    log("current node by Id: $nodeId");
    try {
      //final treeAndNodes = _ref.read(decisionTreeControllerProvider);
      if (treeId !=
          _ref.read(decisionTreeControllerProvider)?.decisionTree.id) {
        await _ref
            .read(decisionTreeControllerProvider.notifier)
            .selectTreeById(treeId: treeId);
      }
      final newNode = _ref.read(decisionTreeControllerProvider)!.nodes[nodeId];
      _pushHistory(newNode!, treeId);
      state = AsyncData(newNode);
    } on CustomException catch (e) {
      _ref.read(currentNodeExceptionProvider.notifier).state = e;
    }
  }

  moveToPreviousNode() {
    try {
      final prev = _popHistory();
      if (prev != null &&
          prev.treeId !=
              _ref.read(decisionTreeControllerProvider)?.decisionTree.id) {
        _ref
            .read(decisionTreeControllerProvider.notifier)
            .selectTreeById(treeId: prev.treeId);
        state = AsyncData(prev.node);
      } else if (prev != null) {
        state = AsyncData(prev.node);
      } else {
        state = const AsyncData(null);
      }
    } on CustomException catch (e) {
      _ref.read(currentNodeExceptionProvider.notifier).state = e;
    }
  }

  clearHistory() {
    try {
      state = const AsyncData(null);
      _ref.read(historyProvider.notifier).state = [];
    } on CustomException catch (e) {
      _ref.read(currentNodeExceptionProvider.notifier).state = e;
    }
  }

  get historyLength {
    try {
      return _ref.read(historyProvider).length;
    } on CustomException catch (e) {
      _ref.read(currentNodeExceptionProvider.notifier).state = e;
    }
  }

  _pushHistory(Node node, String treeId) {
    _ref
        .read(historyProvider.notifier)
        .state
        .add(NodeHistory(node: node, treeId: treeId));
  }

  NodeHistory? _popHistory() {
    if (_ref.read(historyProvider.notifier).state.length > 1) {
      _ref.read(historyProvider.notifier).state.removeLast();
      return _ref.read(historyProvider.notifier).state.last;
    }
    return null;
  }
}
