import 'dart:math';

import 'package:minefield/models/mine_field_space.dart';

class MineField {
  final int rows;
  final int columns;
  final int minesAmmount;

  final List<MineFieldSpace> _spaces = [];

  MineField({
    required this.rows,
    required this.columns,
    required this.minesAmmount,
  }) {
    assert(minesAmmount < rows * columns);
    createSpaces();
    linkNeighbors();
    defineMines();
  }

  List<MineFieldSpace> get spaces => [..._spaces];

  bool get isResolved => _spaces.every((element) => element.isResolved);

  void reset() {
    for (var element in _spaces) {
      element.reset();
    }
    defineMines();
  }

  void revealMines() {
    for (var element in _spaces) {
      element.revealMine();
    }
  }

  void createSpaces() {
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        _spaces.add(
          MineFieldSpace(row: row, column: column),
        );
      }
    }
  }

  void linkNeighbors() {
    for (var space in _spaces) {
      for (var neighbor in _spaces) {
        space.addNeighbor(neighbor);
      }
    }
  }

  void defineMines() {
    int randomized = 0;
    while (randomized < minesAmmount) {
      int index = Random().nextInt(_spaces.length);
      if (!_spaces[index].isMined) {
        _spaces[index].mine();
        randomized++;
      }
    }
  }
}
