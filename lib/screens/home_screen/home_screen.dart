import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/home_screen/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/show_popup.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/create_game_screen.dart';

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

    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
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
        return const Text('Loading...');
      } else {
        return GameArea(
          child: Row(
            children: <Widget>[
              TextButton(
                child: const Text('Solo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const CreateGame(
                        playerType: PlayerType.solo,
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text('Host'),
                onPressed: () {
                  print('Creating game...');
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
                                context
                                    .read<HomeBloc>()
                                    .add(JoinGame(gameCode: gameCode));
                                // currentOverlay?.remove();
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
        );
      }
    });
  }
}
