// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Node _$$_NodeFromJson(Map<String, dynamic> json) => _$_Node(
      id: json['id'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
      isResult: json['isResult'] as bool,
      pictureUrl: json['pictureUrl'] as String?,
      question: json['question'] as String?,
      result: json['result'] as String?,
      treatment: json['treatment'] as String?,
    );

Map<String, dynamic> _$$_NodeToJson(_$_Node instance) => <String, dynamic>{
      'id': instance.id,
      'children': instance.children,
      'isResult': instance.isResult,
      'pictureUrl': instance.pictureUrl,
      'question': instance.question,
      'result': instance.result,
      'treatment': instance.treatment,
    };
