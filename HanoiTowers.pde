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
  fillXYPlane();
  
  // Set up lighting
  lights();
  //spotLight(255, 255, 255, 320, 80, 160, -1, 0, 0, PI/2, 2);
  shininess(50);
  
  // set the camera position
  camera(0, 220, 80, 0, 0, 0, 0, 1, 0); // camera rotation effect? modify first value
  
  // draw the three towers
  //noStroke();
  //noLights();
  //drawTowers();
  drawTowers();

  fill(230, 100, 100);
  drawCube(3, 4);
}

void drawTowers() { // functia aceasta deseneaza toate 3 turnurile, folosind translate si drawPrism
  stroke(156, 116, 79);
  fill(186, 124, 90);

  translate(-200, 0, 0);
  drawPrism(PI*2, -200, 14);

  translate(200, 0, 0);
  drawPrism(PI*2, -200, 14);
  
  translate(200, 0, 0);
  drawPrism(PI*2, -200, 14);
  
  translate(-200, 0, 0);

}
void drawPrism(float radius, float height, int numSides) { // deseneaza o prisma cu parametrii dati
  pushMatrix();  // Save the current transformation state
  //rotate(PI/4);  // Rotate the shape by 45 degrees
  
  beginShape(QUAD_STRIP);
  
  float angleIncrement = TWO_PI / numSides;
  for (int i = 0; i <= numSides; i++) {
    float angle = i * angleIncrement;
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    
    vertex(x, y-100, 0); // Bottom vertex
    vertex(x, y-100, height); // Top vertex
  }
  
  endShape();
  
  popMatrix();  // Restore the previous transformation state
}



void drawCube(int towerNumber, float size) { // deseneaza un "disc" care e de fapt un cub, pe un turn, numerotate de la stanga la dreapta.
  if (towerNumber == 1) {
    translate(-200, 0, 0);
  }
  else if (towerNumber == 3) {
    translate(200, 0, 0);
  }
  
  size = PI*size;
  stroke(150, 150, 150);
  fill(55, 255, 100);
  drawPrism(size, 10, 4);
  
  if (towerNumber == 1) {
    translate(200, 0, 0);
  }
  else if (towerNumber == 3) {
    translate(-200, 0, 0);
  }
}

void fillXYPlane() { // umple planul XY cu culoarea gri
  int size = 300;
  noStroke();
  fill(160);
  beginShape();
  vertex(-size, -size, 0); // bottom-left
  vertex(size, -size, 0); // bottom-right
  vertex(size, size, 0); // top-right
  vertex(-size, size, 0); // top-left
  endShape(CLOSE);
}


void demoAI() { }

void mouseClicked() {
  if (gameMode == 0) {
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
  else if (gameMode == 1) { 
    
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




//void drawDonut(float radius1, float radius2, int numSegments1, int numSegments2) {
//  beginShape(QUAD_STRIP);
  
//  float angleIncrement1 = TWO_PI / numSegments1;
//  float angleIncrement2 = TWO_PI / numSegments2;
  
//  for (int i = 0; i <= numSegments1; i++) {
//    float angle1 = i * angleIncrement1;
//    float cos1 = cos(angle1);
//    float sin1 = sin(angle1);
    
//    for (int j = 0; j <= numSegments2; j++) {
//      float angle2 = j * angleIncrement2;
//      float cos2 = cos(angle2);
//      float sin2 = sin(angle2);
      
//      float x = (radius1 + radius2 * cos2) * cos1;
//      float y = (radius1 + radius2 * cos2) * sin1;
//      float z = radius2 * sin2;
      
//      vertex(x, y, z);
//    }
//  }
  
//  endShape();
//}
