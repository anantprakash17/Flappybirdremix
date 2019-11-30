//Anant Prakash
//Culminating Program
//June 14th 2018
//Game that has similar mechanics to the infamous Flappy Bird.
import javax.swing.JOptionPane;
int  gameState, characterY, velocity, gap, startTime, seconds, ms, scoreInt, highScore;
float backgroundX, pillarX, score, pillarX2;
PImage backgroundImage, character;
float [] pillarY = new float [1];
float [] pillarY2 = new float [1];
boolean characterAlive, godMode;
String input;
void setup () {
  //limited frameRate to 45 beacuse the computer doesn't run the game at 60 anyways, and therefore setting the frameRate at 45 avoids the certain places where the game actually runs at 60 fps.
  frameRate(50);
  gameState=0;
  score= -0.5;
  scoreInt =0;
  gap=175;
  backgroundX=0;
  characterY = height/2;
  pillarX =  3*(width/4);
  pillarX2 = width;
  pillarY[0] = height/4;
  pillarY2[0] = height/2;
  fullScreen();
  backgroundImage = loadImage("background.png");
  character = loadImage("character.png");
  character.resize(character.width/3, character.height/3);
  backgroundImage.resize(width, height);
}
void draw () {
  //created timer using millis() because frameCount can be inaccurate due to frame drops.
  ms = millis()-startTime;
  seconds = ms/1000;
  //main portions of the game split into different funtions for better organization.
  gameState0();
  gameState1();
  gameState2();
  gamseState3();
  gameState4();
}
// function with a prameter that moves the background only if the game is running, not the start and end screens.
void backgroundLoop (boolean isBackgroundLooping) {
  if (isBackgroundLooping == true) {
    imageMode(CORNERS);
    background(0);
    image(backgroundImage, backgroundX, 0);
    image(backgroundImage, backgroundX + backgroundImage.width, 0);
    backgroundX -=5;
    if (backgroundX < -width) {
      backgroundX = 0;
    }
  } 
  if (isBackgroundLooping == false) {
    imageMode(CORNERS);
    image(backgroundImage, 0, 0);
  }
}
//first page that user can see when program is opened
void gameState0() {
  if (gameState == 0) {
    backgroundLoop(false);
    textSize(72);
    fill(#765D25);
    text("Jumpy Bean", width/2 - 165, height/4);
    fill(#FAFF00);
    strokeWeight(2);
    stroke(0);
    fill(#765D25);
    textSize(32);
    text("Press 'i' for instructions", width/2-150, height/4+100);
    text("High score: " + highScore, width/2-80, height/4+155);
    text("Press space to start", width/2-125, height/4+215);
  }
}
//end of the game page that user sees if timer ends or user loses the game.
void gameState2() {
  if (gameState == 2) {
    backgroundLoop(false);
    fill(#765D25);
    textSize(32);
    text("game over :(", width/2-100, height/2 - 70);
    int scoreInt = round(score);
    text("Score " + scoreInt, width/2-55, height/2 -10 );
    text("to go back to main menu, press 'r'", width/2-290, height/2+ 50);
    strokeWeight(3);
    stroke(0);
    fill(#FAFF00);
    rect(width/2-120, 3*(height/4)-40, 275, 75);
    fill(#765D25);
    text("bored? click here", width/2-115, 3*(height/4));
  }
}
// alternative end-game page, if user lasts the entire minute.
void gamseState3() {
  if (gameState == 3) {
    backgroundLoop(false);
    fill(#765D25);
    textSize(73);
    text("you win!", width/2-200, height/2);
  }
}
void keyPressed() {

  if (gameState == 0 && key == ' ') {
    gameState = 1;
    startTime = millis();
  }
  if (gameState == 0 && key == 'i') {
    JOptionPane.showMessageDialog(frame, "Welcome to Jumpy Bean, Maybe. \nbasic rules: \n1) use space or click to jump \n 2) if you hit the pillars, the game ends(if you manage to avoid them for a minute, you win!) \n3) there is another mode in this game which will be made available after the first round. \n\n to start,press space");
  }
  if ((gameState == 1 || gameState == 4)&& key == ' ') {
    velocity =  -18;
  }
  if ((gameState == 2 || gameState == 3) && key == 'r') {
    if (godMode == true) {
      godMode = false;
    }
    setup();
  }
  //checks if user inputs the correct code to change game mode.
  if (gameState == 0 && key =='g') {
    input = JOptionPane.showInputDialog(frame, "enter cheat code");
    if (input!=null) {
      if (input.equals("godmode")) {
        JOptionPane.showMessageDialog(frame, "GOD MODE ACTIVATED");
        JOptionPane.showMessageDialog(frame, "In this mode, you can use your mouse to control the character! Good luck! \nThis game mode will last 30 seconds at which point you win! \n\n P.S: you can get more than one point per pillar, figure it out!");
        godMode = true;
      } else if (input.equals("godmode") == false || input.equals(null)) {
        JOptionPane.showMessageDialog(frame, "incorrect cheat code :(");
        godMode = false;
      }
    }
  }
}
void mousePressed () {
  if (gameState == 1) {
    velocity = -18;
  }
  if (gameState == 3) {
    gameState = 0;
  }

  if (gameState == 2 && mouseX >=width/2-115 && mouseX <=(width/2-100) +390 && mouseY >= 3*(height/4)-40 && mouseY <= 3*(height/4)+75) {
    JOptionPane.showMessageDialog(frame, "to activate the new mode, go back to the main menu, press 'g' and enter 'godmode' into the box. \n\n P.S: it needs to be reactivated every time you die.");
  }
}
