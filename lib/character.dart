import 'package:battle_rpg_game/monster.dart';

class Character {
  late String name;
  late int hp;
  late int atk;
  late int dfs;

  Character(this.hp, this.atk, this.dfs, {this.name = 'aaa'});

  // 공격 메서드
  // 몬스터에게 공격을 가하여 피해를 입힌다
  void attackMonster(Monster monster){
    print('${name}이(가) ${monster.name}에게 ${atk}의 데미지를 입혔습니다.');
    monster.hp -= atk;
  }

  // 방어 메서드
  // 방어시 특정 행동을 수행한다. (예> 상대 몬스터의 공격력 만큼 체력을 얻는다 (회복 아님).)
  void defend(Monster monster){
    print('${name}이(가) 방어 태세를 취하여 ${dfs}만큼 체력을 얻었습니다.');
    hp += monster.atk;
  }

  // 상태를 출력하는 메서드
  // 캐릭터의 현재 체력, 공격력, 방어력을 매턴마다 출력
  void showStatus(){
    print('${name} - 체력 : ${hp}, 공격력 : ${atk}, 방어력 : ${dfs}');
  }

  
}