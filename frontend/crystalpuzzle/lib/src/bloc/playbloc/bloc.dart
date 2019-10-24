import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:crystalpuzzle/src/bloc/playbloc/states.dart';
import 'package:http/http.dart';

import 'events.dart';

export 'events.dart';
export 'states.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  @override
  PlayState get initialState => LoadingState();

  PlayBloc() {
    add(StartLoading());
  }

  @override
  Stream<PlayState> mapEventToState(
    PlayEvent event,
  ) async* {
    if (event is StartLoading) {
      // yield await simulateLoading();
      yield await fetchTasks();
    }
  }

  Future<TasksState> simulateLoading() async {
    return Future.delayed(
      Duration(seconds: 6),
      () => TasksState(tasks: [
        Task(
          question: "Simulation",
          explanation: "It's just a simulation",
          answers: ["On, I knew that"],
        ),
      ]),
    );
  }

  Future<TasksState> fetchTasks() async {
    var url =
        'https://us-central1-crystal-factory.cloudfunctions.net/GiveTasks';
    var resp = await post(url, body: '{"count": 3}');
    print(resp.body);
    if (resp.statusCode == 200) {
      var decoded = json.decode(resp.body);
      return TasksState.fromJson(decoded);
    } else {
      return await simulateLoading();
    }
  }
}