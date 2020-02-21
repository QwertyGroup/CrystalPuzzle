import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nothing/bloc/summary/event.dart';
import 'package:nothing/bloc/summary/state.dart';
import 'package:rxdart/rxdart.dart';

export 'event.dart';
export 'state.dart';

class SummaryBloc extends HydratedBloc<SummaryEvent, Summary> {
  @override
  Summary get initialState => super.initialState ?? Summary.empty();

  @override
  Stream<Summary> transformEvents(
    Stream<SummaryEvent> events,
    Stream<Summary> Function(SummaryEvent) next,
  ) {
    return super.transformEvents(
      events.publishValue().autoConnect().splitFuse(
          (x) => x is NewAnswer,
          (yes) => yes
              .buffer(yes.debounceTime(const Duration(milliseconds: 300)))
              .where((xs) => xs.length > 0)
              .map((xs) => xs.first)
              .doOnEach((x) => print(x.value)),
          (no) => no.doOnEach((x) => print(x.value))),
      next,
    );
  }

  @override
  Stream<Summary> mapEventToState(
    SummaryEvent event,
  ) async* {
    // event.map(reset: null, answer: null);
    if (event is NewAnswer) {
      var newState = Summary(summary: {
        ...state.summary,
        event.id: event.answer,
      }, id: state.id + 1);
      yield newState;
    } else if (event is Reset) {
      yield Summary.empty();
    }
  }

  @override
  Summary fromJson(Map<String, dynamic> json) {
    try {
      return Summary.fromJson(json);
    } catch (_) {
      print('Summary: fromJson error');
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(Summary summary) {
    try {
      return summary.toJson();
    } catch (_) {
      print('Summary: toJson error');
      return null;
    }
  }
}

extension StreamSplitter<T> on Stream<T> {
  Stream<U> splitFuse<U>(
    bool condition(T event),
    Stream<U> yes(Stream<T> stream),
    Stream<U> no(Stream<T> stream),
  ) {
    return Rx.merge([
      this.where(condition).chain(yes),
      this.where((x) => !condition(x)).chain(no),
    ]);
  }

  Stream<U> chain<U>(Stream<U> logic(Stream<T> stream)) => logic(this);
}