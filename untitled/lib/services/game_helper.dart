//@dart=2.9
import 'dart:io';
import 'dart:math';
import 'package:ansicolor/ansicolor.dart';
import 'package:untitled/models/enemys.dart';
import 'package:untitled/models/maps.dart';
import 'package:untitled/models/personages.dart';
import 'package:untitled/services/enemy_factory.dart';

class GameHelper {
  SimpleEnemyFactory _simpleEnemyFactory;
  BossEnemyFactory _bossEnemyFactory;
  Personage _personage;
  List<Map> mapList = [];

  GameHelper() {
    _initFactory();
    _initMapList();
    _initPersonage();
  }

  void _initFactory() {
    _simpleEnemyFactory = SimpleEnemyFactory();
    _bossEnemyFactory = BossEnemyFactory();
  }

  void _initPersonage() {
    int userChoice = 0;
    print('Выбор персонажа:');
    print('1 - Лучник');
    print('2- Мечник');
    print('3 - Маг');

    while (true) {
      try {
        userChoice = int.parse(stdin.readLineSync());
      } on Exception catch (_) {
        print('Попробуйте ещё раз!');
      }
      if (userChoice == 1) {
        _personage = Archer();
        break;
      } else if (userChoice == 2) {
        _personage = Swordsman();
        break;
      } else if (userChoice == 3) {
        _personage = Mage();
        break;
      }
    }
  }

  void _initMapList() {
    var rng = Random();
    for (int i = 0; i < 10; i++) {
      List<Enemy> enemyList = [];
      enemyList.add(_simpleEnemyFactory.createEnemy());
      enemyList.add(_simpleEnemyFactory.createEnemy());
      enemyList.add(_simpleEnemyFactory.createEnemy());
      enemyList.add(_simpleEnemyFactory.createEnemy());
      enemyList.add(_bossEnemyFactory.createEnemy());
      int userChoice = rng.nextInt(4);
      switch (userChoice) {
        case (0):
          mapList.add(Castle(enemyList));
          break;
        case (1):
          mapList.add(Prairie(enemyList));
          break;
        case (2):
          mapList.add(Forest(enemyList));
          break;
        case (3):
          mapList.add(Slums(enemyList));
          break;
        case (4):
          mapList.add(Underworld(enemyList));
          break;
        default:
          mapList.add(Prairie(enemyList));
          break;
      }
    }
  }

  void run() {
    for (Map map in mapList) {
      if (_personage.health > 0) {
        _playCard(map);
      }
    }
  }

  void _playCard(Map map) {
    if (_personage is Archer) {
      if (map is Prairie) if (!_personage.buff) _personage.setBuff();
      if (map is Underworld) if (!_personage.buff) _personage.setBuff();
      if (map is Castle) if (!_personage.deBuff) _personage.setDeBuff();
      if (map is Slums) if (!_personage.deBuff) _personage.setDeBuff();
    } else if (_personage is Swordsman) {
      if (map is Prairie) if (!_personage.deBuff) _personage.setDeBuff();
      if (map is Underworld) if (!_personage.deBuff) _personage.setDeBuff();
      if (map is Castle) if (!_personage.buff) _personage.setBuff();
      if (map is Slums) if (!_personage.buff) _personage.setBuff();
    } else if (_personage is Mage) {
      if (map is Forest) if (!_personage.buff) _personage.setBuff();
      if (map is Underworld) if (!_personage.deBuff) _personage.setDeBuff();
    }

    for (Enemy enemy in map.enemys) {
      while (_personage.health > 0 && enemy.health > 0) {
        _printPersonageStats();
        _printEnemyStats(enemy);
        enemy.takeDamage(_personage.attack(), _personage.damageType);

        if (enemy.health > 0) {
          _personage.takeDamage(enemy.attack());
        }
      }
    }

    if (_personage.health > 0) {
      _giveRevard();
    } else {
      _printLoseScreen();
    }
  }

  void _giveRevard() {
    int userChoice;
    _printCards();

    _personage.setHealth(50);
    if (_personage.buff) _personage.setBuff();
    if (_personage.deBuff) _personage.setDeBuff();

    print('\nСделайте выбор:');

    while (true) {
      try {
        userChoice = int.parse(stdin.readLineSync());
      } on Exception catch (_) {
        print('Попробуйте ещё раз!');
      }

      if (userChoice == 1) {
        _personage.addDamage();
        break;
      } else if (userChoice == 2) {
        _personage.addArmor();
        break;
      } else if (userChoice == 3) {
        _personage.addHealth();
        break;
      }
    }
  }

  void _printPersonageStats() {
    AnsiPen greenPen = AnsiPen()..green();
    AnsiPen bluePen = AnsiPen()..blue();
    AnsiPen redPen = AnsiPen()..red();
    print('.');
    if (_personage is Archer) print('Лучник');
    if (_personage is Swordsman) print('Мечник');
    if (_personage is Mage) print('Маг');
    print(greenPen('Health: ${_personage.health}/${_personage.maxHealth}'));
    print(bluePen('Armor:  ${_personage.armor}'));
    print(redPen('Damage: ${_personage.damage}'));
  }

  void _printEnemyStats(Enemy enemy) {
    print('.');
    if (enemy is SimpleEnemy) print('Обычный противник');
    if (enemy is BossEnemy) print('Босс');
    AnsiPen greenPen = AnsiPen()..green();
    AnsiPen bluePen = AnsiPen()..blue();
    AnsiPen redPen = AnsiPen()..red();
    print(greenPen('Health: ${enemy.health}/${enemy.maxHealth}'));
    print(bluePen('Armor:  ${enemy.armor}'));
    print(redPen('Damage: ${enemy.damage}'));
  }

  void _printCards() {
    AnsiPen greenPen = AnsiPen()..green();
    AnsiPen bluePen = AnsiPen()..blue();
    AnsiPen redPen = AnsiPen()..red();
    print(redPen('|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|') +
        ' ' +
        bluePen('|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|') +
        ' ' +
        greenPen('|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|'));
    print(redPen('| 1       /\\          |') +
        ' ' +
        bluePen('| 2   |‾‾‾‾‾‾‾‾|      |') +
        ' ' +
        greenPen('| 3     |‾‾‾|         |'));
    print(redPen('|        |  |         |') +
        ' ' +
        bluePen('|     |        |      |') +
        ' ' +
        greenPen('|    ___|   |___      |'));
    print(redPen('|        |  |         |') +
        ' ' +
        bluePen('|     |        |      |') +
        ' ' +
        greenPen('|   |           |     |'));
    print(redPen('|        |  |         |') +
        ' ' +
        bluePen('|     |        |      |') +
        ' ' +
        greenPen('|    ‾‾‾|   |‾‾‾      |'));
    print(redPen('|        |  |         |') +
        ' ' +
        bluePen('|     \\        /      |') +
        ' ' +
        greenPen('|       |___|         |'));
    print(redPen('|      ========       |') +
        ' ' +
        bluePen('|      \\______/       |') +
        ' ' +
        greenPen('|                     |'));
    print(redPen('|         ||          |') +
        ' ' +
        bluePen('|                     |') +
        ' ' +
        greenPen('|                     |'));
    print(redPen('|                     |') +
        ' ' +
        bluePen('|                     |') +
        ' ' +
        greenPen('|                     |'));
    print(redPen('|     add damage      |') +
        ' ' +
        bluePen('|     add armor       |') +
        ' ' +
        greenPen('|     add health      |'));
    print(redPen('|_____________________|') +
        ' ' +
        bluePen('|_____________________|') +
        ' ' +
        greenPen('|_____________________|'));
  }

  void _printLoseScreen() {
    AnsiPen redPen = AnsiPen()..red();
    print(redPen('YOU DIED'));
    print(redPen('*звук из Dark Souls*'));
  }
}
