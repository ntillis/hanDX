// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decision_tree_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DecisionTree _$DecisionTreeFromJson(Map<String, dynamic> json) {
  return _DecisionTree.fromJson(json);
}

/// @nodoc
mixin _$DecisionTree {
  String? get id => throw _privateConstructorUsedError;
  String get shortTreeName => throw _privateConstructorUsedError;
  String get longTreeName => throw _privateConstructorUsedError;
  String get treeDescription => throw _privateConstructorUsedError;
  String get pictureUrl => throw _privateConstructorUsedError;
  String get rootNode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DecisionTreeCopyWith<DecisionTree> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DecisionTreeCopyWith<$Res> {
  factory $DecisionTreeCopyWith(
          DecisionTree value, $Res Function(DecisionTree) then) =
      _$DecisionTreeCopyWithImpl<$Res, DecisionTree>;
  @useResult
  $Res call(
      {String? id,
      String shortTreeName,
      String longTreeName,
      String treeDescription,
      String pictureUrl,
      String rootNode});
}

/// @nodoc
class _$DecisionTreeCopyWithImpl<$Res, $Val extends DecisionTree>
    implements $DecisionTreeCopyWith<$Res> {
  _$DecisionTreeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? shortTreeName = null,
    Object? longTreeName = null,
    Object? treeDescription = null,
    Object? pictureUrl = null,
    Object? rootNode = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      shortTreeName: null == shortTreeName
          ? _value.shortTreeName
          : shortTreeName // ignore: cast_nullable_to_non_nullable
              as String,
      longTreeName: null == longTreeName
          ? _value.longTreeName
          : longTreeName // ignore: cast_nullable_to_non_nullable
              as String,
      treeDescription: null == treeDescription
          ? _value.treeDescription
          : treeDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pictureUrl: null == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rootNode: null == rootNode
          ? _value.rootNode
          : rootNode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DecisionTreeCopyWith<$Res>
    implements $DecisionTreeCopyWith<$Res> {
  factory _$$_DecisionTreeCopyWith(
          _$_DecisionTree value, $Res Function(_$_DecisionTree) then) =
      __$$_DecisionTreeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String shortTreeName,
      String longTreeName,
      String treeDescription,
      String pictureUrl,
      String rootNode});
}

/// @nodoc
class __$$_DecisionTreeCopyWithImpl<$Res>
    extends _$DecisionTreeCopyWithImpl<$Res, _$_DecisionTree>
    implements _$$_DecisionTreeCopyWith<$Res> {
  __$$_DecisionTreeCopyWithImpl(
      _$_DecisionTree _value, $Res Function(_$_DecisionTree) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? shortTreeName = null,
    Object? longTreeName = null,
    Object? treeDescription = null,
    Object? pictureUrl = null,
    Object? rootNode = null,
  }) {
    return _then(_$_DecisionTree(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      shortTreeName: null == shortTreeName
          ? _value.shortTreeName
          : shortTreeName // ignore: cast_nullable_to_non_nullable
              as String,
      longTreeName: null == longTreeName
          ? _value.longTreeName
          : longTreeName // ignore: cast_nullable_to_non_nullable
              as String,
      treeDescription: null == treeDescription
          ? _value.treeDescription
          : treeDescription // ignore: cast_nullable_to_non_nullable
              as String,
      pictureUrl: null == pictureUrl
          ? _value.pictureUrl
          : pictureUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rootNode: null == rootNode
          ? _value.rootNode
          : rootNode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DecisionTree extends _DecisionTree with DiagnosticableTreeMixin {
  const _$_DecisionTree(
      {this.id,
      required this.shortTreeName,
      required this.longTreeName,
      required this.treeDescription,
      required this.pictureUrl,
      required this.rootNode})
      : super._();

  factory _$_DecisionTree.fromJson(Map<String, dynamic> json) =>
      _$$_DecisionTreeFromJson(json);

  @override
  final String? id;
  @override
  final String shortTreeName;
  @override
  final String longTreeName;
  @override
  final String treeDescription;
  @override
  final String pictureUrl;
  @override
  final String rootNode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DecisionTree(id: $id, shortTreeName: $shortTreeName, longTreeName: $longTreeName, treeDescription: $treeDescription, pictureUrl: $pictureUrl, rootNode: $rootNode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DecisionTree'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('shortTreeName', shortTreeName))
      ..add(DiagnosticsProperty('longTreeName', longTreeName))
      ..add(DiagnosticsProperty('treeDescription', treeDescription))
      ..add(DiagnosticsProperty('pictureUrl', pictureUrl))
      ..add(DiagnosticsProperty('rootNode', rootNode));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DecisionTree &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shortTreeName, shortTreeName) ||
                other.shortTreeName == shortTreeName) &&
            (identical(other.longTreeName, longTreeName) ||
                other.longTreeName == longTreeName) &&
            (identical(other.treeDescription, treeDescription) ||
                other.treeDescription == treeDescription) &&
            (identical(other.pictureUrl, pictureUrl) ||
                other.pictureUrl == pictureUrl) &&
            (identical(other.rootNode, rootNode) ||
                other.rootNode == rootNode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, shortTreeName, longTreeName,
      treeDescription, pictureUrl, rootNode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DecisionTreeCopyWith<_$_DecisionTree> get copyWith =>
      __$$_DecisionTreeCopyWithImpl<_$_DecisionTree>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DecisionTreeToJson(
      this,
    );
  }
}

abstract class _DecisionTree extends DecisionTree {
  const factory _DecisionTree(
      {final String? id,
      required final String shortTreeName,
      required final String longTreeName,
      required final String treeDescription,
      required final String pictureUrl,
      required final String rootNode}) = _$_DecisionTree;
  const _DecisionTree._() : super._();

  factory _DecisionTree.fromJson(Map<String, dynamic> json) =
      _$_DecisionTree.fromJson;

  @override
  String? get id;
  @override
  String get shortTreeName;
  @override
  String get longTreeName;
  @override
  String get treeDescription;
  @override
  String get pictureUrl;
  @override
  String get rootNode;
  @override
  @JsonKey(ignore: true)
  _$$_DecisionTreeCopyWith<_$_DecisionTree> get copyWith =>
      throw _privateConstructorUsedError;
}
