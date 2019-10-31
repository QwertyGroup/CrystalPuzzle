import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ProblemsEvent extends Equatable {
  const ProblemsEvent();
}

class FetchProblems extends ProblemsEvent {
  final int count;

  const FetchProblems({
    this.count = 4,
  });

  @override
  List<Object> get props => [count];
}

class AnsweredProblems extends ProblemsEvent {
  final Map<int, bool> results;
  const AnsweredProblems({
    @required this.results,
  });

  @override
  List<Object> get props => [results];
}