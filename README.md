# Battle RPG GAME
개인 과제 - 전투 RPG 게임

## 프로젝트 소개
아래의 기능들이 있는 전투 RPG 게임

<img src='Flowchart.png'>
<br></br>

< 필수 기능 > 
1. 파일로부터 데이터 읽어오기
2. 캐릭터 이름 입력받기
3. 게임 종료 후 결과를 파일에 저장

< 도전 기능 >
1. 게임 시작시 캐릭터 체력 증가 기능
2. 아이템 사용 기능
3. 3턴 마다 몬스터 방어력 증가 기능
4. 자유 구현

## 적용 기능
#### < 필수 기능 >
>* 파일로부터 데이터 읽어오기 : 
<br>txt 파일에 CSV 형식으로 되어 있는 캐릭터, 몬스터 데이터를 읽어오는 기능<br><br>
>* 캐릭터 이름 입력받기 : 
<br>게임 시작시 캐릭터의 이름을 입력받는 기능<br><br>
>* 게임 종료 후 결과를 파일에 저장 : 
<br>게임 종료 후 결과를 result 파일에 CSV 형식으로 저장하는 기능
#### < 도전 기능 >
>* 게임 시작시 캐릭터 체력 증가 :
<br>게임을 시작할때, 30% 확률로 캐릭터의 체력을 증가 시키는 기능<br><br>
>* 아이템 사용 :
<br>캐릭터는 시작할때 공격력을 한턴동안 2배 증가시키는 아이템을 가지고 있고, 이를 사용할시 해당 능력이 적용되는 기능<br><br>
>* 3턴 마다 몬스터 방어력 증가 기능 :
<br>몬스터와의 전투가 길어질 경우, 몬스터의 전투중인 몬스터의 방어력을 증가시키는 기능
#### < 자유 구현 >
>* 이벤트 발생 기능 : 
<br>몬스터와의 전투 중간중간에 이밴트가 발생. 이밴트들은 캐릭터에게 버프 혹은 디버프를 부여하는 기능<br><br>
> * 캐릭터 버프/디버프 : 
<br>캐릭터에게 부여된 버프/디버프는 지속시간을 가지며, 그에 맞는 효과를 캐릭터에게 부여하는 기능

## 🚨 Trouble Shooting

<details>
<summary>📚[ Random함수, 파일입출력, 정규표현식, 함수의 매개변수 ] 에 대한 학습 및 고찰</summary>
<div markdown="1">

### [TIL - 전투 RPG 게임(Random함수, 파일입출력, 정규표현식)](https://hamiric.tistory.com/44)

 <br>
</div>
</details>

<details>
<summary>🎨자잘한 코드 개선 1차</summary>
<div markdown="1">

### [TIL - 코드개선 1차](https://hamiric.tistory.com/45)

 <br>
</div>
</details>

<details>
<summary>🎨자유기능 추가 및 코드 개선 2차</summary>
<div markdown="1">

### [TIL - 자유기능 추가 및 코드 개선2](https://hamiric.tistory.com/46)

 <br>
</div>
</details>

## 📝Technologies & Tools (FE)

![Dart Version](https://img.shields.io/badge/Dart-3.5.4-brightgreen)
![VSCode Version](https://img.shields.io/badge/VSCode-1.95.0-blue)