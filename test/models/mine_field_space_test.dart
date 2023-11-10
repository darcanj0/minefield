import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/mine_field_space.dart';

void main() {
  group('MineFieldSpace', () {
    test('should open field with explosion', () {
      final field = MineFieldSpace(row: 0, column: 0);
      field.mine();
      expect(field.isMined, true);
      expect(field.open, throwsException);
    });

    test('should open field without explosion', () {
      final field = MineFieldSpace(row: 0, column: 0);
      expect(field.isMined, false);
      field.open();
      expect(field.isOpen, true);
    });

    test('should not add non neighbor', () {
      final field = MineFieldSpace(row: 0, column: 0);
      final nonNeighbor = MineFieldSpace(row: 0, column: 2);
      field.addNeighbor(nonNeighbor);
      expect(field.neighbors.isEmpty, true);
    });

    test('should add neighbor', () {
      final field = MineFieldSpace(row: 3, column: 3);
      final neighbor = MineFieldSpace(row: 3, column: 4);
      final neighborTwo = MineFieldSpace(row: 2, column: 2);
      final neighborThree = MineFieldSpace(row: 4, column: 4);

      field.addNeighbor(neighbor);
      field.addNeighbor(neighborTwo);
      field.addNeighbor(neighborThree);
      expect(field.neighbors.length, 3);
    });

    test('should count neighborhood mines correctly', () {
      final field = MineFieldSpace(row: 3, column: 3);
      final neighbor = MineFieldSpace(row: 3, column: 4);
      final neighborTwo = MineFieldSpace(row: 2, column: 2);
      final neighborThree = MineFieldSpace(row: 4, column: 4);
      final neighborFour = MineFieldSpace(row: 4, column: 3);

      field.addNeighbor(neighbor);
      field.addNeighbor(neighborTwo);
      field.addNeighbor(neighborThree);
      field.addNeighbor(neighborFour);

      neighborTwo.mine();
      neighborFour.mine();

      expect(field.safeNeighborhood, false);
      expect(field.countNeighborsMines, 2);
    });
  });
}
