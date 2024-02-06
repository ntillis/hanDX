// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_tree_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DecisionTree _$$_DecisionTreeFromJson(Map<String, dynamic> json) =>
    _$_DecisionTree(
      id: json['id'] as String?,
      shortTreeName: json['shortTreeName'] as String,
      longTreeName: json['longTreeName'] as String,
      treeDescription: json['treeDescription'] as String,
      pictureUrl: json['pictureUrl'] as String,
      rootNode: json['rootNode'] as String,
    );

Map<String, dynamic> _$$_DecisionTreeToJson(_$_DecisionTree instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortTreeName': instance.shortTreeName,
      'longTreeName': instance.longTreeName,
      'treeDescription': instance.treeDescription,
      'pictureUrl': instance.pictureUrl,
      'rootNode': instance.rootNode,
    };
