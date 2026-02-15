import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget 
{
    final String text;
    final VoidCallback? onPressed;
    const PrimaryButton({super.key, required this.text, this.onPressed});

    @override
    Widget build(BuildContext context) 
    {
        return Center(
          child: SizedBox(
            width: 220,
            child: FilledButton(
              onPressed: onPressed,
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
}
