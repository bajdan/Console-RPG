import 'package:untitled/models/damage_type.dart';

abstract class Enemy {
  double _health;
  double _maxHealth;
  DamageType _resistType;
  double _damage;
  double _armor;

  double get health => _health;
  double get maxHealth => _maxHealth;
  double get armor => _armor;
  double get damage => _damage;

  Enemy()
      : _maxHealth = 0,
        _health = 0,
        _resistType = DamageType.physical,
        _damage = 0,
        _armor = 0;

  double attack();

  void takeDamage(double damage, DamageType damageType);
}

class SimpleEnemy extends Enemy {
  SimpleEnemy(double health, double damage, double armor, DamageType damageType,
      DamageType resistType) {
    _health = health;
    _maxHealth = health;
    _damage = damage;
    _armor = armor;
    _resistType = resistType;
  }

  @override
  double attack() {
    return _damage;
  }

  @override
  void takeDamage(double damage, DamageType damageType) {
    if(damageType==_resistType){
      print('У противника сопротивление!');
      print('$_health - ${(damage  - _damage * _armor / 100) / 2}');
      _health -= (damage  - _damage * _armor / 100) / 2;
    }else{
      print('$_health - ${damage - _damage * _armor / 100}');
      _health -= damage - _damage * _armor / 100;
    }
  }
}

class BossEnemy extends Enemy{

  BossEnemy(double health, double damage, double armor, DamageType damageType,
      DamageType resistType) {
    _health = health;
    _maxHealth = health;
    _damage = damage;
    _armor = armor;
    _resistType = resistType;
  }

  @override
  double attack() {
    return _damage * 2;
  }

  @override
  void takeDamage(double damage, DamageType damageType) {
    if(damageType==_resistType){
      print('У противника сопротивление!');
      print('$_health - ${(damage  - _damage * _armor / 100) / 2}');
      _health -= (damage  - _damage * _armor / 100) / 2;
    }else{
      print('$_health - ${damage - _damage * _armor / 100}');
      _health -= damage - _damage * _armor / 100;
    }
  }

}
