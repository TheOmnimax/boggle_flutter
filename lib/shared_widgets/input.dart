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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$title: '),
        SizedBox(
          child: TextFormField(
            onChanged: onChanged,
            controller: tc,
            validator: validator,
            autofocus: topInput,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            decoration: InputDecoration(counterText: ''),
            initialValue: initialValue,
          ),
          width: width,
        ),
      ],
    );
  }
}
