import 'package:demo_project/size_config.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.text,
    this.press,
  });
  final String ?text;
  final VoidCallback ?press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.5);
              }
              return Color.fromARGB(235, 18, 138, 230); // Use the component's default.
            },
          ),
        ),
        onPressed: press,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Color.fromARGB(255, 252, 251, 251),
          ),
        ),
      ),
    );
  }
}
