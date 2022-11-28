import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/error_handling/server_error_handling.dart';
import 'package:boggle_flutter/utils/http.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'home_event.dart';
part 'home_state.dart';

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
    emit(Joining());
    await Future.delayed(Duration(seconds: 1));
    final response = await Http.post(
      uri: baseUrl + 'add-player',
      body: {
        'room_code': event.roomCode,
        'name': event.name,
      },
    );

    final statusCode = response.statusCode;
    if (statusCode >= 400) {
      final errorMessage = ServerErrorHandler.getErrorMessage(response);
      emit(state.copyWith(errorMessage: errorMessage));
    } else {
      final responseBody = Http.jsonDecode(response.body);
      print(responseBody);
      if (responseBody.containsKey('error')) {
        emit(MainState(errorMessage: responseBody['error'] as String));
        return;
      }
      final playerId = responseBody['player_id'] as String;
      print('Player ID is $playerId');
      print('Room code: ${event.roomCode}');
      appBloc.add(AddGameInfo(
          roomCode: event.roomCode,
          playerId: playerId,
          playerName: event.name,
          isHost: false));

      emit(LoadingGame());
    }
  }

  void _closeError(CloseError event, Emitter<HomeState> emit) {
    if (state.errorMessage != '') {
      emit(state.copyWith(errorMessage: ''));
    }
  }
}
