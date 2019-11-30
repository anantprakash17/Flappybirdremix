float ballX, ballY, speedX, speedY, paddleX, paddleY, paddleHeight, paddleX2, paddleY2;
int score = 0, page;

void settings() {
  fullScreen();
}

void setup() {
  ballY = height/2;
  paddleY2 = height-200;
  speedX = 8;
  speedY = 8;
  paddleX = width-30;
  paddleHeight = 200;
  paddleX2 = 0;
  ballX = random(width/2);
  score = 0;
  page = 0;
}

void draw() {
  if (page == 0) {
    background(0);
    fill(255);
    textSize(100);
    textAlign(CENTER, CENTER);
    text("PADDLE", width/2, 100);
    textSize(50);
    text("PRESS 1 FOR SINGLE PLAYER", width/2, height/2);
    text("PRESS 2 FOR DOUBLE PLAYER", width/2, height/2+100);
    text("PRESS I FOR INSTRUCTIONS", width/2, height/2+200);
    fill(255);
    rect(paddleX, paddleY, 30, paddleHeight);
    rect(paddleX2, paddleY2, 30, paddleHeight);
  }
  if (page == 1) {
    onePlayer(paddleX, paddleY);
  }
  if (page == 2) {
    twoPlayer(paddleX, paddleY, paddleX2, paddleY2);
  }
}


void onePlayer(float x, float y) {
  y = mouseY - (paddleHeight/2);
  background(255);
  fill(0);
  rect(0, 0, width, 100);
  rect(x, y, 30, paddleHeight);
  ellipse(ballX, ballY, 50, 50);
  textSize(50);
  fill(255);
  text("Score : "+score, width/2, 70);
  ballX+= speedX;
  ballY+= speedY;
  if (ballX-50<=0) {
    speedX = -speedX;
  }
  if (ballY+50 >= height || ballY-50<=100) {
    speedY = -speedY;
  }
  bounceOff(x, y);

  if (ballX >= width) {
    gameOver();
  }
}

void twoPlayer(float x, float y, float x2, float y2) {
  y2 = mouseY - (paddleHeight/2);
  background(255);
  fill(0);
  rect(0, 0, width, 100);
  rect(x, y, 30, paddleHeight);
  rect(x2, y2, 30, paddleHeight);
  ellipse(ballX, ballY, 50, 50);
  textSize(50);
  fill(255);
  text("Score : "+score, width/2, 70);
  ballX+= speedX;
  ballY+= speedY;

  if (ballY+25 >= height || ballY-25<=100) {
    speedY = -speedY;
  }
  bounceOff2(x, y, y2);

  if (ballX >= width) {
    gameOver();
  }
}


void bounceOff(float x, float y) {
  if (ballY >= y && ballY<= y+paddleHeight) {
    if (ballX+25 >= x) {

      speedX = -1.2*speedX;
      score++;

      paddleHeight-=10;
      if (paddleHeight<= 50) {
        paddleHeight = 50;
      }
      if (speedX>= 30) {
        speedX = 30;
      }
    }
  }
}

void bounceOff2(float x, float y, float y2) {
  if ((ballY >= y && ballY<= y+paddleHeight) || (ballY >= y2 && ballY<= y2+paddleHeight)) {
    if (ballX+25 >= x || ballX - 25<= 30) {

      speedX = -1.2*speedX;
      score++;

      paddleHeight-=10;
      if (paddleHeight<= 50) {
        paddleHeight = 50;
      }
      if (speedX>= 30) {
        speedX = 30;
      }
    }
  }
}

void gameOver() { 
  background(0);
  textSize(50);
  fill(255);
  text("Your Final Score: "+score, width/2, height/2);
   noLoop();
}
void keyPressed() {
  if (key == 'r') {
    loop();
    setup();
  }
  if (key == '1') {
    page = 1;
  }
  if (key == '2') {
    page = 2;
  }
  if (page == 2 && key == CODED) {
    if (keyCode == UP) {
      paddleY-=40;
    }
    if (keyCode == DOWN) {
      paddleY+=40;
    }
  }
}