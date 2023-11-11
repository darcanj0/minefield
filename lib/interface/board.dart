import 'package:flutter/material.dart';
import 'package:minefield/interface/mine_field_space_card.dart';
import 'package:minefield/models/mine_field.dart';
import 'package:minefield/models/mine_field_space.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
    required this.mineField,
    required this.onOpenSpace,
    required this.onToggleMarkSpace,
  });

  final MineField mineField;
  final void Function(MineFieldSpace) onOpenSpace;
  final void Function(MineFieldSpace) onToggleMarkSpace;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: mineField.columns,
      children: mineField.spaces.map((e) {
        return MineFieldSpaceCard(
          space: e,
          onMark: onToggleMarkSpace,
          onOpen: onOpenSpace,
        );
      }).toList(),
    );
  }
}
