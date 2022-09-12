import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/bloc/create_game_bloc.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:boggle_flutter/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

// TODO: Add loading page for when waiting to retrieve data from server, before able to load board

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
