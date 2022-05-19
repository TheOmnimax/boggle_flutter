import 'dart:convert';

import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

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

    final response = await http.post(
      uri,
      headers: sendHeaders,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    if (statusCode == 404) {
      emit(const JoinError(results: 'Game not found'));
    } else {
      final playerCode = responseBody['player_id'] as String;
      emit(Joining(
        gameCode: event.gameCode,
        playerCode: playerCode,
      ));
    }
  }
}
