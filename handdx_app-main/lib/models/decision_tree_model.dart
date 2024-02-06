import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'decision_tree_model.freezed.dart';
part 'decision_tree_model.g.dart';

/// The decision tree model.
///
/// Uses the freezed package to generate the boilerplate code.
/// Edit this model file and not the [.g.dart] or [.freezed.dart] files.
@freezed
class DecisionTree with _$DecisionTree {
  const DecisionTree._();

  /// Creates a new [DecisionTree] with the given parameters.
  const factory DecisionTree({
    String? id,
    required String shortTreeName,
    required String longTreeName,
    required String treeDescription,
    required String pictureUrl,
    required String rootNode,
  }) = _DecisionTree;

  /// Creates a new empty [DecisionTree].
  factory DecisionTree.empty() => const DecisionTree(
        shortTreeName: '',
        longTreeName: '',
        treeDescription: '',
        pictureUrl: '',
        rootNode: '',
      );

  /// Creates a new [DecisionTree] from a JSON object.
  ///
  /// Used for mapping the data from the data in a Firestore document.
  factory DecisionTree.fromJson(Map<String, dynamic> json) =>
      _$DecisionTreeFromJson(json);

  /// Creates a new [DecisionTree] from a Firestore document.
  ///
  /// Used for mapping a document from Firestore.
  factory DecisionTree.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DecisionTree.fromJson(data).copyWith(id: doc.id);
  }

  /// Creates a new JSON representing a Firestore document.
  Map<String, dynamic> toDocument() => toJson()..remove(id);
}
