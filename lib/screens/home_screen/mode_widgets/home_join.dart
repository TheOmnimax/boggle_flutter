part of 'package:boggle_flutter/screens/home_screen/home_screen.dart';

class JoinWidget extends StatelessWidget {
  const JoinWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alert = Alert(context: context);
    return BlocProvider(
      create: (context) => PopupBloc(),
      child: BlocBuilder<PopupBloc, PopupState>(
        builder: (context, state) {
          TextEditingController nameTc = TextEditingController()
            ..text = state.name;
          TextEditingController codeTc = TextEditingController()
            ..text = state.roomCode;
          return ScreenButton(
            label: 'Join',
            onPressed: () {
              print(state.errorMessage);
              context.read<HomeBloc>().add(
                    ShowPopup(
                      alert: Alert(
                        context: context,
                        title: 'Join game',
                        content: Column(
                          children: [
                            DataInput(
                              title: 'Game code',
                              onChanged: (value) {
                                context.read<PopupBloc>().add(
                                      UpdateName(name: value),
                                    );
                              },
                              tc: nameTc,
                            ),
                            DataInput(
                              title: 'Room code',
                              tc: codeTc,
                              onChanged: (value) {
                                context
                                    .read<PopupBloc>()
                                    .add(UpdateCode(roomCode: value));
                              },
                            ),
                            Text(state.errorMessage),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              // TODO: QUESTION: Why does it keep using a stale context?
                              context.read<HomeBloc>().add(
                                    const DismissPopup(),
                                  );
                            },
                          ),
                          DialogButton(
                            child: Text('Join'),
                            onPressed: () {
                              if (state.name == '') {
                                context.read<PopupBloc>().add(const UpdateError(
                                    errorMessage: 'Please provide your name'));
                              } else if (state.roomCode == '') {
                                context.read<PopupBloc>().add(const UpdateError(
                                    errorMessage:
                                        'Please provide the game code'));
                              } else {
                                context.read<HomeBloc>().add(
                                      const DismissPopup(),
                                    );
                                context.read<HomeBloc>().add(
                                      ShowPopup(
                                        alert: Alert(
                                          context: context,
                                          content: bigLoading,
                                        ),
                                      ),
                                    );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
            },
          );
        },
      ),
    );
  }
}
