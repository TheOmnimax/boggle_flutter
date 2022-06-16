part of 'package:boggle_flutter/bloc/app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.roomCode = '',
    this.playerId = '',
    this.playerName = '',
    this.isHost = false,
    this.username = '',
    this.loginStatus,
    this.loginDetails,
  });

  final String roomCode;
  final String playerId;
  final String playerName;
  final bool isHost;
  final String username;
  final LoginResult? loginStatus;
  final String? loginDetails;

  @override
  List<Object?> get props => [
        roomCode,
        playerId,
        playerName,
        isHost,
        username,
        loginStatus,
        loginDetails,
      ];

  AppState copyWith({
    String? roomCode,
    String? playerId,
    bool? isHost,
    String? playerName,
    String? username,
    LoginResult? loginStatus,
    String? loginDetails,
  }) {
    return AppState(
      roomCode: roomCode ?? this.roomCode,
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      isHost: isHost ?? this.isHost,
      username: username ?? this.username,
      loginStatus: loginStatus,
      loginDetails: loginDetails,
    );
  }
}
