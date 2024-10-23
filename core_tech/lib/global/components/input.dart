import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? hint;
  final TextStyle? hintStyle;
  final Text? label;
  final bool senha;
  final Color? borderColor;
  Input({super.key, this.label, this.hint, this.hintStyle, this.borderColor, this.senha = false});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.senha && obscure,
      cursorColor: widget.borderColor,
      style: TextStyle(fontSize: 20, color: widget.borderColor),
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Theme.of(context).colorScheme.onSurface),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Theme.of(context).colorScheme.onSurface),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Theme.of(context).colorScheme.onSurface),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor ?? Theme.of(context).colorScheme.onSurface),
        ),
        hintText: widget.hint,
        suffixIcon: widget.senha
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  color: widget.borderColor,
                ))
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        label: widget.label,
        hintStyle: widget.hintStyle ?? TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.5)),
        labelStyle: TextStyle(fontSize: 20, color: widget.borderColor),
      ),
    );
  }
}
