import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/create_game_screen.dart';
import 'package:boggle_flutter/screens/home_screen/bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/show_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(appBloc: context.read<AppBloc>()),
      child: const HomeScreenMain(),
    );
  }
}

class HomeScreenMain extends StatelessWidget {
  const HomeScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final screenSize = mqData.size;
    var gameCode = '';
    OverlayEntry? currentOverlay;
    String name = '';

    return GameArea(
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is Joining) {
            // If already joined game, then get ready to push the board screen
            if (currentOverlay?.mounted ?? false) {
              currentOverlay?.remove();
            }
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const BoardScreen(),
              ),
            );
          } else if (state is JoinError) {
            // There was an error when attempting to join the game.
            final popup = Alert(
              context: context,
              title: 'Error joining game',
              desc: state.errorMessage,
              buttons: [
                PopupCloseButton(context: context),
              ],
              style: popupStyle,
            );
            popup.show();
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          final nameTc = TextEditingController();
          return Column(
            children: [
              Text('Version 1.0.0'),
              Row(
                children: <Widget>[
                  // TextButton(
                  //   child: const Text('Solo'),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute<void>(
                  //         builder: (context) => const CreateGame(
                  //           playerType: PlayerType.solo,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                  TextButton(
                    child: const Text('Host'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const CreateGame(
                            playerType: PlayerType.host,
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('Join'),
                    onPressed: () {
                      if (currentOverlay?.mounted ?? false) {
                        currentOverlay?.remove();
                      }
                      currentOverlay = overlayPopup(
                        screenWidth: screenSize.width,
                        child: Column(
                          children: <Widget>[
                            NameInput(
                              onChanged: (value) {
                                name = value;
                              },
                              tc: nameTc,
                            ),
                            TextField(
                              onChanged: (value) {
                                gameCode = value;
                              },
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      currentOverlay?.remove();
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                  child: const Text('join'),
                                  onPressed: () {
                                    context.read<AppBloc>().add(AddPlayer(
                                          roomCode: gameCode,
                                          name: name,
                                        ));
                                    //   context
                                    //       .read<HomeBloc>()
                                    //       .add(JoinGame(gameCode: gameCode));
                                    currentOverlay?.remove();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        // TODO: Update joining to this page for better error handling
                                        builder: (context) => BoardScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                      Overlay.of(context)?.insert(currentOverlay!);
                    },
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
