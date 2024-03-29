import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/game/boggle_results.dart';
import 'package:boggle_flutter/utils/http.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends Bloc<ResultsEvent, ResultsState> {
  ResultsBloc({
    required this.appBloc,
  }) : super(const LoadingState()) {
    on<Loading>(_loading);
  }

  final AppBloc appBloc;

  Future _loading(Loading event, Emitter<ResultsState> emit) async {
    final response = await Http.post(
      uri: baseUrl + 'get-results',
      body: {
        'room_code': appBloc.state.roomCode,
      },
    );
    final responseBody = Http.jsonDecode(response.body);
    final boggleResults = BoggleResults.fromJson(responseBody);
    emit(MainState(boggleResults: boggleResults));
    return null;
  }
}
