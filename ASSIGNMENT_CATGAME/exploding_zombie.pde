class ExplodingZombie extends Enemy {



  PImage[] catExplode = new PImage[3];
  ExplodingZombie(int x, int y, float s) {

    super(x, y, s);

    for (int i = 0; i < 3; i++) {
      catExplode[i] = loadImage("explodecat" + (i+1) + ".png");
    }
  }
  void update() {
    if (y > 50-catExplode[0].height) {
      move();
      display();
    }
  }

  void move() {


    y += 1;
  }

  void display() {
    imageMode(CORNER);
    image(catExplode[imgCounter/15 % catExplode.length], x, y);

    imgCounter++;
  }
}
