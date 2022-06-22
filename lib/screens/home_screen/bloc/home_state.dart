import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];

  HomeState copyWith();
}

class MainState extends HomeState {
  const MainState({
    String gameCode = '',
  });

  @override
  MainState copyWith() {
    return MainState();
  }
}

class JoinError extends HomeState {
  const JoinError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  @override
  JoinError copyWith({
    String? errorMessage,
  }) {
    return JoinError(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class Joining extends HomeState {
  const Joining();

  @override
  Joining copyWith() {
    return Joining();
  }
}
