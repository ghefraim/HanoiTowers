String inputText = "3";
int discsNumber = 0;
int gameMode = 0;//0 - Menu, 1 - Play Yourself, 2 - AI Demo

void setup() {
  size(900, 500, P3D);
  //lights();
  //ambientLight(100, 100, 100);
  //pointLight(255, 255, 255, 250, 250, 0);
  //spotLight(0, 0, 255, 250, 250, 500, 0, 0, -1, PI/4, 20);
}

void draw() {
  if (gameMode==0) {
    drawMenu();
  } else if (gameMode == 1) {
    playYourself();
  } else if (gameMode == 2) {
    demoAI();
  }
}
void drawMenu() {
  background(220);
  
  // draw the "Play" button
  noStroke();
  fill(150, 200, 200);
  rect(width/2 - 75, 200, 150, 50);
  fill(0);
  textSize(24);
  textAlign(CENTER, CENTER);
  text("Play Yourself", width/2, 225);
  
  // draw the "Options" button
  fill(150, 200, 200);
  rect(width/2 - 75, 260, 150, 50);
  fill(0);
  text("AI Demo", width/2, 285);
  
  // draw the "Quit" button
  fill(125, 140, 170);
  rect(width/2 - 75, 320, 150, 50);
  fill(0);
  text("Quit", width/2, 345);
  
  // draw the text field and label
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Number of discs (3-10):", width/2, 140);
  fill(180);
  rect(width/2 - 50, 160, 100, 30);
  fill(0);
  textAlign(LEFT, CENTER);
  text(inputText, width/2 - 45, 175);
}

void playYourself() {
  hint(DISABLE_DEPTH_TEST);
  background(220);
  
  // Set up lighting
  lights();
  ambientLight(128, 128, 128);
  specular(255, 255, 255);
  shininess(50);
  
  // set the camera position
  camera(0, -200, 400, 0, 0, 0, 0, 1, 0);
  
  // draw the three towers
  noStroke();
  fill(128);
  translate(-150, 0, 0);
  box(20, 200, 20);
  translate(150, 0, 0);
  box(20, 200, 20);
  translate(150, 0, 0);
  box(20, 200, 20);
}



void demoAI() { }

void mouseClicked() {
  // check if the "Play Yourself" button was clicked
  if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 200 && mouseY < 250) {
    gameMode = 1;
  }
  
  // check if the "AI Demo" button was clicked
  if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 260 && mouseY < 310) {
    gameMode = 2;
  }
  
  // check if the "Quit" button was clicked
  if (mouseX > width/2 - 75 && mouseX < width/2 + 75 && mouseY > 320 && mouseY < 370) {
    // do something when the "Quit" button is clicked
    println("Quit button clicked!");
    exit();
  }
  
  // check if the mouse is over the text field
  if (mouseY > 160 && mouseY < 190) {
    // focus on the text field if clicked
    if (!keyPressed) {
      inputText = "";
    }
  } else {
    // unfocus text field if clicked elsewhere
    inputText = "";
  }
}

void keyPressed() {
  // append text input for the text field
  if (mouseY > 160 && mouseY < 190 && mouseX > width/2 - 50 && mouseX < width/2 + 50) {
    if (key == BACKSPACE && inputText.length() > 0) {
      inputText = inputText.substring(0, inputText.length() - 1);
    } else if (key >= '0' && key <= '9' && inputText.length() < 2) {
      inputText += key;
    }
  }
}

void keyReleased() {
  // parse input text to number when input is complete
  
  if (mouseY > 160 && mouseY < 190 && mouseX > width/2 - 50 && mouseX < width/2 + 50 && inputText.length() > 0) {
    discsNumber = Integer.parseInt(inputText);
  }
}
