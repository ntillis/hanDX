import 'package:firebase_core/firebase_core.dart';
import 'package:handdx/extensions/firebase_firestore_extension.dart';
import 'package:handdx/general_providers.dart';
import 'package:handdx/models/decision_tree_model.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseDecisionTreeRepository {
  Future<List<DecisionTree>> retrieveDecisionTrees();
  Future<DecisionTree> retrieveDecisionTree({required String treeId});
}

final decisionTreeRepositoryProvider =
    Provider<DecisionTreeRepository>((ref) => DecisionTreeRepository(ref));

class DecisionTreeRepository implements BaseDecisionTreeRepository {
  final Ref _ref;

  const DecisionTreeRepository(this._ref);

  @override
  Future<List<DecisionTree>> retrieveDecisionTrees() async {
    try {
      final snapshot =
          await _ref.read(firebaseFirestoreProvider).decisionTreesRef().get();
      return snapshot.docs
          .map((doc) => DecisionTree.fromDocument(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<DecisionTree> retrieveDecisionTree({required String treeId}) async {
    try {
      final snapshot = await _ref
          .read(firebaseFirestoreProvider)
          .decisionTreesRef()
          .doc(treeId)
          .get();
      return DecisionTree.fromDocument(snapshot);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
