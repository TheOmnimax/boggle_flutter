import 'package:boggle_flutter/screens/board_screen/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:http/http.dart' as http;
import 'bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'dart:convert';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.appBloc,
  }) : super(const MainState()) {
    on<SoloGame>(_soloGame);
    on<HostGame>(_hostGame);
    on<JoinGame>(_joinGame);
  }

  final AppBloc appBloc;

  Future _soloGame(SoloGame event, Emitter<HomeState> emit) async {}
  Future _hostGame(HostGame event, Emitter<HomeState> emit) async {}
  Future _joinGame(JoinGame event, Emitter<HomeState> emit) async {
    final uri = Uri.parse(baseUrl + 'join-game');
    final headers = {
      'game_code': event.gameCode,
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    if (statusCode == 404) {
      emit(const JoinError(results: 'Game not found'));
    } else {
      final playerCode = responseBody['player_id'] as String;
      print('Player code: $playerCode');
      emit(Joining(
        gameCode: event.gameCode,
        playerCode: playerCode,
      ));
    }
  }
}
