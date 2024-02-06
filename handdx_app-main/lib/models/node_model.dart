import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'node_model.freezed.dart';
part 'node_model.g.dart';

/// The node model.
///
/// Uses the freezed package to generate the boilerplate code.
/// Edit this model file and not the [.g.dart] or [.freezed.dart] files.
@freezed
class Node with _$Node {
  const Node._();

  /// Creates a new [Node] with the given parameters.
  ///
  /// Results nodes have the children and question members as null.
  /// Question nodes have the result and treatment members as null.
  /// No node is guarenteed to have a pictureUrl.
  const factory Node({
    String? id,
    // Map keys: treeId, nodeId, text
    required List<Map<String, String>>? children,
    required bool isResult,
    required String? pictureUrl,
    required String? question,
    required String? result,
    required String? treatment,
  }) = _Node;

  factory Node.empty() => const Node(
        children: [],
        isResult: false,
        pictureUrl: '',
        question: '',
        result: '',
        treatment: '',
      );

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  factory Node.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Node.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove(id);
}
