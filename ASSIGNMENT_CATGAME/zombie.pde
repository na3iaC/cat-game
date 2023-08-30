class Zombie extends Enemy {




  PImage[] catZombie = new PImage[3];

  Zombie(int x, int y, float s) {
    super(x, y, s);


    for (int i = 0; i < 3; i++) {
      catZombie[i] = loadImage("zombie" + (i+1) + ".png");
    }
  }

  void update() {
    move();
    display();
  }

  void move() {


    y -= speed;

    if (y < 150-catZombie[0].height) {
      y = height;
    }
  }

  void display() {
    imageMode(CORNER);
    image(catZombie[imgCounter/15 % catZombie.length], x, y);

    imgCounter++;
  }
}
