//the actual gameplay code.
void gameState1 () {
  if (gameState == 1) {
    //boolean godMode created because it will only shift to gameMode 4 if space is pressed and godMode is true
    if (godMode == true) {
      gameState = 4;
    }
    backgroundLoop(true);
    if (score >= 1.000) {
      fill(#765D25);
      textSize(32);
      scoreInt = round(score);
      text(scoreInt, 100, 100);
    }
    if (seconds <=9) {
      text("00:0"+seconds, 100, 200);
    } else if ( seconds >= 10) {
      text("00:"+seconds, 100, 200);
    }
    imageMode(CENTER);
    image(character, width/4, characterY);
    //made a velocity variable so that the character does not teleport upward but rather moves in a negative parabolic way.
    velocity += 1;
    characterY += velocity;
    if (pillarX < 0) {
      pillarX = width;
    }
    if (pillarX2 < 0) {
      pillarX2 = width;
    }
    strokeWeight(30);
    // For loop is the main part of Gameplay which spawns the pillars as well as checks to see if character hits one of the pillars.
    for (int i = 0; i <pillarY.length; i++) {
      pillarX -= 10;
      pillarX2 -= 10;
      stroke(#38DB23);
      line(pillarX, 0, pillarX, pillarY[i] - gap);
      line(pillarX, height, pillarX, pillarY[i] + gap);
      line(pillarX2, 0, pillarX2, pillarY2[i] - gap);
      line(pillarX2, height, pillarX2, pillarY2[i] + gap);
      if (pillarX < 0) {
        pillarY[i] = random(150, height -150);
      }
      if (pillarX2 < 0) {
        pillarY2[i] = random(150, height -150);
      }
      // set the abs(width/4 - pillarX) values a little bit greater than the actual width of the pillar as it helps offset the accidental times where the bird phases through the pillars.    
      if (characterY < 0 || characterY > height || abs(width/4 - pillarX) <= 50 && pillarY[i] - gap >= characterY+40 || abs(width/4 - pillarX) <= 50 && pillarY[i] + gap <= characterY+40) {
        characterAlive = false;
        gameState = 2;
      }
      if (abs(width/4 - pillarX2) <= 50 && pillarY2[i] - gap >= (characterY+40) || abs(width/4 - pillarX2) <= 50 && pillarY2[i] + gap <= (characterY+40)) {
        characterAlive = false;
        gameState =2;
      }
      if (characterY < 0 || characterY > height || abs(width/4 - pillarX) <= 50 && pillarY[i] - gap >= characterY-40 || abs(width/4 - pillarX) <= 50 && pillarY[i] + gap <= characterY-40) {
        characterAlive = false;
        gameState = 2;
      }
      if (abs(width/4 - pillarX2) <= 50 && pillarY2[i] - gap >= (characterY-40) || abs(width/4 - pillarX2) <= 50 && pillarY2[i] + gap <= (characterY-40)) {
        characterAlive = false;
        gameState =2;
      }
    }
  }       
  // Gives user a point for going through a pillar as well as increases difficulty by reducing gap between top and bottom.
  if ((abs(width/4 - pillarX) <= 5 || abs(width/4 - pillarX2) <= 5) && gameState == 1) {
    characterAlive = true;
    score+= 0.5;
    highScore = max(scoreInt,highScore);
    gap -= 0.25;
  }
  if (seconds > 59 && characterAlive == true) { // i know the characterAlive boolean is not nessesary, but I put it in as a precausion, incase somehow the game glitches.
    gameState = 3;
  }
}
