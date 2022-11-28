import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/create_game_screen.dart';
import 'package:boggle_flutter/screens/home_screen/bloc/home_bloc.dart';
import 'package:boggle_flutter/screens/home_screen/popup_bloc/popup_bloc.dart';
import 'package:boggle_flutter/screens/results_screen/results_screen.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:boggle_flutter/utils/game/boggle_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

part 'package:boggle_flutter/screens/home_screen/mode_widgets/home_host.dart';
part 'package:boggle_flutter/screens/home_screen/mode_widgets/home_join.dart';

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
    FocusNode fc = FocusNode();
    return GameArea(
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LoadingGame) {
            // If already joined game, then get ready to push the board screen

            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const BoardScreen(),
              ),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Boggle!'),
                ScreenButton(
                  label: 'Host',
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
                ScreenButton(
                  label: 'Join',
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (subContext) {
                          return BlocProvider.value(
                            //https://stackoverflow.com/a/71232348/10368970
                            value: context.read<HomeBloc>(),
                            child: JoinPopup(
                              onPressed: (String name, String roomCode) {
                                print('About to run');
                                context.read<HomeBloc>().add(
                                    JoinGame(roomCode: roomCode, name: name));
                                print('Ran');
                              },
                            ),
                          );
                          // return JoinPopup(
                          //   onPressed: (String name, String roomCode) {
                          //     print('About to run');
                          //     context.read<HomeBloc>().add(
                          //         JoinGame(roomCode: roomCode, name: name));
                          //     print('Ran');
                          //   },
                          // );
                        });
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
