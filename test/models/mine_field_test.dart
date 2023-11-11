import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/mine_field.dart';

void main() {
  group('MineField', () {
    test('should win game', () {
      final mineField = MineField(rows: 2, columns: 2, minesAmmount: 0);
      mineField.spaces[0].mine();
      mineField.spaces[3].mine();

      mineField.spaces[0].toggleMark();
      mineField.spaces[1].open();
      mineField.spaces[2].open();
      mineField.spaces[3].toggleMark();
      expect(mineField.isResolved, isTrue);
    });
  });
}
