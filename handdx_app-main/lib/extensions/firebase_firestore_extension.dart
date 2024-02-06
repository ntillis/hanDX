import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference decisionTreesRef() => collection('decisionTrees');
  CollectionReference nodesRef(String treeId) =>
      collection('decisionTrees').doc(treeId).collection('nodes');
}
