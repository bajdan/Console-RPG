//@dart=2.9
import 'dart:math';
import 'package:untitled/models/damage_type.dart';
import 'package:untitled/models/enemys.dart';

abstract class  AbstractEnemyFactory{
  Enemy createEnemy();
}

class SimpleEnemyFactory extends AbstractEnemyFactory{
  @override
  Enemy createEnemy() {
    var rng = Random();
    DamageType damageType;
    DamageType resistType;
    double health = (rng.nextDouble()+1)*30;
    double damage = (rng.nextDouble()+1)*15;
    double armor = (rng.nextDouble()+1)*8;
    switch(rng.nextInt(3)){
      case 0:
        damageType = DamageType.physical;
        break;
      case 1:
        damageType = DamageType.elemental;
        break;
      case 2:
        damageType = DamageType.magical;
        break;
      default:
        damageType = DamageType.physical;
    }
    switch(rng.nextInt(3)){
      case 0:
        resistType = DamageType.physical;
        break;
      case 1:
        resistType = DamageType.elemental;
        break;
      case 2:
        resistType = DamageType.magical;
        break;
      default:
        resistType = DamageType.physical;
    }
    return SimpleEnemy(health, damage, armor, damageType, resistType);
  }
}

class BossEnemyFactory extends AbstractEnemyFactory{
  @override
  Enemy createEnemy() {
    var rng = Random();
    DamageType damageType;
    DamageType resistType;
    double health = (rng.nextDouble()+1)*90;
    double damage = (rng.nextDouble()+1)*35;
    double armor = (rng.nextDouble()+1)*20;
    switch(rng.nextInt(3)){
      case 0:
        damageType = DamageType.physical;
        break;
      case 1:
        damageType = DamageType.elemental;
        break;
      case 2:
        damageType = DamageType.magical;
        break;
      default:
        damageType = DamageType.physical;
    }
    switch(rng.nextInt(3)){
      case 0:
        resistType = DamageType.physical;
        break;
      case 1:
        resistType = DamageType.elemental;
        break;
      case 2:
        resistType = DamageType.magical;
        break;
      default:
        resistType = DamageType.physical;
    }
    return BossEnemy(health, damage, armor, damageType, resistType);
  }

}