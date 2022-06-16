import 'package:boggle_flutter/screens/board_screen/bloc/board_bloc/board_bloc.dart';
import 'package:boggle_flutter/screens/board_screen/bloc/timer_bloc/timer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
