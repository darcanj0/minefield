import 'package:flutter/material.dart';
import 'package:minefield/models/mine_field_space.dart';

class MineFieldSpaceCard extends StatelessWidget {
  const MineFieldSpaceCard({
    required this.space,
    required this.onOpen,
    required this.onMark,
    super.key,
  });

  final MineFieldSpace space;
  final Function onOpen;
  final Function onMark;

  Widget get image {
    if (space.isOpen && space.isMined && space.isExploded) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (space.isOpen && space.isMined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (space.isOpen) {
      return Image.asset(
          'assets/images/aberto_${space.countNeighborsMines}.jpeg');
    } else if (space.isMarked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(space),
      onLongPress: () => onMark(space),
      child: image,
    );
  }
}
