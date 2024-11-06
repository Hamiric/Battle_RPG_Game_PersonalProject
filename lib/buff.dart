import 'package:battle_rpg_game/character.dart';

class Buff {
  bool bufftype = true; // true : 버프, false : 디버프
  int hpamount = 0;
  int atkamount = 0;
  int dfsamount = 0;
  int buffduration = -1; // -1 : 즉효, default : 지속시간

  Buff(this.bufftype, this.hpamount, this.atkamount, this.dfsamount,
      this.buffduration);

  void occurEvent(Character c) {
    c.buffs.add(Buff(bufftype, hpamount, atkamount, dfsamount, buffduration));
    c.effectBuff(Buff(bufftype, hpamount, atkamount, dfsamount, buffduration));

    if (bufftype) {
      if (hpamount != 0) {
        print('좋은 이벤트! ${c.name}은 체력을 ${hpamount}만큼 얻었습니다!');
      } else if (atkamount != 0) {
        print(
            '좋은 이벤트! ${c.name}은 공격력을 ${atkamount}만큼 얻었습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      } else if (dfsamount != 0) {
        print(
            '좋은 이벤트! ${c.name}은 방어력을 ${dfsamount}만큼 얻었습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      }
    } else {
      if (hpamount != 0) {
        print('나쁜 이벤트! ${c.name}은 체력을 ${hpamount}만큼 잃었습니다!');
      } else if (atkamount != 0) {
        print(
            '나쁜 이벤트! ${c.name}은 공격력을 ${atkamount}만큼 잃었습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      } else if (dfsamount != 0) {
        print(
            '나쁜 이벤트! ${c.name}은 방어력을 ${dfsamount}만큼 잃었습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      }
    }
  }

  void showBuff(String c) {
    if (bufftype) {
      if (hpamount != 0) {
        // print('${c}은 체력을 ${hpamount}만큼 얻었다!');
      } else if (atkamount != 0) {
        print(
            '${c}은 공격력을 ${atkamount}만큼 얻고 있습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      } else if (dfsamount != 0) {
        print(
            '${c}은 방어력을 ${dfsamount}만큼 얻고 있습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      }
    } else {
      if (hpamount != 0) {
        // print('${c}은 체력을 ${hpamount}만큼 잃었다!');
      } else if (atkamount != 0) {
        print(
            '${c}은 공격력을 ${atkamount}만큼 잃고 있습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      } else if (dfsamount != 0) {
        print(
            '${c}은 방어력을 ${dfsamount}만큼 잃고 있습니다! 이 효과는 ${buffduration}턴동안 지속됩니다!');
      }
    }
  }
}
