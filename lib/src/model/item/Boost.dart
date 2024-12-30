class Boost {
  int strength = 0;
  int dexterity = 0;
  int intelligence = 0;
  int health = 0;
  int damage = 0;
  double speed = 0;
  double frequency = 0;
  double experience = 0;

  Boost({
    this.strength = 0,
    this.dexterity = 0,
    this.intelligence = 0,
    this.health = 0,
    this.damage = 0,
    this.speed = 0,
    this.frequency = 0,
    this.experience = 0,
  });

  double getNamed(String name) {
    switch (name) {
      case 'strength':
        return strength.toDouble();
      case 'dexterity':
        return dexterity.toDouble();
      case 'intelligence':
        return intelligence.toDouble();
      case 'health':
        return health.toDouble();
      case 'damage':
        return damage.toDouble();
      case 'speed':
        return speed;
      case 'frequency':
        return frequency;
      case 'experience':
        return experience;
      default:
        return 0;
    }
  }
}