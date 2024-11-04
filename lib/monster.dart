import 'package:battle_rpg_game/character.dart';

class Monster {
  late String name;
  late int hp;
  late int atk;
  late int dfs;

  Monster(this.name, this.hp, this.atk, {this.dfs = 0});

  // 공격 메서드
  // 캐릭터에게 공격을 가하며 피해를 입힙니다
  // 캐릭터에게 입히는 데미지는 공격력에서 캐릭터의 방어력을 뺀 값이며, 최소 데미지는 0 이상입니다
  void attackCharacter(Character character) {}

  // 상태를 출력하는 메서드
  // 몬스터의 현재 체력과 공격력을 매 턴마다 출력
  void showStatus() {}
}
