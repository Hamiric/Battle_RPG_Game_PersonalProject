import 'package:battle_rpg_game/game.dart';

void main() async {
  Game g = Game();
  await g.initGame();

  g.startGame();
}