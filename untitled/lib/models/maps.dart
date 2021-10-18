//@dart=2.9
import 'package:untitled/models/enemys.dart';

abstract class Map {
  List<Enemy> enemys;

  Map(List<Enemy> enemys);
}

class Castle extends Map {
  Castle(List<Enemy> enemys) : super(enemys){
    this.enemys = enemys;
  }
}

class Prairie extends Map{
  Prairie(List<Enemy> enemys) : super(enemys){
    this.enemys = enemys;
  }
}

class Forest extends Map{
  Forest(List<Enemy> enemys) : super(enemys){
    this.enemys = enemys;
  }
}

class Slums extends Map{
  Slums(List<Enemy> enemys) : super(enemys){
    this.enemys = enemys;
  }
}

class Underworld extends Map{
  Underworld(List<Enemy> enemys) : super(enemys){
    this.enemys = enemys;
  }
}