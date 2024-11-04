import 'dart:convert';
import 'dart:io';

import 'package:battle_rpg_game/character.dart';
import 'package:battle_rpg_game/monster.dart';

class Game {
  Character user = Character(0, 0, 0);
  List<Monster> monsterlist = [];
  int clearmonstersnum = 0;

  // 게임을 시작하는 메서드
  // 캐릭터의 체력이 0이 되면 게임 종료
  // 몬스터를 물리칠 때마다 다음 몬스터와 대결할 건지 선택 (y/n)
  // 설정한 몬스터를 물리치면 게임에서 승리
  void startGame() {}

  // 전투를 진행하는 메서드
  // 게임중 사용자는 매 턴마다 행동을 선택할 수 있다 (ex> 공격하기[1], 방어하기[2])
  // 매 턴마다 몬스터는 사용자에게 공격만 수행한다
  // 캐릭터는 몬스터 리스트에 있는 몬스터들 중 랜덤으로 뽑혀서 대결 진행
  // 처치한 몬스터는 몬스터 리스트에서 삭제
  // 캐릭터의 체력은 대결 간에 누적
  void battle() {}

  // 랜덤으로 몬스터를 불러오는 메서드
  // Random()을 사용하여 몬스터 리스트에서 랜덤으로 몬스터를 반환
  void getRandomMonster() {}

  // 게임을 시작하기 전 캐릭터와 몬스터를 초기화 하는 비동기 메서드
  // 파일의 데이터는 CSV 형식으로 되어 있다.
  // 예시 ) 캐릭터 -> 체력,공격력,방어력
  //       몬스터 -> 이름,체력,공격력 최대값
  Future<void> initGame(String name) async {
    await readchar(File('save/character.txt'), user);
    await readmons(File('save/monsters.txt'), monsterlist);
    user.name = name;
    clearmonstersnum = monsterlist.length;
  }

  // 캐릭터 파일 읽는 메서드
  // 캐릭터 -> 체력,공격력,방어력
  Future<Character> readchar(File f, Character char) async {
    var charfile = f;

    try {
      Stream<String> lines =
          charfile.openRead().transform(utf8.decoder).transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();
       
        char.hp = int.parse(linelist[0]);
        char.atk = int.parse(linelist[1]);
        char.dfs = int.parse(linelist[2]);
      }
    } catch (e) {
      print('캐릭터 파일을 읽는 도중 오류가 발생했습니다. $e');
    }

    return char;
  }

  // 몬스터 파일 읽는 메서드
  // 몬스터 -> 이름,체력,공격력 최대값
  Future<List<Monster>> readmons(File f, List<Monster> mons) async {
    var monsfile = f;

    try {
      Stream<String> lines =
          monsfile.openRead().transform(utf8.decoder).transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();

        mons.add(Monster(
            linelist[0], int.parse(linelist[1]), int.parse(linelist[2])));
      }
    } catch (e) {
      print('몬스터 파일을 읽는 도중 오류가 발생했습니다. $e');
    }

    return mons;
  }
}
