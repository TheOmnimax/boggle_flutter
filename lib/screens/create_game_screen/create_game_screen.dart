import 'package:boggle_flutter/screens/create_game_screen/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';

class CreateGame extends StatelessWidget {
  const CreateGame({
    Key? key,
    required this.playerType,
  }) : super(key: key);

  final PlayerType playerType;

  @override
  Widget build(BuildContext context) {
    print('Starting create utils.game.game page...');
    return BlocProvider(
      create: (context) => CreateGameBloc(),
      child: const CreateGameMain(),
    );
  }
}

class CreateGameMain extends StatelessWidget {
  const CreateGameMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Update to ensure only numbers can be entered
    final tc = TextEditingController();
    int time = 90;
    return GameArea(
      child: BlocListener<CreateGameBloc, CreateGameState>(
        listener: (context, state) {
          if (state is Joining) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => BoardScreen(
                  gameCode: state.gameCode,
                  playerCode: state.playerCode,
                ),
              ),
            );
          }
        },
        child: BlocBuilder<CreateGameBloc, CreateGameState>(
          builder: (context, state) {
            return Row(
              children: [
                Column(
                  children: [
                    Text('Time (s)'),
                    Container(
                      child: TextField(
                        onChanged: (value) {
                          time = num.tryParse(value)?.toInt() ?? 90;
                        },
                      ),
                      width: 200,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('Game board'),
                    StartButton(
                        onPressed: () {
                          context.read<CreateGameBloc>().add(
                                Create(
                                  time: 90,
                                  width: 4,
                                  height: 4,
                                ),
                              );
                        },
                        text: '4x4'),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
