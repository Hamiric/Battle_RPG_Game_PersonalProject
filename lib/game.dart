import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:battle_rpg_game/character.dart';
import 'package:battle_rpg_game/enumturn.dart';
import 'package:battle_rpg_game/monster.dart';

class Game {
  Character user = Character(0, 0, 0);
  List<Monster> monsterlist = [];
  int clearmonstersnum = 0;

  int battlemonsidx = 0;
  bool result = false;
  bool gameloop = true;

  // 게임을 시작하는 메서드
  // 게임 시작시 사용자가 캐릭터의 이름을 입력한다.
  // <도전> 30% 확률로 캐릭터에게 보너스 체력 제공
  // 캐릭터의 체력이 0이 되면 게임 종료
  // 설정한 몬스터를 물리치면 게임에서 승리
  void startGame() async {
    await initGame();
    inputUserName();

    checkExtraHealth();
    print('게임을 시작합니다!');
    user.showStatus();

    while (gameloop) {
      battle();
    }

    if (monsterlist.isEmpty) {
      print('\n축하합니다! 모든 몬스터를 물리쳤습니다!');
      result = true;
    } else {
      print('\n몬스터와의 싸움에서 지고 말았습니다...');
    }

    if (isSaveResult()) {
      print('결과를 저장합니다.');
      saveFile();
    } else {
      print('결과를 저장하지 않았습니다.');
    }
  }

  // 전투를 진행하는 메서드
  // 게임중 사용자는 매 턴마다 행동을 선택할 수 있다 (ex> 공격하기[1], 방어하기[2])
  // 매 턴마다 몬스터는 사용자에게 공격만 수행한다
  // 캐릭터는 몬스터 리스트에 있는 몬스터들 중 랜덤으로 뽑혀서 대결 진행
  // <도전> 전투 시 캐릭터의 아이템 사용 기능 추가 (일시적 공격력 2배)
  // <도전> 3턴마다 전투중인 몬스터의 방어력 증가 기능 (3턴마다 +2)
  // 처치한 몬스터는 몬스터 리스트에서 삭제
  // 캐릭터의 체력은 대결 간에 누적
  // 몬스터를 물리칠 때마다 다음 몬스터와 대결할 건지 선택 (y/n)
  void battle() {
    Monster battleMonster;
    BattleTurn turn = BattleTurn.startturn;
    int turnnum = 0;

    battleMonster = getRandomMonster();
    user.resetBuff();

    print('\n새로운 몬스터가 나타났습니다!');
    battleMonster.showStatus();

    battle:
    while (true) {
      switch (turn) {
        case BattleTurn.startturn:
          turnnum++;
          print('\n${turnnum}번째 턴입니다!');
          // 4,7,10...
          if (turnnum != 1 && turnnum % 3 == 1) {
            battleMonster.increaseDfs();
          }
          turn = BattleTurn.characterturn;
          break;
        case BattleTurn.characterturn:
          print('\n${user.name}의 턴');
          userSelectAction(battleMonster);
          if (battleMonster.hp <= 0) {
            break battle;
          }
          turn = BattleTurn.monsterturn;
          break;
        case BattleTurn.monsterturn:
          print('\n${battleMonster.name}의 턴');
          battleMonster.attackCharacter(user);
          if (user.hp <= 0) {
            break battle;
          }
          turn = BattleTurn.endturn;
          break;
        case BattleTurn.endturn:
          user.decreseBuff();
          showAllStatus(battleMonster);
          turn = BattleTurn.startturn;
          break;
      }
    }

    if (user.hp <= 0) {
      print('전투 패배..!');
      gameloop = false;
    }

    if (battleMonster.hp <= 0) {
      print('${battleMonster.name}을(를) 물리쳤습니다!\n');
      clearmonstersnum++;
      monsterlist.removeAt(battlemonsidx);

      if (monsterlist.isEmpty) {
        gameloop = false;
      } else {
        gameloop = questNextBattle();
      }
    }
  }

  // 사용자와 battle중인 몬스터의 상태를 모두 보여주는 메서드
  void showAllStatus(Monster battleMonster) {
    user.showStatus();
    battleMonster.showStatus();
  }

  // 사용자의 턴에 행동을 선택하는 메서드
  // 1을 누르면 공격, 2를 누르면 방어를 시전한다 ,3을 누르면 아이템을 사용하고 턴을 유지한다.
  void userSelectAction(Monster battleMonster) {
    String? input;

    bool loop = true;
    while (loop) {
      stdout.write('행동을 선택하세요. (1: 공격, 2: 방어, 3: 아이템사용) : ');
      input = stdin.readLineSync(encoding: utf8);

      switch (input) {
        case '1':
          user.attackMonster(battleMonster);
          loop = false;
          break;
        case '2':
          user.defend(battleMonster);
          loop = false;
          break;
        case '3':
          user.useitem();
          break;
        default:
          print('잘못된 입력입니다. 다시 입력해주세요.');
          break;
      }
    }
  }

  // 다음 몬스터와 싸울지 말지 질문을 하는 메서드
  // y는 다음몬스터와 싸우는것이고, n은 싸우지 않는것
  bool questNextBattle() {
    String? input;

    bool loop = true;
    while (loop) {
      print('다음 몬스터와 싸우시겠습니까? (y/n)');
      input = stdin.readLineSync(encoding: utf8);

      switch (input) {
        case 'y':
          return true;
        case 'n':
          return false;
        default:
          print('y/n 둘중 하나만 입력해주세요.');
          break;
      }
    }
  }

  // 랜덤으로 몬스터를 불러오는 메서드
  // 현재 배틀중인 몬스터의 index 값을 저장
  // Random()을 사용하여 몬스터 리스트에서 랜덤으로 몬스터를 반환
  Monster getRandomMonster() {
    int rndmonsidx = Random().nextInt(monsterlist.length);
    battlemonsidx = rndmonsidx;
    return monsterlist[rndmonsidx];
  }

  // 게임을 시작하기 전 캐릭터와 몬스터를 초기화 하는 비동기 메서드
  // 파일의 데이터는 CSV 형식으로 되어 있다.
  // 예시 ) 캐릭터 -> 체력,공격력,방어력
  //       몬스터 -> 이름,체력,공격력 최대값
  Future<void> initGame() async {
    await readChar(File('save/character.txt'));
    await readMons(File('save/monsters.txt'));
    clearmonstersnum = monsterlist.length;
  }

  // 캐릭터 파일 읽는 메서드
  // 캐릭터 -> 체력,공격력,방어력
  Future<void> readChar(File f) async {
    var charfile = f;

    try {
      Stream<String> lines =
          charfile.openRead().transform(utf8.decoder).transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();

        user.hp = int.parse(linelist[0]);
        user.atk = int.parse(linelist[1]);
        user.dfs = int.parse(linelist[2]);
      }
    } catch (e) {
      print('캐릭터 파일을 읽는 도중 오류가 발생했습니다. $e');
      print('게임을 정상 진행 할 수 없으므로, 프로그램을 종료합니다.');
      exit(0);
    }
  }

  // 몬스터 파일 읽는 메서드
  // 몬스터 -> 이름,체력,공격력 최대값
  Future<void> readMons(File f) async {
    var monsfile = f;

    try {
      Stream<String> lines =
          monsfile.openRead().transform(utf8.decoder).transform(LineSplitter());

      await for (var line in lines) {
        var linelist = line.split(',').toList();

        monsterlist.add(Monster(
            linelist[0], int.parse(linelist[1]), int.parse(linelist[2])));
      }
    } catch (e) {
      print('몬스터 파일을 읽는 도중 오류가 발생했습니다. $e');
      print('게임을 정상 진행 할 수 없으므로, 프로그램을 종료합니다.');
      exit(0);
    }
  }

  // 캐릭터의 이름을 입력받는 메서드
  void inputUserName() {
    RegExp regexp = RegExp(r'^[a-zA-Z가-힣]+$');
    String? name;

    bool loop = true;
    while (loop) {
      stdout.write('캐릭터의 이름을 입력하세요 : ');
      name = stdin.readLineSync(encoding: utf8);

      if (name != null && regexp.hasMatch(name)) {
        loop = false;
      } else {
        print('이름은 빈 문자열이거나, 특수문자나 숫자가 포함되지 않아야 합니다. 다시 입력해 주세요.');
      }
    }

    user.name = name!;
  }

  // 결과를 저장할지 말지 사용자 입력을 받는 메서드
  // y는 저장하기, n는 저장하지 않기
  bool isSaveResult() {
    String? input;

    bool loop = true;
    while (loop) {
      stdout.write('\n결과를 저장하시겠습니까? (y/n) : ');
      input = stdin.readLineSync(encoding: utf8);

      switch (input) {
        case 'y':
          return true;
        case 'n':
          return false;
        default:
          print('y/n 둘중 하나만 입력해주세요.');
          break;
      }
    }
  }

  // 파일을 저장하는 메서드
  // 목표 파일이 없을경우, 파일을 새로 만든 후 저장
  void saveFile() async {
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

  // 30% 확률로 체력을 얻는 이벤트 메서드
  void checkExtraHealth() {
    int rnd = Random().nextInt(10);

    if (rnd < 3) {
      user.addHp();
      print('30% 확률을 통과해 보너스 체력 10을 얻었습니다! 현재 체력: ${user.hp}');
    }
  }
}
