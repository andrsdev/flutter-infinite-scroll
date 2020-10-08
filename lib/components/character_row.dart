import 'package:flutter/material.dart';
import 'package:infinite_scroll/models/Character.dart';

class CharacterRow extends StatelessWidget {
  const CharacterRow({
    Key key,
    @required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
            image: DecorationImage(
              image: NetworkImage(character.image),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              character.name,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
