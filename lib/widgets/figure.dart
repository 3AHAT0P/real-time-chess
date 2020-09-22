import 'package:flutter/material.dart';

import 'package:chess/models/main.dart';

Map<FigureType, String> _whiteFigureImageUrl = {
  FigureType.pawn: 'w_pawn_png_shadow_256px.png',
  FigureType.knight: 'w_knight_png_shadow_256px.png',
  FigureType.bishop: 'w_bishop_png_shadow_256px.png',
  FigureType.rook: 'w_rook_png_shadow_256px.png',
  FigureType.queen: 'w_queen_png_shadow_256px.png',
  FigureType.king: 'w_king_png_shadow_256px.png',
};

Map<FigureType, String> _blackFigureImageUrl = {
  FigureType.pawn: 'b_pawn_png_shadow_256px.png',
  FigureType.knight: 'b_knight_png_shadow_256px.png',
  FigureType.bishop: 'b_bishop_png_shadow_256px.png',
  FigureType.rook: 'b_rook_png_shadow_256px.png',
  FigureType.queen: 'b_queen_png_shadow_256px.png',
  FigureType.king: 'b_king_png_shadow_256px.png',
};

class FigureWidget extends StatelessWidget {
  final Figure model;
  final String imageName;

  FigureWidget({Key key, this.model}):
    imageName = (model.color == FigureColor.white ? _whiteFigureImageUrl : _blackFigureImageUrl)[model.type],
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      'assets/images/$imageName',
      fit: BoxFit.cover,
    );
  }
}