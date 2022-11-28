part of 'popup_bloc.dart';

class PopupState extends Equatable {
  const PopupState({
    required this.name,
    required this.roomCode,
    required this.errorMessage,
  });

  final String name;
  final String roomCode;
  final String errorMessage;

  @override
  List<Object?> get props => [
        name,
        roomCode,
        errorMessage,
      ];

  PopupState copyWith({
    String? name,
    String? roomCode,
    String? errorMessage,
  }) {
    return PopupState(
      name: name ?? this.name,
      roomCode: roomCode ?? this.roomCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
