import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_event.dart';

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
    final mqData = MediaQuery.of(context);
    final topHeight = mqData.viewPadding.top;
    final loadingO = loadingOverlay(
      message: 'Creating game...',
      screenWidth: mqData.size.width,
      top: topHeight,
    );
    // TODO: Update to ensure only numbers can be entered
    final tc = TextEditingController();
    int time = 90;
    String name = '';
    return GameArea(
      child: BlocListener<CreateGameBloc, CreateGameState>(
        listener: (context, state) {
          if (state is Joining) {
            loadingO.remove();
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
            return Column(
              children: [
                NameInput(
                  onChanged: (value) {
                    name = value;
                  },
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text('Time (s)'),
                        SizedBox(
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
                        const Text('Game board'),
                        StartButton(
                            onPressed: () {
                              Overlay.of(context)?.insert(loadingO);

                              context
                                  .read<AppBloc>()
                                  .add(AddPlayerName(name: name));
                              context.read<CreateGameBloc>().add(
                                    Create(
                                      time: 90,
                                      width: 4,
                                      height: 4,
                                      name: name,
                                    ),
                                  );
                            },
                            text: '4x4'),
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
