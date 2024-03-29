part of 'package:boggle_flutter/screens/home_screen/home_screen.dart';

class JoinPopup extends StatefulWidget {
  const JoinPopup({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Function(String, String) onPressed;
  // final String? errorMessage;

  @override
  State<JoinPopup> createState() => _JoinPopupState();
}

class _JoinPopupState extends State<JoinPopup> {
  @override
  Widget build(BuildContext context) {
    var name = '';
    var roomCode = '';
    final joinKey = GlobalKey<FormState>();
    final nameFocus = FocusNode();
    final roomFocus = FocusNode();

    return SimpleDialog(
      title: const Text('Join game'),
      children: [
        Form(
          key: joinKey,
          child: Column(
            children: [
              DataInput(
                title: 'Name',
                topInput: true,
                focusNode: nameFocus,
                onChanged: (String value) {
                  name = value;
                },
                validator: (String? value) {
                  if (value == '') {
                    nameFocus.requestFocus();
                    return 'Please enter your name!';
                  }
                },
              ),
              DataInput(
                title: 'Room code',
                focusNode: roomFocus,
                onChanged: (String value) {
                  roomCode = value;
                  context.read<HomeBloc>().add(const CloseError());
                },
                validator: (String? value) {
                  if (value == '') {
                    if (name != '') {
                      roomFocus.requestFocus();
                    }
                    return 'Please enter the room code!';
                  } else {}
                },
              ),
              ErrorWidget(
                roomFocus: roomFocus,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ScreenButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(const CancelJoin());
                        Navigator.pop(context);
                      },
                      label: 'Cancel'),
                  JoinButton(
                    joinKey: joinKey,
                    onPressed: () {
                      if (joinKey.currentState!.validate()) {
                        widget.onPressed(name, roomCode);
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class JoinButton extends StatelessWidget {
  const JoinButton({
    required this.joinKey,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> joinKey;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is Joining) {
        return const SizedBox(
          width: 106,
          child: SpinKitDualRing(
            color: Colors.blue,
            lineWidth: 4,
            size: 20,
          ),
        );
      } else {
        return ScreenButton(
          onPressed: onPressed,
          label: 'Join',
        );
      }
    });
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    required this.roomFocus,
    Key? key,
  }) : super(key: key);

  final FocusNode roomFocus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.errorMessage != '') {
        roomFocus.requestFocus();
      }
      return Text(
        state.errorMessage,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      );
    });
  }
}
