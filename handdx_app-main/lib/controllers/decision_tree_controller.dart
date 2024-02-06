// use for exceptions that should be displayed in a snack bar
import 'dart:developer';

import 'package:handdx/controllers/current_node_controller.dart';
import 'package:handdx/models/decision_tree_and_nodes_model.dart';
import 'package:handdx/models/decision_tree_model.dart';
import 'package:handdx/models/node_model.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:handdx/repositories/decision_tree_repository.dart';
import 'package:handdx/repositories/node_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final decisionTreeExceptionProvider =
    StateProvider<CustomException?>((_) => null);

final decisionTreeControllerProvider =
    StateNotifierProvider<DecisionTreeController, DecisionTreeAndNodes?>(
        (ref) => DecisionTreeController(ref));

class DecisionTreeController extends StateNotifier<DecisionTreeAndNodes?> {
  final Ref _ref;

  DecisionTreeController(this._ref) : super(null);

  Future<void> selectTree({required DecisionTree tree, Node? startNode}) async {
    try {
      log('select tree $tree');
      final nodes = await _retrieveNodes(tree);

      if (mounted) {
        state = DecisionTreeAndNodes(decisionTree: tree, nodes: nodes);
      }
      // await _ref.read(currentNodeProvider.notifier).setCurrentNodeById(
      //     tree.id!, startNode == null ? tree.rootNode : startNode.id!);
      //_ref.read(decisionTreeControllerProvider.notifier).state = tree;
    } on CustomException catch (e) {
      _ref.read(decisionTreeExceptionProvider.notifier).state = e;
    }
  }

  Future<void> selectTreeById(
      {required String treeId, String? startNodeId}) async {
    try {
      log('current tree by id $treeId');
      final tree = await _retrieveTree(treeId);
      final nodes = await _retrieveNodes(tree);
      if (mounted) {
        state = DecisionTreeAndNodes(decisionTree: tree, nodes: nodes);
      }
      // await _ref
      //     .read(currentNodeProvider.notifier)
      //     .setCurrentNodeById(tree.id!, startNodeId ?? tree.rootNode);
    } on CustomException catch (e) {
      _ref.read(decisionTreeExceptionProvider.notifier).state = e;
    }
  }

  deselectTree() {
    state = null;
    _ref.read(currentNodeProvider.notifier).clearHistory();
  }

  Future<DecisionTree> _retrieveTree(String treeId) async {
    try {
      final nodes = await _ref
          .read(decisionTreeRepositoryProvider)
          .retrieveDecisionTree(treeId: treeId);
      return nodes;
    } on CustomException {
      rethrow;
    }
  }

  Future<Map<String, Node>> _retrieveNodes(DecisionTree tree) async {
    try {
      final nodes = await _ref
          .read(nodeRepositoryProvider)
          .retrieveNodes(treeId: tree.id!);
      return nodes;
    } on CustomException {
      rethrow;
    }
  }
}
