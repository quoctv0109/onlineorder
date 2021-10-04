import 'package:onlineorder/models/character_summary.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlineorder/page_app_theme.dart';

/// List item representing a single Character with its photo and name.
class CharacterListItemQr extends StatelessWidget {
  const CharacterListItemQr({
    required this.character,
    Key? key,
  }) : super(key: key);

  final CharacterSummary character;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(0.0),//or 15.0
      child: Container(
        height: 100.0,
        width: 80.0,
        color: Colors.transparent,
        child: Image.asset("assets/fitness_app/qr-code.png", width: 100, height: 80),
      ),
    ),
    title: Text("Bàn 1"),
    onTap: () => {
    },
  );
}
