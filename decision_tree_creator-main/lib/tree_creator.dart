import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decision_tree_creator/controllers/firebase_auth.dart';

class TreeCreator {
  static final db = FirebaseFirestore.instance;

  TreeCreator._(); // private constructor since this is a utility class

  static Future<bool> isAdmin() async {
    var res =
        await db.collection("ADMINS").doc(AuthenticationHelper.getUid()).get();
    if (res.data() == null) {
      return false;
    }
    return true;
  }

  static Future<String> createTree({
    required String shortTreeName,
    required String longTreeName,
    required String treeDescription,
    required String pictureUrl,
  }) async {
    return await _createTreeRecord(
        shortTreeName: shortTreeName,
        longTreeName: longTreeName,
        treeDescription: treeDescription,
        pictureUrl: pictureUrl);
  }

  static Future<void> setRootNode({
    required String treeId,
    required String rootNodeId,
  }) async {
    await db.collection("decisionTrees").doc(treeId).set({
      'rootNode': rootNodeId,
    }, SetOptions(merge: true));
  }

  static Future<String> createTreeNode({
    required String treeId,
    required bool isResult,
    String pictureUrl = "",
    String question = "",
    String? parentNodeId,
    String? parentTreeId,
    String? parentOptionText,
    String result = "",
    String treatment = "",
    String nextSteps = "",
  }) async {
    return await _createNode(
      treeId: treeId,
      isResult: isResult,
      pictureUrl: pictureUrl,
      question: question,
      parentNodeId: parentNodeId,
      parentTreeId: parentTreeId,
      parentOptionText: parentOptionText,
      result: result,
      treatment: treatment,
      nextSteps: nextSteps,
    );
  }

  static Future<void> linkAdditionalNodes({
    required String parentTreeId,
    required String childTreeId,
    required String parentOptionText,
    required String parentNodeId,
    required String childNodeId,
  }) async {
    DocumentSnapshot snapshot = await db
        .collection("decisionTrees")
        .doc(parentTreeId)
        .collection("nodes")
        .doc(parentNodeId)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      List<dynamic> children = data?["children"];
      children.add({
        "text": parentOptionText,
        "treeId": childTreeId,
        "nodeId": childNodeId,
      });
      await db
          .collection("decisionTrees")
          .doc(parentTreeId)
          .collection("nodes")
          .doc(parentNodeId)
          .set({"children": children}, SetOptions(merge: true));
    }
  }

  static Future<String> _createNode({
    required String treeId,
    required bool isResult,
    required String pictureUrl,
    required String question,
    String? parentNodeId,
    String? parentTreeId,
    String? parentOptionText,
    required String result,
    required String treatment,
    required String nextSteps,
  }) async {
    if (parentNodeId != null && parentOptionText == null) {
      throw Exception(
          "parentOptionText cannot be null when parentNodeId is not null");
    }

    String generatedDocumentID = db.collection("decisionTrees").doc().id;

    if (isResult) {
      await db
          .collection("decisionTrees")
          .doc(treeId)
          .collection("nodes")
          .doc(generatedDocumentID)
          .set({
        'treatment': treatment,
        'isResult': isResult,
        'pictureUrl': pictureUrl,
        'question': question,
        'result': result,
        'nextSteps': nextSteps,
      });
    } else {
      await db
          .collection("decisionTrees")
          .doc(treeId)
          .collection("nodes")
          .doc(generatedDocumentID)
          .set({
        'isResult': isResult,
        'pictureUrl': pictureUrl,
        'treatment': treatment,
        'question': question,
        'children': []
      });
    }

    if (parentNodeId != null && parentNodeId != "") {
      DocumentSnapshot snapshot = await db
          .collection("decisionTrees")
          .doc(parentTreeId ?? treeId)
          .collection("nodes")
          .doc(parentNodeId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        List<dynamic> children = data?["children"];
        children.add({
          "text": parentOptionText,
          "treeId": treeId,
          "nodeId": generatedDocumentID,
        });
        await db
            .collection("decisionTrees")
            .doc(parentTreeId ?? treeId)
            .collection("nodes")
            .doc(parentNodeId)
            .set({"children": children}, SetOptions(merge: true));
      }
    }

    await db.collection("changeLog").doc("lastUpdate").set({
      "lastUpdate": Timestamp.now(),
    });

    return generatedDocumentID;
  }

  static Future<String> _createTreeRecord({
    required String longTreeName,
    required String shortTreeName,
    required String treeDescription,
    required String pictureUrl,
  }) async {
    String generatedDocumentID = db.collection("decisionTrees").doc().id;
    await db.collection("decisionTrees").doc(generatedDocumentID).set({
      "longTreeName": longTreeName,
      "shortTreeName": shortTreeName,
      "treeDescription": treeDescription,
      "pictureUrl": pictureUrl,
    });
    return generatedDocumentID;
  }
}
