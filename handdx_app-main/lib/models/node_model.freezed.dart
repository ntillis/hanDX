// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Node _$NodeFromJson(Map<String, dynamic> json) {
  return _Node.fromJson(json);
}

/// @nodoc
mixin _$Node {
  String? get id =>
      throw _privateConstructorUsedError; // Map keys: treeId, nodeId, text
  List<Map<String, String>>? get children => throw _privateConstructorUsedError;
  bool get isResult => throw _privateConstructorUsedError;
  String? get pictureUrl => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  String? get result => throw _privateConstructorUsedError;
  String? get treatment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeCopyWith<Node> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeCopyWith<$Res> {
  factory $NodeCopyWith(Node value, $Res Function(Node) then) =
      _$NodeCopyWithImpl<$Res, Node>;
  @useResult
  $Res call(
      {String? id,
      List<Map<String, String>>? children,
      bool isResult,
      String? pictureUrl,
      String? question,
      String? result,
      String? treatment});
}

/// @nodoc
class _$NodeCopyWithImpl<$Res, $Val extends Node>
    implements $NodeCopyWith<$Res> {
  _$NodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? children = freezed,
    Object? isResult = null,
    Object? pictureUrl = freezed,
    Object? question = freezed,
    Object? result = freezed,
    Object? treatment = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>?,
      isResult: null == isResult
          ? _value.isResult
          : isResult // ignore: cast_nullable_to_non_nullable
              as bool,
      pictureUrl: freezed == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String?,
      treatment: freezed == treatment
          ? _value.treatment
          : treatment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NodeCopyWith<$Res> implements $NodeCopyWith<$Res> {
  factory _$$_NodeCopyWith(_$_Node value, $Res Function(_$_Node) then) =
      __$$_NodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      List<Map<String, String>>? children,
      bool isResult,
      String? pictureUrl,
      String? question,
      String? result,
      String? treatment});
}

/// @nodoc
class __$$_NodeCopyWithImpl<$Res> extends _$NodeCopyWithImpl<$Res, _$_Node>
    implements _$$_NodeCopyWith<$Res> {
  __$$_NodeCopyWithImpl(_$_Node _value, $Res Function(_$_Node) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? children = freezed,
    Object? isResult = null,
    Object? pictureUrl = freezed,
    Object? question = freezed,
    Object? result = freezed,
    Object? treatment = freezed,
  }) {
    return _then(_$_Node(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>?,
      isResult: null == isResult
          ? _value.isResult
          : isResult // ignore: cast_nullable_to_non_nullable
              as bool,
      pictureUrl: freezed == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String?,
      treatment: freezed == treatment
          ? _value.treatment
          : treatment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Node extends _Node with DiagnosticableTreeMixin {
  const _$_Node(
      {this.id,
      required final List<Map<String, String>>? children,
      required this.isResult,
      required this.pictureUrl,
      required this.question,
      required this.result,
      required this.treatment})
      : _children = children,
        super._();

  factory _$_Node.fromJson(Map<String, dynamic> json) => _$$_NodeFromJson(json);

  @override
  final String? id;
// Map keys: treeId, nodeId, text
  final List<Map<String, String>>? _children;
// Map keys: treeId, nodeId, text
  @override
  List<Map<String, String>>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isResult;
  @override
  final String? pictureUrl;
  @override
  final String? question;
  @override
  final String? result;
  @override
  final String? treatment;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Node(id: $id, children: $children, isResult: $isResult, pictureUrl: $pictureUrl, question: $question, result: $result, treatment: $treatment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Node'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('children', children))
      ..add(DiagnosticsProperty('isResult', isResult))
      ..add(DiagnosticsProperty('pictureUrl', pictureUrl))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('result', result))
      ..add(DiagnosticsProperty('treatment', treatment));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Node &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.isResult, isResult) ||
                other.isResult == isResult) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.treatment, treatment) ||
                other.treatment == treatment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_children),
      isResult,
      pictureUrl,
      question,
      result,
      treatment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NodeCopyWith<_$_Node> get copyWith =>
      __$$_NodeCopyWithImpl<_$_Node>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodeToJson(
      this,
    );
  }
}

abstract class _Node extends Node {
  const factory _Node(
      {final String? id,
      required final List<Map<String, String>>? children,
      required final bool isResult,
      required final String? pictureUrl,
      required final String? question,
      required final String? result,
      required final String? treatment}) = _$_Node;
  const _Node._() : super._();

  factory _Node.fromJson(Map<String, dynamic> json) = _$_Node.fromJson;

  @override
  String? get id;
  @override // Map keys: treeId, nodeId, text
  List<Map<String, String>>? get children;
  @override
  bool get isResult;
  @override
  String? get pictureUrl;
  @override
  String? get question;
  @override
  String? get result;
  @override
  String? get treatment;
  @override
  @JsonKey(ignore: true)
  _$$_NodeCopyWith<_$_Node> get copyWith => throw _privateConstructorUsedError;
}
