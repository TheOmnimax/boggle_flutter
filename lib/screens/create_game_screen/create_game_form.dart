part of 'create_game_screen.dart';

class GameCreationForm extends StatefulWidget {
  const GameCreationForm({
    required this.createGameFunction,
    Key? key,
  }) : super(key: key);

  final Function(int, int, int, String) createGameFunction;

  @override
  State<GameCreationForm> createState() => _GameCreationFormState();
}

class _GameCreationFormState extends State<GameCreationForm> {
  final formKey = GlobalKey<FormState>();
  var name = '';
  var time = 90;

  @override
  Widget build(BuildContext context) {
    void buttonFunction(int width, int height) {
      widget.createGameFunction(time, width, height, name);
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          DataInput(
            title: 'Name',
            topInput: true,
            onChanged: (String value) {
              name = value;
            },
            validator: (String? value) {
              if (name == '') {
                return 'Please enter your name.';
              }
            },
            initialValue: name,
          ),
          DataInput(
            title: 'Time',
            onChanged: (String value) {
              int? num = int.tryParse(value);
              if ((num == null) || (num < 0)) {
                time = 0;
              } else {
                time = num;
              }
            },
            keyboardType: TextInputType.number,
            validator: (String? value) {
              if (time == 0) {
                return 'Please enter a valid time';
              }
            },
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            maxLength: 3,
            initialValue: time.toString(),
          ),
          Column(
            children: [
              const Text('Board:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoardButton(
                    width: 4,
                    height: 4,
                    createGameFunction: buttonFunction,
                    color: Colors.blue,
                    formKey: formKey,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class BoardButton extends StatelessWidget {
  const BoardButton({
    required this.width,
    required this.height,
    required this.createGameFunction,
    required this.color,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  final int width;
  final int height;
  final Function(int, int) createGameFunction;
  final GlobalKey<FormState> formKey;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          createGameFunction(width, height);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: 40,
        width: 80,
        child: Center(
          child: Text(
            '${width}x$height',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
