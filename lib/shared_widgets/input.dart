import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataInput extends StatelessWidget {
  const DataInput({
    required this.title,
    required this.onChanged,
    this.topInput = false,
    this.width = 200,
    this.tc,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.initialValue,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  final String title;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? tc;
  final TextInputType? keyboardType;
  final bool topInput;
  final double width;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? initialValue;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: TextFormField(
              focusNode: focusNode,
              onChanged: onChanged,
              controller: tc,
              validator: validator,
              autofocus: topInput,
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: const Color.fromARGB(100, 237, 237, 237),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                    width: 1.0,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                labelText: title,
              ),
              initialValue: initialValue,
            ),
            width: width,
          ),
        ),
      ],
    );
  }
}
