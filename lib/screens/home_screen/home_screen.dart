import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/board_screen/board_components/components.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/create_game_screen.dart';
import 'package:boggle_flutter/screens/home_screen/bloc/home_bloc.dart';
import 'package:boggle_flutter/screens/home_screen/popup_bloc/popup_bloc.dart';
import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/input.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
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
    final mqData = MediaQuery.of(context);
    final screenSize = mqData.size;
    var gameCode = '';
    OverlayEntry? currentOverlay;
    String name = '';
    FocusNode fc = FocusNode();
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
                JoinWidget(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
