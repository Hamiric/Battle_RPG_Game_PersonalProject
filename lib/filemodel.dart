import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:battle_rpg_game/buff.dart';
import 'package:battle_rpg_game/character.dart';
import 'package:battle_rpg_game/monster.dart';

class FileModel {
  File characterf = File('save/character.txt');
  File monsterf = File('save/monsters.txt');
  File eventf = File('save/event.txt');
  File resultf = File('save/result.txt');

  // 캐릭터 파일 읽는 메서드
  // 캐릭터 -> 체력,공격력,방어력
  Future<Character> readChar() async {
    var charfile = characterf;

    int hp = 0;
    int atk = 0;
    int dfs = 0;

    try {
      Stream<String> lines =
          charfile.openRead().transform(utf8.decoder).transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();

        hp = int.parse(linelist[0]);
        atk = int.parse(linelist[1]);
        dfs = int.parse(linelist[2]);
      }
      return Character(hp, atk, dfs);

    } catch (e) {
      print('캐릭터 파일을 읽는 도중 오류가 발생했습니다. $e');
      print('게임을 정상 진행 할 수 없으므로, 프로그램을 종료합니다.');
      exit(0);
    }
  }

  // 몬스터 파일 읽는 메서드
  // 몬스터의 공격력은 캐릭터의 방어력보다 작을 수 없다
  // 몬스터 -> 이름,체력,공격력
  Future<List<Monster>> readMons(Character c) async {
    var monsfile = monsterf;

    List<Monster> monsterlist = [];

    String name = '';
    int hp = 0;
    int atk = 0;

    try {
      Stream<String> lines =
          monsfile.openRead().transform(utf8.decoder).transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();

        name = linelist[0];
        hp = int.parse(linelist[1]);
        atk = Random().nextInt(int.parse(linelist[2]));

        if(atk < c.dfs) atk = c.dfs;

        monsterlist.add(Monster(
            name, hp, atk));
      }
      return monsterlist;

    } catch (e) {
      print('몬스터 파일을 읽는 도중 오류가 발생했습니다. $e');
      print('게임을 정상 진행 할 수 없으므로, 프로그램을 종료합니다.');
      exit(0);
    }
  }

  // 이벤트 파일 읽는 메서드
  // 이벤트 -> 버프/디버프, 체력증감량, 공격력증감량, 방어력증감량, 지속시간(-1일경우 즉효)
  Future<List<Buff>> readEvent() async {
    var eventfile = eventf;

    List<Buff> eventlist = [];

    try {
      Stream<String> lines = eventfile
          .openRead()
          .transform(utf8.decoder)
          .transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();

        String type = linelist[0];
        int hpamount = int.parse(linelist[1]);
        int atkamount = int.parse(linelist[2]);
        int dfsamount = int.parse(linelist[3]);
        int buffduration = int.parse(linelist[4]);

        bool bufftype = true;
        if (type == 'buff') {
          bufftype = true;
        } else if (type == 'debuff') {
          bufftype = false;
        }

        eventlist
            .add(Buff(bufftype, hpamount, atkamount, dfsamount, buffduration));
      }
      return eventlist;

    } catch (e) {
      print('이벤트 파일을 읽는 도중 오류가 발생했습니다. $e');
      print('게임을 정상 진행 할 수 없으므로, 프로그램을 종료합니다.');
      exit(0);
    }
  }

  // 파일을 저장하는 메서드
  // 목표 파일이 없을경우, 파일을 새로 만든 후 저장
  void saveFile(bool result, Character user) async {
    var f = File('save/result.txt');
    String ending;
    if (result) {
      ending = '승리';
    } else {
      ending = '패배';
    }

    if (await f.exists()) {
      // 정상출력 로그
    } else {
      // result.txt파일 생성 로그
      f.create();
    }

    f.writeAsString('${user.name},${user.hp},${ending}\n',
        mode: FileMode.append);
  }
}
