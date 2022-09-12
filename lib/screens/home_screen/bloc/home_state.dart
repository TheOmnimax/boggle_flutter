part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({
    this.alert,
  });

  final Alert? alert;

  @override
  List<Object?> get props => [alert];

  HomeState copyWith({Alert? alert});

  HomeState noPopup();
}

class MainState extends HomeState {
  const MainState({
    Alert? alert,
  }) : super(alert: alert);

  @override
  MainState copyWith({Alert? alert}) {
    return MainState(
      alert: alert ?? this.alert,
    );
  }

  @override
  MainState noPopup() {
    return MainState();
  }
}

class JoinError extends HomeState {
  const JoinError({
    required this.errorMessage,
    Alert? alert,
  }) : super(alert: alert);

  final String errorMessage;

  @override
  List<Object?> get props => [
        errorMessage,
        alert,
      ];

  @override
  JoinError copyWith({
    String? errorMessage,
    Alert? alert,
  }) {
    return JoinError(
      errorMessage: errorMessage ?? this.errorMessage,
      alert: alert ?? this.alert,
    );
  }

  @override
  JoinError noPopup({
    String? errorMessage,
  }) {
    return JoinError(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class Joining extends HomeState {
  const Joining({
    Alert? alert,
  }) : super(alert: alert);

  @override
  Joining copyWith({Alert? alert}) {
    return Joining(
      alert: alert ?? this.alert,
    );
  }

  @override
  Joining noPopup() {
    return Joining();
  }
}
