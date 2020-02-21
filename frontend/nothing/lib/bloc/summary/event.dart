import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';

@freezed
abstract class SummaryEvent with _$SummaryEvent {
  const factory SummaryEvent.reset() = Reset;
  const factory SummaryEvent.answer({
    @required int id,
    @required bool answer,
  }) = NewAnswer;
}