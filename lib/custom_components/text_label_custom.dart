import 'package:flutter/cupertino.dart';

class TextLabelCustom extends StatelessWidget {
  final String texto;

  const TextLabelCustom(this.texto);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    );
  }
}
