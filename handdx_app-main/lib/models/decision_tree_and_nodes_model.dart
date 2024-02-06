import 'package:handdx/models/decision_tree_model.dart';
import 'package:handdx/models/node_model.dart';

/// A model that contains a [DecisionTree] and a map of its [Node]s.
///
/// Used by the [DecisionTreeController] to store the current selected decision tree and its nodes.
class DecisionTreeAndNodes {
  DecisionTree decisionTree;
  Map<String, Node> nodes;
  DecisionTreeAndNodes({
    required this.decisionTree,
    required this.nodes,
  });
}
