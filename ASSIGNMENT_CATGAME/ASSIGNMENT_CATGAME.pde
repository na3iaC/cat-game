import java.util.Arrays;
import java.util.Collections;

PImage backGround;

Player player;
Goal house;
final int PLAYING = 0;
final int FINISHED = 1;
int gameMode = PLAYING;
int hitCounter=0;
int score =0;



ArrayList<Zombie> ZombieList = new ArrayList<>();
ArrayList<ExplodingZombie> ExplodeZombieList = new ArrayList<>();

void scoreboard() {
}


void setup() {





  size(300, 700);
  backGround = loadImage("gamebackgroundplain.png");
  backGround.resize(width, height);


  house = new Goal();
  spawn();



  player = new Player(20, 20);
}
void spawn() {
  for (int i = 0; i < 8; i++) {
    ZombieList.add( new Zombie((int) random(10, width-10), (int) random(500, height-10), 0.5) );
  }

  for (int i = 0; i < 7; i++) {
    ExplodeZombieList.add( new ExplodingZombie((int) random(0, width), (int) random(70, height-200), 1) );
  }
}
void draw() {


  if (gameMode==PLAYING) {
    imageMode(CORNER);
    image(backGround, 0, 0);

    gameStart();
  } else {
    imageMode(CORNER);
    image(backGround, 0, 0);
    gameOver();
  }
}

void gameOver() {

  String[] scores=loadStrings("scoreboard.txt");
  ArrayList<Integer> highscores = new ArrayList<Integer>(scores.length);


  for (String s : scores) {
    highscores.add(Integer.valueOf(s));
  }
  highscores.add(score);
  Collections.sort(highscores);


  ArrayList<String>StrHighscores = new ArrayList<String>();
  for (int s : highscores) {
    StrHighscores.add(String.valueOf(s));
  }
  String[] sortedHighscores = StrHighscores.toArray(new String[StrHighscores.size()]);

  saveStrings("scoreboardSorted.txt", sortedHighscores);


  backGround = loadImage("gameover.png");
  text("Highest Score: "+Collections.max(highscores), 80, 400);
  text("Your Score: "+score, 100, 300);
  for (int i = ZombieList.size()-1; i>=0; i--) {
    Zombie currentZombie = ZombieList.get(i);
    ZombieList.remove(currentZombie);
  }







  if (keyPressed) {
    if (key == ' ') {
      score=0;
      gameMode=PLAYING;


      for (int i = ExplodeZombieList.size()-1; i>=0; i--) {
        ExplodingZombie currentExplodingZombie = ExplodeZombieList.get(i);
        ExplodeZombieList.remove(currentExplodingZombie);
      }
      spawn();
    }
  }
}

void gameStart() {

  backGround = loadImage("gamebackgroundplain.png");
  backGround.resize(width, height);

  for (int i = ZombieList.size()-1; i>=0; i--) {
    Zombie currentZombie = ZombieList.get(i);
    currentZombie.update();
    if (house.end(currentZombie)) {

      gameMode=FINISHED;
    }
  }
  for (int i = ExplodeZombieList.size()-1; i>=0; i--) {
    ExplodingZombie currentExplodingZombie = ExplodeZombieList.get(i);
    currentExplodingZombie.update();
    if (player.collision(currentExplodingZombie)) {
      gameMode=FINISHED;
    }
  }
  boolean empty = ZombieList.isEmpty();
  if (empty == true) {
    spawn();

    for (int i = ZombieList.size()-1; i>=0; i--) {
      Zombie currentZombie = ZombieList.get(i);
      currentZombie.speed = currentZombie.speed * (int)random(1, 3);
    }
  }


  house.render();

  player.render();
  textSize(20);
  text("SCORE: "+score, 20, 30);
}



void mouseClicked() {

  for (int i = ZombieList.size()-1; i>=0; i--) {
    Zombie currentZombie = ZombieList.get(i);
    currentZombie.update();
    if (player.crash(currentZombie)) {
      hitCounter=hitCounter+1;
    }
    if (hitCounter==2) {
      ZombieList.remove(currentZombie);
      hitCounter=0;
      score=score+10;
    }
  }
}
