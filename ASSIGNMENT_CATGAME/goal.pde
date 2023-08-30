class Goal {
  final int x = 150;
  final int y =100;
  PImage goal = loadImage("houseland.png");



  void render() {
    imageMode(CENTER);
    image(goal, x, y);
  }


  boolean end(Zombie catZombie) {

    return abs(y+goal.height/2- catZombie.y) < goal.height/2-65;
  }
}
