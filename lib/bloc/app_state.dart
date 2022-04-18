import 'package:equatable/equatable.dart';
import 'package:boggle_flutter/constants/constants.dart';

class AppState extends Equatable {
  const AppState({
    required this.username,
    this.loginStatus,
    this.loginDetails,
  });

  final String username;
  final LoginResult? loginStatus;
  final String? loginDetails;

  @override
  List<Object?> get props => [
        username,
        loginStatus,
        loginDetails,
      ];

  AppState copyWith({
    String? username,
    LoginResult? loginStatus,
    String? loginDetails,
  }) {
    return AppState(
      username: username ?? this.username,
      loginStatus: loginStatus,
      loginDetails: loginDetails,
    );
  }
}
