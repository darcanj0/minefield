import 'package:minefield/models/explosion.dart';

class MineFieldSpace {
  final int row;
  final int column;
  final List<MineFieldSpace> neighbors = [];

  bool _isOpen = false;
  bool get isOpen => _isOpen;

  bool _isMarked = false;
  bool get isMarked => _isMarked;

  bool _isExploded = false;
  bool get isExploded => _isExploded;

  bool _isMined = false;
  bool get isMined => _isMined;

  void addNeighbor(MineFieldSpace space) {
    final rowDelta = (row - space.row).abs();
    final columnDelta = (column - space.column).abs();
    if (rowDelta == 0 && columnDelta == 0) {
      return;
    }
    if (rowDelta <= 1 && columnDelta <= 1) {
      neighbors.add(space);
    }
  }

  void open() {
    if (_isOpen) return;
    _isOpen = true;
    if (_isMined) {
      _isExploded = true;
      throw ExplosionException();
    }
    if (safeNeighborhood) {
      neighbors.forEach((space) {
        space.open();
      });
    }
  }

  void revealMine() {
    if (_isMined) {
      _isOpen = true;
    }
  }

  void mine() {
    _isMined = true;
  }

  void toggleMark() {
    _isMarked = !_isMarked;
  }

  void reset() {
    _isOpen = false;
    _isMarked = false;
    _isExploded = false;
    _isMined = false;
  }

  int get countNeighborsMines =>
      neighbors.where((element) => element.isMined).length;

  bool get isResolved {
    bool minedAndMarked = _isMined && _isMarked;
    bool safeAndOpen = !_isMined && _isOpen;
    return (minedAndMarked || safeAndOpen);
  }

  bool get safeNeighborhood => neighbors.every((element) => !element.isMined);

  MineFieldSpace({
    required this.row,
    required this.column,
  });
}
