part of 'package:boggle_flutter/screens/board_screen/board_screen.dart';

class TimerComponent extends StatelessWidget {
  const TimerComponent({
    Key? key,
    // required this.boardBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final BoardBloc boardBlocRead = context.read<BoardBloc>();

    final boardBlocWatch = context.watch<BoardBloc>();
    return BlocProvider(
      create: (context) => TimerBloc(
        boardBloc: boardBlocWatch,
        startTime: boardBlocWatch.state.timeRemaining,
      )..add(const LoadTimer()),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if ((!state.running) && (boardBlocWatch.state is Playing)) {
            context.read<TimerBloc>().add(const TimerStart());
          } else {}
          return Text(state.time.toString());
        },
      ),
    );
  }
}
