import 'package:handdx/models/node_model.dart';

/// A model for a visited [Node] history state.
///
/// Used by [CurrentNodeController] to store a previously selected node and the tree it was in.
/// This is useful for when the user wants to go back to a previous node, and allows for transitions
/// across nodes in different trees to be possible in the future.
class NodeHistory {
  Node node;
  String treeId;
  NodeHistory({
    required this.node,
    required this.treeId,
  });
}
