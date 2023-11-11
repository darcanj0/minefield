import 'package:flutter/material.dart';
import 'package:minefield/interface/mine_field_space_card.dart';
import 'package:minefield/interface/result_app_bar.dart';
import 'package:minefield/models/explosion.dart';
import 'package:minefield/models/mine_field_space.dart';

class MineFieldPage extends StatelessWidget {
  const MineFieldPage({super.key});

  void reset() {
    print('reset');
  }

  void openSpace(MineFieldSpace space) {
    print('open');
  }

  void toggleSpaceMark(MineFieldSpace space) {
    print('mark');
  }

  @override
  Widget build(BuildContext context) {
    MineFieldSpace space = MineFieldSpace(row: 10, column: 10);
    MineFieldSpace neighbor = MineFieldSpace(row: 10, column: 11);
    MineFieldSpace neighbor2 = MineFieldSpace(row: 11, column: 11);

    try {
      neighbor.mine();
      neighbor2.mine();
      space.addNeighbor(neighbor);
      space.addNeighbor(neighbor2);
      space.toggleMark();
    } on ExplosionException catch (e) {
      print('boom');
    }
    return Scaffold(
      appBar: ResultAppBar(onReset: reset, isResolved: null),
      body: Container(
        child: MineFieldSpaceCard(
          space: space,
          onOpen: openSpace,
          onMark: toggleSpaceMark,
        ),
      ),
    );
  }
}
