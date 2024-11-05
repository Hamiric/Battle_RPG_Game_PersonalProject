import 'package:battle_rpg_game/monster.dart';

class Character {
  late String name;
  late int hp;
  late int atk;
  late int dfs;
  bool item = true;
  bool buff = false;

  Character(this.hp, this.atk, this.dfs, {this.name = 'aaa'});

  // 공격 메서드
  // 몬스터에게 공격을 가하여 피해를 입힌다
  void attackMonster(Monster monster) {
    print('${name}이(가) ${monster.name}에게 ${atk}의 데미지를 입혔습니다.');
    monster.hp -= atk;
  }

  // 방어 메서드
  // 방어시 특정 행동을 수행한다. (예> 상대 몬스터의 공격력 만큼 체력을 얻는다 (회복 아님).)
  void defend(Monster monster) {
    print('${name}이(가) 방어 태세를 취하여 ${monster.atk}만큼 체력을 얻었습니다.');
    addHp(monster.atk);
  }

  // 상태를 출력하는 메서드
  // 캐릭터의 현재 체력, 공격력, 방어력을 매턴마다 출력
  void showStatus() {
    print('${name} - 체력 : ${hp}, 공격력 : ${atk}, 방어력 : ${dfs}');
  }

  // 체력 회복 메서드
  void addHp([int heal = 10]) {
    hp += heal;
  }

  // 아이템을 사용하는 메서드
  // 아이템이 사용되면, 버프가 생성되며 버프 효과적용
  void useitem() {
    if (item) {
      print('아이템을 사용했습니다! 이번턴동안 공격력이 2배가 됩니다.\n');
      item = false;
      atk *= 2;
      buff = true;
    } else {
      print('소지한 아이템이 없습니다.\n');
    }
  }

  // 턴이 지날때마다 buff 1 감소
  // 버프가 0이 되면, 버프효과 사라짐
  void decresebuff() {
    if (buff) {
      buff = false;
      atk ~/= 2;
    }
  }

  // 버프 초기화 메서드
  void resetbuff(){
    buff = false;
  }
}
