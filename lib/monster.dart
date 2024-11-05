import 'dart:math';

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
  void attackCharacter(Character character) {
    int calculatedamege = atk - character.dfs;
    int damege = 0;

    if (calculatedamege <= 0) {
      damege = 0;
    } else {
      damege = Random().nextInt(atk - character.dfs);
    }

    print('${name}이(가) ${character.name}에게 ${damege}만큼 데미지를 입혔습니다.');
    character.hp -= damege;
  }

  // 상태를 출력하는 메서드
  // 몬스터의 현재 체력과 공격력을 매 턴마다 출력
  void showStatus() {
    print('${name} - 체력 : ${hp}, 공격력 : ${atk}');
  }
}
