void gameState4() {
  //alternative game-mode, mostly for fun, also utilizes the mouse instead of the keyboard.
  if (gameState == 4) {
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
    image(character, mouseX, mouseY);
    //made a velocity variable so that the character does not teleport upward but rather moves in a negative parabolic way.
    characterY = mouseY;
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
      if (characterY < 0 || characterY > height || abs(mouseX - pillarX) <= 50 && pillarY[i] - gap >= characterY+40 || abs(mouseX - pillarX) <= 50 && pillarY[i] + gap <= characterY+40) {
        characterAlive = false;
        gameState = 2;
      }
      if (abs(mouseX - pillarX2) <= 50 && pillarY2[i] - gap >= (characterY+40) || abs(mouseX - pillarX2) <= 50 && pillarY2[i] + gap <= (characterY+40)) {
        characterAlive = false;
        gameState =2;
      }
      if (characterY < 0 || characterY > height || abs(mouseX - pillarX) <= 50 && pillarY[i] - gap >= characterY-40 || abs(mouseX - pillarX) <= 50 && pillarY[i] + gap <= characterY-40) {
        characterAlive = false;
        gameState = 2;
      }
      if (abs(mouseX - pillarX2) <= 50 && pillarY2[i] - gap >= (characterY-40) || abs(mouseX - pillarX2) <= 50 && pillarY2[i] + gap <= (characterY-40)) {
        characterAlive = false;
        gameState =2;
      }
    }
  }       
  // Gives user a point for going through a pillar as well as increases difficulty by reducing gap between top and bottom.
  if ((abs(mouseX - pillarX) <= 5 || abs(mouseX - pillarX2) <= 5) && gameState == 4) {
    characterAlive = true;
    score += 1;
    highScore = max(scoreInt,highScore);
    gap -= 0.25;
  }
  if (seconds > 29 && characterAlive == true && gameState == 4) { // i know the characterAlive boolean is not nessesary, but I put it in as a precausion, incase somehow the game glitches.
    gameState = 3;
  }
}
