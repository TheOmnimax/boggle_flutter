import 'package:boggle_flutter/constants/constants.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppOpened extends AppEvent {
  const AppOpened();
}

class AddGameInfo extends AppEvent {
  const AddGameInfo({
    required this.roomCode,
    required this.playerId,
    required this.isHost,
  });

  final String roomCode;
  final String playerId;
  final bool isHost;
}

class Login extends AppEvent {
  const Login({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;
}

class Logout extends AppEvent {
  const Logout();
}

class Register extends AppEvent {
  const Register({
    required this.username,
    required this.password1,
    required this.password2,
  });

  final String username;
  final String password1;
  final String password2;
}

class LoginError extends AppEvent {
  const LoginError({
    this.loginResult,
    this.loginDetails,
  });

  final LoginResult? loginResult;
  final String? loginDetails;
}
