import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/bloc/create_game_bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:boggle_flutter/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_game_form.dart';

class CreateGame extends StatelessWidget {
  const CreateGame({
    Key? key,
    required this.playerType,
  }) : super(key: key);

  final PlayerType playerType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateGameBloc(
        appBloc: context.read<AppBloc>(),
      ),
      child: const CreateGameMain(),
    );
  }
}

class CreateGameMain extends StatelessWidget {
  const CreateGameMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameArea(
      child: BlocListener<CreateGameBloc, CreateGameState>(
        listener: (context, state) {
          if (state is LoadingGame) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return LoadingDialog(context: context);
                });
          } else if (state is Joining) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const BoardScreen(),
              ),
            );
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state is JoinError) {
            showDialog(
                context: context,
                builder: (context) {
                  return WarningPopup(
                      context: context,
                      title: 'Error creating game',
                      message: state.errorMessage,
                      buttons: [
                        WarningButton(
                            label: 'OK',
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            })
                      ]);
                });
          }
        },
        child: BlocBuilder<CreateGameBloc, CreateGameState>(
          builder: (context, state) {
            return GameCreationForm(createGameFunction: (
              int time,
              int width,
              int height,
              String name,
            ) {
              context.read<CreateGameBloc>().add(
                    Create(
                      time: time,
                      width: width,
                      height: height,
                      name: name,
                    ),
                  );
            });
          },
        ),
      ),
    );
  }
}
