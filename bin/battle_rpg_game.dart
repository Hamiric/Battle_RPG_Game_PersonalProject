import 'package:battle_rpg_game/game.dart';

void main() async {
  Game g = Game();

  await g.initGame();

  print(g.user.name);
  print(g.user.atk);
  print(g.monsterlist[0].name);
}


