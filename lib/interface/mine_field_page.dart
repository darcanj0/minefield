// ignore_for_file: unused_catch_clause
import 'package:flutter/material.dart';
import 'package:minefield/interface/board.dart';
import 'package:minefield/interface/result_app_bar.dart';
import 'package:minefield/models/explosion.dart';
import 'package:minefield/models/mine_field.dart';
import 'package:minefield/models/mine_field_space.dart';

class MineFieldPage extends StatefulWidget {
  const MineFieldPage({
    super.key,
  });

  @override
  State<MineFieldPage> createState() => _MineFieldPageState();
}

class _MineFieldPageState extends State<MineFieldPage> {
  late final MineField mineField = MineField(
    rows: 18,
    columns: 12,
    minesAmmount: ((12 * 18) / 10).floor(),
  );

  bool? won;

  @override
  Widget build(BuildContext context) {
    void reset() {
      setState(() {
        mineField.reset();
        won = null;
      });
    }

    void openSpace(MineFieldSpace space) {
      if (won != null) return;
      setState(() {
        try {
          space.open();
          if (mineField.isResolved) won = true;
        } on ExplosionException catch (e) {
          mineField.revealMines();
          won = false;
        }
      });
    }

    void toggleSpaceMark(MineFieldSpace space) {
      if (won != null) return;
      setState(() {
        space.toggleMark();
        if (mineField.isResolved) won = true;
      });
    }

    return Scaffold(
      appBar: ResultAppBar(
        onReset: reset,
        isResolved: won,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Board(
          mineField: mineField,
          onOpenSpace: openSpace,
          onToggleMarkSpace: toggleSpaceMark,
        );
      }),
    );
  }
}
