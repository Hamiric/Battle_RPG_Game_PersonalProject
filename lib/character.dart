import 'package:battle_rpg_game/monster.dart';

class Character {
  late String name;
  late int hp;
  late int atk;
  late int dfs;

  Character(this.hp, this.atk, this.dfs, {this.name = 'aaa'});

  // 공격 메서드
  // 몬스터에게 공격을 가하여 피해를 입힌다
  void attackMonster(Monster monster){}

  // 방어 메서드
  // 방어시 특정 행동을 수행한다. (예> 대결상대인 몬스터가 입힌 데미지 만큼 캐릭터의 체력을 상승시킨다)
  void defend(){}

  // 상태를 출력하는 메서드
  // 캐릭터의 현재 체력, 공격력, 방어력을 매턴마다 출력
  void showStatus(){}
}