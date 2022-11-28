part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({
    this.errorMessage = '',
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  HomeState copyWith({String? errorMessage});
}

class MainState extends HomeState {
  const MainState({
    errorMessage = '',
  }) : super(errorMessage: errorMessage);

  @override
  List<Object?> get props => [errorMessage];

  @override
  MainState copyWith({String? errorMessage}) {
    print('Copy');
    return MainState(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LoadingGame extends HomeState {
  const LoadingGame();

  @override
  LoadingGame copyWith({
    String? errorMessage,
  }) {
    return LoadingGame();
  }
}

class Joining extends HomeState {
  const Joining();

  @override
  Joining copyWith({
    String? errorMessage,
  }) {
    return Joining();
  }
}
