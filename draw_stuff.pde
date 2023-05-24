
void drawMenu() {
  background(30);
  
  //
  noStroke();
  fill(150, 200, 200);
  rect(width/2 - 75, 200, 150, 50);
  fill(0);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Joaca tu", width/2, 225);
  
  //
  fill(150, 120, 200);
  rect(width/2 - 75, 260, 150, 50);
  fill(0);
  text("Algoritm", width/2, 285);
  
  // draw the "Quit" button
  fill(125, 140, 170);
  rect(width/2 - 75, 390, 150, 50);
  fill(0);
  text("Quit", width/2, 409);
  
  // draw the text field and label
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Numar de discuri (3-10):", width/2, 140);
  fill(180);
  rect(width/2 - 50, 160, 100, 30);
  fill(0);
  textAlign(LEFT, CENTER);
  text(inputText, width/2 - 45, 175);
}

void playHumanSetup() {
  disksNumber = Integer.parseInt(inputText);
  movesCounter = 0;
  gameFinished=false;
  
  towerA = new Tower(150);
  towerB = new Tower(450);
  towerC = new Tower(750);
  
  disks = new Disk[disksNumber+1];

  for (int i = 0; i < disksNumber; i ++) {
    int diskSize = 100 - (((90 - 30) / (disksNumber - 1)) * i);
    Disk disk = new Disk(150, (height/2)+200 - ((i+1) * 20), diskSize, towerA);
    disks[i] = disk;
    towerA.addDisk(disk);
  }
  playHumanSetupDone = true;
}

void playHuman() {
  if(!playHumanSetupDone) { 
    playHumanSetup();
  }
  background(30);
  //background(140, 205, 210); // blue
  //camera(width/2, height/2 - 100, (height/2) / tan(PI*30.0 / 180.0), 0, 0, 0, 0, 1, 0);
  
  //fillPlane();
  //boolean playAgainFlag = false; // this is used to create a delay between winning and playAgain Screen
  if(gameFinished) {
    delayTimer ++;
    println(delayTimer);
  
    drawTowers();
    for (int i = 0; i < disksNumber; i ++) {
      disks[i].drawFinal();
    }
    if(delayTimer > 100) {
        delayTimer = 101;
        drawPlayAgainScreen();
    }
  }
  if(!allDisksOnLastTower() && !gameFinished){
    drawTowers();
    for (int i = 0; i < disksNumber; i ++) {
      disks[i].drawAndDrag();
    }
  } 
  else if(!gameFinished)//AI won
  { 
    gameFinished=true;
   
  }
    
 
  
  drawMoveCounter();

}

  
boolean allDisksOnLastTower() {
  if(towerC.disksOnCount != disksNumber) {
    return false;
  }
  if(!gameFinished){
    delayTimer = 0;
    return true;
  }
  return false;
}

void mousePressed() {
  if (gameMode == 0) { // menu
    // check if the "Play Yourself" button was clicked
    if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 200 && mouseY < 250) {
      gameMode = 1;
      playHumanSetupDone = false;
    }
    
    // check if the "AI Demo" button was clicked
    if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 260 && mouseY < 310) {
      gameMode = 2;
      demoAISetupDone = false;
    }
    
    // check if the "Quit" button was clicked
    if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 390 && mouseY < 440) {
      // do something when the "Quit" button is clicked
      println("Quit button clicked!");
      exit();
    }
    
    // check if the mouse is over the text field
    if (mouseY > 160 && mouseY < 190) {
      // focus on the text field if clicked
      if (!keyPressed) {
        //inputText = "";
      }
    } else {
      // unfocus text field if clicked elsewhere
      //inputText = "";
    }
  }
  else if (gameMode == 1) { 
  
  }
  else if(gameMode == 2 && demoAISetupDone) {
     goToNextMove();
  }
}

void keyPressed() {
  // append text input for the text field
  if(gameMode == 0) {
      if (key == BACKSPACE && inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      } else if (key >= '0' && key <= '9' && inputText.length() < 2) {
        inputText += key;
      }
  }
}

void keyReleased() {
  // parse input text to number when input is complete
  if(gameMode == 0) {
    if (mouseY > 160 && mouseY < 190 && mouseX > width/2 - 50 && mouseX < width/2 + 50 && inputText.length() > 0) {
      disksNumber = Integer.parseInt(inputText);
    }
  } 
}

void drawPlayAgainScreen(){
  background(30);
  textSize(34);
  fill(255);
  text("Ai castigat!", 360, height/2);
  
  drawMoveCounter();
  textSize(26);
  
  fill(150, 120, 200);
  rect(width/2 - 100, 505, 200, 60);
  fill(#F7F7F7);
  text("Inapoi la meniu", width/2 - 85, 543);
  if(mouseX>350 && mouseX<350+200 && mouseY>505 && mouseY<505+90 && mousePressed){
    gameMode = 0;
  }
}

void drawMoveCounter(){
  stroke(255);
  textSize(32);
  text("Mutari:", 390,60);
  text(int(movesCounter), 500, 60);
  
  textSize(16);
  text("Cel mai mic nr de mutari posibil:", 660, 10);
  text(int(pow(2, disksNumber)-1), 880, 10);
}

void drawTowers(){
  background(23);
  stroke(242, 209, 41);
  fill(209, 106, 46);
  pushMatrix();    
  translate( 150, (height/2)+80, 0 );
  rotateX( PI/2 );
  drawCylinder( 8, 6, 200 );
  popMatrix();  //150
  
  pushMatrix();    
  translate( 450, (height/2)+80, 0 );
  rotateX( PI/2 );
  drawCylinder( 8, 6, 200 );
  popMatrix();
  
  pushMatrix();    
  translate( 750, (height/2)+80, 0 );
  rotateX( PI/2 );
  drawCylinder( 8, 6, 200 );
  popMatrix();
  noStroke();
}

void drawCylinder(int sides, float r, float h)
{
   
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw top of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle)) * r;
        float y = sin( radians( i * angle)) * r;
        vertex( x, y, -halfHeight);
    }
    endShape(CLOSE);

    // draw bottom of the tube
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
    }
    endShape(CLOSE);
    
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight);
        vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE);

}
