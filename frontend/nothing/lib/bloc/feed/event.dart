import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:nothing/domain/domain.dart';

part 'event.freezed.dart';

@freezed
abstract class FeedEvent with _$FeedEvent {
  const factory FeedEvent.newArrived(QTree tree) = NewArrived;
  factory FeedEvent.moveNext() = MoveNext;
}