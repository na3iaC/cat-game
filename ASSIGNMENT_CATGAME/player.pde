class Player {
  PImage[] catPlayer = new PImage[3];


  int x;
  int y;
  int imgCounter;
  float easing =1;

  Player(int x, int y) {

    this.x=x;
    this.y=y;
    for (int i = 0; i < 3; i++) {
      catPlayer[i] = loadImage("player" + (i+1) + ".png");
    }
  }

  void render() {
    imageMode(CENTER);
    float targetX=mouseX;
    float dx= targetX-x;
    x+=dx*easing;

    float targetY = mouseY;
    float dy = targetY - y;
    y += dy * easing;


    image(catPlayer[imgCounter/15 % catPlayer.length], x, y);

    imgCounter++;
  }
  boolean crash(Zombie catZombie) {

    return abs(this.x-catZombie.x) < catPlayer[1].width && abs(this.y- catZombie.y) < catPlayer[1].height;
  }


  boolean collision(ExplodingZombie catExplode) {

    return abs(this.x-catExplode.x) < catPlayer[1].width && abs(this.y- catExplode.y) < catPlayer[1].height-5;
  }
}
