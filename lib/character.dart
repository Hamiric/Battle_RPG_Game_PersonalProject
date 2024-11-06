import 'package:battle_rpg_game/buff.dart';
import 'package:battle_rpg_game/monster.dart';

class Character {
  late String name;
  late int hp;
  late int atk;
  late int dfs;
  bool item = true;

  List<Buff> buffs = [];

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
    Buff itembuff = Buff(true, 0, atk, 0, 1);
    if (item) {
      print('아이템을 사용했습니다! 이번턴동안 공격력이 2배가 됩니다.\n');
      buffs.add(itembuff);
      effectBuff(itembuff);
      item = false;
    } else {
      print('소지한 아이템이 없습니다.\n');
    }
  }

  // 버프 시작시 효과 적용
  void effectBuff(Buff b) {
    if (b.bufftype) {
      if (b.hpamount != 0) {
        hp += b.hpamount;
      } else if (b.atkamount != 0) {
        atk += b.atkamount;
      } else if (b.dfsamount != 0) {
        dfs += b.dfsamount;
      }
    } else {
      if (b.hpamount != 0) {
        hp -= b.hpamount;
      } else if (b.atkamount != 0) {
        atk -= b.atkamount;
      } else if (b.dfsamount != 0) {
        dfs -= b.dfsamount;
      }
    }
  }

  // 턴이 지날때마다 모든 buff 1 감소
  // 버프가 0이 되면, 버프효과 사라짐
  // 다만, 체력증감 버프는 즉효성이므로
  void decreseBuff() {
    for (int i = 0; i < buffs.length; i++) {
      if (buffs[i].buffduration > 0) {
        buffs[i].buffduration--;
      }

      if (buffs[i].buffduration <= 0) {
        if (buffs[i].bufftype) {
          if (buffs[i].hpamount != 0) {
            // hp -= buffs[i].hpamount;
          } else if (buffs[i].atkamount != 0) {
            atk -= buffs[i].atkamount;
          } else if (buffs[i].dfsamount != 0) {
            dfs -= buffs[i].dfsamount;
          }
        } else {
          if (buffs[i].hpamount != 0) {
            // hp += buffs[i].hpamount;
          } else if (buffs[i].atkamount != 0) {
            atk += buffs[i].atkamount;
          } else if (buffs[i].dfsamount != 0) {
            dfs += buffs[i].dfsamount;
          }
        }

        buffs.removeAt(i);
      }
    }
  }

  // 버프를 보여주는 메서드
  void showBuffs(){
    for(int i = 0 ; i < buffs.length ; i ++){
      buffs[i].showBuff(name);
    }
  }

  // 버프 초기화 메서드
  void resetBuff() {
    buffs.clear();
  }
}
