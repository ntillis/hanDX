import 'package:firebase_core/firebase_core.dart';
import 'package:handdx/extensions/firebase_firestore_extension.dart';
import 'package:handdx/general_providers.dart';
import 'package:handdx/models/node_model.dart';
import 'package:handdx/repositories/custom_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseNodeRepository {
  Future<Map<String, Node>> retrieveNodes({required String treeId});
}

final nodeRepositoryProvider =
    Provider<NodeRepository>((ref) => NodeRepository(ref));

class NodeRepository implements BaseNodeRepository {
  final Ref _ref;

  const NodeRepository(this._ref);

  @override
  Future<Map<String, Node>> retrieveNodes({required String treeId}) async {
    try {
      final snapshot =
          await _ref.read(firebaseFirestoreProvider).nodesRef(treeId).get();
      return {
        for (var doc in snapshot.docs)
          Node.fromDocument(doc).id!: Node.fromDocument(doc)
      };
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
