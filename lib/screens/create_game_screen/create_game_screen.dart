import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
            print('Name is currently ${state.playerName}');
            print('Game time is ${state.gameTime}');
            final timeTc = TextEditingController();
            if ((state.gameTime == 0) || (state.gameTime == null)) {
              timeTc.text = '';
            } else {
              timeTc.text = state.gameTime.toString();
            }
            timeTc.selection = TextSelection(
                baseOffset: timeTc.text.length,
                extentOffset: timeTc.text.length);
            final nameTc = TextEditingController()..text = state.playerName;
            nameTc.selection = TextSelection(
                baseOffset: nameTc.text.length,
                extentOffset: nameTc.text.length);
            return Column(
              children: [
                NameInput(
                  onChanged: (value) {
                    context
                        .read<CreateGameBloc>()
                        .add(SetName(playerName: value));
                  },
                  tc: nameTc,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text('Time (s)'),
                        SizedBox(
                          child: TextFormField(
                            onChanged: (value) {
                              context.read<CreateGameBloc>().add(SetTime(
                                  gameTime: num.tryParse(value)?.toInt()));
                            },
                            controller: timeTc,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
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
                              print('Game time is ${state.gameTime}');
                              if (state.playerName == '') {
                                context.read<CreateGameBloc>().add(
                                      NewAlert(
                                        alert: Alert(
                                          context: context,
                                          title: 'No name given!',
                                          desc: 'Please provide a name',
                                          buttons: [
                                            PopupCloseButton(
                                              context: context,
                                            ),
                                          ],
                                          style: popupStyle,
                                        ),
                                      ),
                                    );
                              } else if ((state.gameTime == 0) ||
                                  (state.gameTime == null)) {
                                context.read<CreateGameBloc>().add(
                                      NewAlert(
                                        alert: Alert(
                                          context: context,
                                          title: 'No time given!',
                                          desc: 'Please provide a time',
                                          buttons: [
                                            PopupCloseButton(
                                              context: context,
                                            ),
                                          ],
                                          style: popupStyle,
                                        ),
                                      ),
                                    );
                              } else {
                                Overlay.of(context)?.insert(loadingO);

                                context.read<AppBloc>().add(AddPlayer(
                                      roomCode:
                                          '', // TODO: Make so don't have to provide room code
                                      name: state.playerName,
                                    ));
                                context.read<CreateGameBloc>().add(
                                      Create(
                                        time: state.gameTime ??
                                            90, // This should never actually be 90
                                        width: 4,
                                        height: 4,
                                        name: state.playerName,
                                      ),
                                    );
                              }
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
