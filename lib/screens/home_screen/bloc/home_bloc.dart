import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/error_handling/server_error_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/http.dart';
import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.appBloc,
  }) : super(const MainState()) {
    on<SoloGame>(_soloGame);
    on<HostGame>(_hostGame);
    on<JoinGame>(_addPlayer);
    on<CloseError>(_closeError);
  }

  final AppBloc appBloc;

  Future _soloGame(SoloGame event, Emitter<HomeState> emit) async {}
  Future _hostGame(HostGame event, Emitter<HomeState> emit) async {}
  Future _addPlayer(JoinGame event, Emitter<HomeState> emit) async {
    print('Adding player');
    final response = await Http.post(
      uri: baseUrl + 'add-player',
      body: {
        'room_code': event.gameCode,
        'name': event.name,
      },
    );

    final statusCode = response.statusCode;
    if (statusCode >= 400) {
      final errorMessage = ServerErrorHandler.getErrorMessage(response);
      emit(JoinError(
        errorMessage: errorMessage,
      ));
    } else {
      final responseBody = Http.jsonDecode(response.body);
      print(responseBody);
      final playerId = responseBody['player_id'];
      print('Player ID is $playerId');
      print('Room code: ${event.gameCode}');
      appBloc.add(AddGameInfo(
          roomCode: event.gameCode,
          playerId: playerId,
          playerName: event.name,
          isHost: false));
      emit(Joining());
    }
  }

  void _closeError(CloseError event, Emitter<HomeState> emit) {
    emit(const MainState());
  }
}
