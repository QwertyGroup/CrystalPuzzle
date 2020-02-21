// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package

part of 'domain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

mixin _$Question {
  int get id;
  String get question;
  String get explanation;
  String get answers;
  int get mmr;

  Question copyWith(
      {int id, String question, String explanation, String answers, int mmr});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_Question with DiagnosticableTreeMixin implements _Question {
  const _$_Question(
      {this.id, this.question, this.explanation, this.answers, this.mmr});

  factory _$_Question.fromJson(Map<String, dynamic> json) =>
      _$_$_QuestionFromJson(json);

  @override
  final int id;
  @override
  final String question;
  @override
  final String explanation;
  @override
  final String answers;
  @override
  final int mmr;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Question(id: $id, question: $question, explanation: $explanation, answers: $answers, mmr: $mmr)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Question'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('explanation', explanation))
      ..add(DiagnosticsProperty('answers', answers))
      ..add(DiagnosticsProperty('mmr', mmr));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Question &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.question, question) ||
                const DeepCollectionEquality()
                    .equals(other.question, question)) &&
            (identical(other.explanation, explanation) ||
                const DeepCollectionEquality()
                    .equals(other.explanation, explanation)) &&
            (identical(other.answers, answers) ||
                const DeepCollectionEquality()
                    .equals(other.answers, answers)) &&
            (identical(other.mmr, mmr) ||
                const DeepCollectionEquality().equals(other.mmr, mmr)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      id.hashCode ^
      question.hashCode ^
      explanation.hashCode ^
      answers.hashCode ^
      mmr.hashCode;

  @override
  _$_Question copyWith({
    Object id = freezed,
    Object question = freezed,
    Object explanation = freezed,
    Object answers = freezed,
    Object mmr = freezed,
  }) {
    return _$_Question(
      id: id == freezed ? this.id : id as int,
      question: question == freezed ? this.question : question as String,
      explanation:
          explanation == freezed ? this.explanation : explanation as String,
      answers: answers == freezed ? this.answers : answers as String,
      mmr: mmr == freezed ? this.mmr : mmr as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QuestionToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question(
      {int id,
      String question,
      String explanation,
      String answers,
      int mmr}) = _$_Question;

  factory _Question.fromJson(Map<String, dynamic> json) = _$_Question.fromJson;

  @override
  int get id;
  @override
  String get question;
  @override
  String get explanation;
  @override
  String get answers;
  @override
  int get mmr;

  @override
  _Question copyWith(
      {int id, String question, String explanation, String answers, int mmr});
}

QTree _$QTreeFromJson(Map<String, dynamic> json) {
  return _QTree.fromJson(json);
}

mixin _$QTree {
  Question get question;
  QTree get left;
  QTree get right;

  QTree copyWith({Question question, QTree left, QTree right});

  Map<String, dynamic> toJson();
}

@JsonSerializable()
class _$_QTree with DiagnosticableTreeMixin implements _QTree {
  const _$_QTree({this.question, this.left, this.right});

  factory _$_QTree.fromJson(Map<String, dynamic> json) =>
      _$_$_QTreeFromJson(json);

  @override
  final Question question;
  @override
  final QTree left;
  @override
  final QTree right;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QTree(question: $question, left: $left, right: $right)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QTree'))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('left', left))
      ..add(DiagnosticsProperty('right', right));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QTree &&
            (identical(other.question, question) ||
                const DeepCollectionEquality()
                    .equals(other.question, question)) &&
            (identical(other.left, left) ||
                const DeepCollectionEquality().equals(other.left, left)) &&
            (identical(other.right, right) ||
                const DeepCollectionEquality().equals(other.right, right)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ question.hashCode ^ left.hashCode ^ right.hashCode;

  @override
  _$_QTree copyWith({
    Object question = freezed,
    Object left = freezed,
    Object right = freezed,
  }) {
    return _$_QTree(
      question: question == freezed ? this.question : question as Question,
      left: left == freezed ? this.left : left as QTree,
      right: right == freezed ? this.right : right as QTree,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QTreeToJson(this);
  }
}

abstract class _QTree implements QTree {
  const factory _QTree({Question question, QTree left, QTree right}) = _$_QTree;

  factory _QTree.fromJson(Map<String, dynamic> json) = _$_QTree.fromJson;

  @override
  Question get question;
  @override
  QTree get left;
  @override
  QTree get right;

  @override
  _QTree copyWith({Question question, QTree left, QTree right});
}