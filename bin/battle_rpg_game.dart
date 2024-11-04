import 'package:battle_rpg_game/game.dart';

void main() async {
  Game a = Game();

  await a.initGame('User');

  print(a.user.name);
  print(a.user.atk);
  print(a.monsterlist[0].name);
}
