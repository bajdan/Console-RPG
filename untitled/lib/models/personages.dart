import 'package:ansicolor/ansicolor.dart';
import 'package:untitled/models/damage_type.dart';

abstract class Personage {
  double _health;
  double _maxHealth;
  DamageType _damageType;
  double _damage;
  double _armor;
  bool _deBuff;
  bool _buff;

  double get health => _health;

  double get maxHealth => _maxHealth;

  double get damage => _damage;

  double get armor => _armor;

  DamageType get damageType => _damageType;

  bool get deBuff => _deBuff;

  bool get buff => _buff;

  Personage()
      : _maxHealth = 0,
        _health = 0,
        _damageType = DamageType.physical,
        _damage = 0,
        _armor = 0,
        _deBuff = false,
        _buff = false;

  double attack();

  void takeDamage(double damage);

  void setDeBuff() {
    _deBuff = !_deBuff;
  }

  void setBuff() {
    _buff = !_buff;
  }

  void setHealth(double hp){
    _health+=hp;
    if(_health>_maxHealth) _health = _maxHealth;
  }

  void addHealth();
  void addDamage();
  void addArmor();


}

class Archer extends Personage {
  Archer() {
    _health = 80;
    _maxHealth = 80;
    _damage = 120;
    _armor = 10;
    _damageType = DamageType.elemental;
  }

  @override
  double attack() {
    if (_buff) return _damage * 2.5;
    if (_deBuff) return _damage * 1.3;
    return _damage * 2;
  }

  @override
  void takeDamage(double damage) {
    AnsiPen pen = AnsiPen()..red();
    print(pen('Personage $_health - ${damage - damage * _armor / 100}'));
    _health -= damage - (damage / 100 * _armor);
  }

  @override
  void addArmor() {
    _armor += (100 - _armor) / 100 * 10;
  }

  @override
  void addDamage() {
    _damage += _damage * 0.2;
  }

  @override
  void addHealth() {
    _health += 10;
    _maxHealth += 10;
  }
}

class Swordsman extends Personage {
  Swordsman() {
    _health = 180;
    _maxHealth = 180;
    _damage = 100;
    _armor = 50;
    _damageType = DamageType.physical;
  }

  @override
  double attack() {
    return _damage;
  }

  @override
  void takeDamage(double damage) {
    AnsiPen pen = AnsiPen()..red();
    if (_buff) {
      double damageTaken = damage - (damage * _armor / 100) / 1.5;
      if (damageTaken >= 50) damageTaken / 2;
      print(pen('$_health - ${damageTaken}'));
      _health -= damageTaken;
    } else if (_deBuff) {
      double damageTaken = damage - (damage * _armor / 100) * 1.5;
      if (damageTaken >= 50) damageTaken / 2;
      print(pen('$_health - ${damageTaken}'));
      _health -= damageTaken;
    } else {
      double damageTaken = damage - damage * _armor / 100;
      if (damageTaken >= 50) damageTaken / 2;
      print(pen('$_health - ${damageTaken}'));
      _health -= damageTaken;
    }
  }

  @override
  void addArmor() {
    _armor += (100 - _armor) / 100 * 15;
  }

  @override
  void addDamage() {
    _damage += damage * 0.1;
  }

  @override
  void addHealth() {
    _health += 15;
    _maxHealth +=15;
  }
}

class Mage extends Personage {
  Mage() {
    _health = 120;
    _maxHealth = 120;
    _damage = 180;
    _armor = 15;
    _damageType = DamageType.magical;
  }

  @override
  double attack() {
    if (_buff) {
      _health += _damage * 0.35;
      if (_health > _maxHealth) _health = _maxHealth;
      return _damage;
    }
    if (_deBuff) {
      return _damage;
    } else {
      _health += _damage * 0.1;
      if (_health > _maxHealth) _health = _maxHealth;
      return _damage;
    }
  }

  @override
  void takeDamage(double damage) {
    AnsiPen pen = AnsiPen()..red();
    print(pen('$_health - ${damage * _armor / 100}'));
    _health -= damage - damage * _armor / 100;
  }

  @override
  void addArmor() {
    _armor += (100 - _armor) / 100 * 10;
  }

  @override
  void addDamage() {
    _damage += _damage * 0.15;
  }

  @override
  void addHealth() {
    _health += 20;
    _maxHealth +=20;
  }
}
