import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;
import java.io.*;
FileWriter fw;
BufferedWriter bw;
/*
Notes:


*/
int numDisks, i, j, nr, delay, dif, rows;
float disc2x, disc2y, disc1x, disc1y, disc3x, disc3y, timeCounter;
boolean held, disk1, disk2, disk3, okA, okB, okC, oA, oB, oC, mouse, done, reset;
float[] pozitiiX = new float[100];
float[] pozitiiY = new float[100];
float[] pozitieX = new float[100];
float[] pozitieY = new float[100];

String inputText = "3";
int discsNumber = 0;
int gameMode = 0; //0 - Menu, 1 - Play Human, 2 - AI Demo

List<Disk> disks;
Disk d1, d2, d3;
class Disk {
  float size;
  float posX, posY;
  
  Disk(float posX, float posY, float size) {
    this.posX = posX;
    this.posY = posY;
    this.size = size;
  }
  
  void drawAndMove() {
    fill(255, 102, 255);
    
    pushMatrix();
    translate( disc2x, disc2y, 0 );
    rotateX( PI/2 );
    drawCylinder(30,50,20);
    popMatrix();
    
    if (dist(disc2x, disc2y, mouseX, mouseY) < 72) { 
      fill(200);
      if (mousePressed && disk2==false && disk3==false && oA==false && oB==false && oC==false) {
        disk1 = true;
        held=true;
        if ( held ) {
          disc2x += mouseX-pmouseX;
          disc2y += mouseY-pmouseY;
        }
      }
    }
  }
  
}
void setup() {
  size(900, 700, P3D);
  numDisks = 3; //doesn't affect anything yet
  disk3=false;
  //numMoves = (long) pow(2,numDisks) - 1;  
  //noLoop();  
  disc1x=150;
  disc1y=(height/2)+180;
  pozitiiX[0]=disc1x;
  pozitiiY[0]=disc1y;
  pozitiiX[1]=450;
  pozitiiY[1]=(height/2)+130;
  pozitiiX[2]=750;
  pozitiiY[2]=(height/2)+180;
  dif = 0;
  pozitieX[0]=150;
  pozitieY[0]=(height/2)+130;
  pozitieX[1]=150;
  pozitieY[1]=(height/2)+180;
  pozitieX[2]=450;
  pozitieY[2]=(height/2)+130;
  pozitieX[3]=450;
  pozitieY[3]=(height/2)+180;
  pozitieX[4]=750;
  pozitieY[4]=(height/2)+130;
  pozitieX[5]=750;
  pozitieY[5]=(height/2)+180;
  okA=true;
  oA=true;
  d2 = new Disk(150, (height/2)+130, 10);
  //disc2x = 150;
  //disc2y = (height/2)+130;
  disc3x=150;
  disc3y=(height/2)+80;
  i=0;
  held= false;
  delay=0;
  done=false;
  rows = 0;
  
  timeCounter = 0;
}

void draw() {
  if (gameMode==0) {
    drawMenu();
  } else if (gameMode == 1) {
    playHuman();
  } else if (gameMode == 2) {
    demoAI();
  }
}

void playHuman() {
  background(220);
  //background(140, 205, 210); // blue
  //camera(width/2, height/2 - 100, (height/2) / tan(PI*30.0 / 180.0), 0, 0, 0, 0, 1, 0);
  drawTimeCounter();
  
  //fillPlane();

  if((disc1x!=750 || disc3x!=750 || disc2x!=750)) { // all disks are NOT on the third tower
    timeCounter = millis()/1000;
    drawTowers();
    d2.drawAndMove();
    drawAndMoveDisk3();
    drawAndMoveDisk1();
    while(mouse==true && delay<=100) {
      checkDiskOnTowerA();
      checkDiskOnTowerB();
      checkDiskOnTowerC();
      delay++;
    }
  }
  else { // all disks are on the third tower
    drawPlayAgainScreen();
    done=true;
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

void playYourselfOld() {
  hint(DISABLE_DEPTH_TEST);
  background(220);
  fillPlane();
  
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

void drawTowersOld() { // functia aceasta deseneaza toate 3 turnurile, folosind translate si drawPrism
  stroke(156, 116, 79);
  fill(186, 124, 90);

  translate(-150, 0, 0);
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

void fillPlane() { // umple planul XY cu culoarea gri
  int size = 10000;
  int pos = 500;
  noStroke();
  fill(143, 220, 93); //green
  beginShape();
  vertex(-size, pos, -size); // bottom-left
  vertex(size, pos, -size); // bottom-right
  vertex(size, pos, size); // top-right
  vertex(-size, pos, size); // top-left
  endShape(CLOSE);
}


void demoAI() { }

void mousePressed() {
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
    if(mouseX>150 && mouseX<150+210 && mouseY>505 && mouseY<505+90){
      loop();
    }
    if(mouseX>600 && mouseX<600+210 && mouseY>505 && mouseY<505+90){
      loop();
    }
  }
}

void keyPressed() {
  // append text input for the text field
  if(gameMode == 0) {
    if (mouseY > 160 && mouseY < 190 && mouseX > width/2 - 50 && mouseX < width/2 + 50) {
      if (key == BACKSPACE && inputText.length() > 0) {
        inputText = inputText.substring(0, inputText.length() - 1);
      } else if (key >= '0' && key <= '9' && inputText.length() < 2) {
        inputText += key;
      }
    }
  }
}

void keyReleased() {
  // parse input text to number when input is complete
  if(gameMode == 0) {
    if (mouseY > 160 && mouseY < 190 && mouseX > width/2 - 50 && mouseX < width/2 + 50 && inputText.length() > 0) {
      discsNumber = Integer.parseInt(inputText);
    }
  }
}


// Hanoi2
 
void drawPlayAgainScreen(){
  background(220);
  textSize(34);
  fill(#737679);
  text("Ati castigat!", 350, height/2);
  fill(#000000);
  rect(150, 505, 210, 90);
  fill(#F7F7F7);
  text("Joaca din nou", 200, 560);
  if(mouseX>150 && mouseX<150+210 && mouseY>505 && mouseY<505+90 && mousePressed){
    gameMode = 0;
  }
}

void drawTimeCounter(){
  noFill();
  //rect(100,50,700,100);
  textSize(32);
  //text(nr, 450, 110);
  text("Secunde:", 390,60);
  text(int(timeCounter), 540, 60);
}
void numarare(){
  nr++;
}
void checkDiskOnTowerA(){
  if(!held){
    
    //disk3
    if(disc3x<=300 && disc1x==150 && disc2x==150){
      disc3x = lerp(disc3x, 150, .6);
      disc3y = lerp(disc3y, (height/2)+80, .6);
      if(disc3x==disc1x){okA=true;}
      if(disc3x==disc2x){oA=true;}
    }
    else if(disc3x<=300 && ((disc1x==150 && disc2x!=150) || (disc1x!=150 && disc2x==150)) ){
      disc3x = lerp(disc3x, 150, .6);
      disc3y = lerp(disc3y, (height/2)+130, .6);
      if(disc3x==disc1x){okA=true;}
      if(disc3x==disc2x){oA=true;}
    }
    else if(disc3x<=300 && disc1x!=150 && disc2x!=150){
      disc3x = lerp(disc3x, 150, .6);
      disc3y = lerp(disc3y, (height/2)+180, .6);
    }
    
    //disk1
   if(disc2x<=300 && disc3x==150 && pozitieX[j]!=disc3x && disc3y>=(height/2)+130){ //y2>=(height/2)+80
      disc2x = lerp(disc2x,pozitieX[j], .9);
      disc2y = lerp(disc2x,pozitieY[j], .9);
      //translate(x,y);
    }
    else if(disc1x!=150 && disc2x<=300)
    {
    disc2x = lerp(disc2x, 150, .6);
    disc2y = lerp(disc2y, (height/2)+180, 0.6);
    numarare();
    j=1;
    }
    else if(disc1y==(height/2)+180 && disc2x<=300 && disc1x==150)//y1==(height/2)-100 && 
    {
    disc2x = lerp(disc2x, 150, .6);
    disc2y = lerp(disc2y, (height/2)+130, 0.6);
    j=0;
    okA=true;
    numarare();
    }
    //disk2
    if(disc1x<=300 && ((disc2x==150 && disc2y==(height/2)+180) || (disc3x==150 && disc3y==(height/2)+180)) ){
      disc1x = lerp(disc1x,pozitiiX[i], .8);// lerp(x1, pozitiiX[i], .6);
      disc1y = lerp(disc1x,pozitiiY[i], .8);// lerp(y1, pozitiiY[i], 0.6);
      //translate(x1,y1);
      numarare();
    }
    else if(disc1x<=300 && disc2x!=150){
      disc1x = lerp(disc1x, 150, .6);
      disc1y = lerp(disc1y, (height/2)+180, 0.6);
      i=0;
      numarare();
    }
  }
   
    if(disc1x!=disc2x && disc1x!=disc3x){okA=false;}
    if(disc2x!=disc3x){oA=false;}
}
void checkDiskOnTowerB(){
  if(!held){
    
    //disk3
    if(disc3x>300 && disc3x<=550  && disc1x==450 && disc2x==450){
      disc3x = lerp(disc3x, 450, .6);
      disc3y = lerp(disc3y, (height/2)+80, .6);
      if(disc3x==disc1x){okB=true;}
      if(disc3x==disc2x){oB=true;}
    }
    else if(disc3x>300 && disc3x<550 && ((disc1x==450 && disc2x!=450) || (disc1x!=450 && disc2x==450)) ){
      disc3x = lerp(disc3x, 450, .6);
      disc3y = lerp(disc3y, (height/2)+130, .6);
      if(disc3x==disc1x){okB=true;}
      if(disc3x==disc2x){oB=true;}
    }
    else if(disc3x>300 && disc3x<=550 && disc1x!=450 && disc2x!=450){
      disc3x = lerp(disc3x, 450, .6);
      disc3y = lerp(disc3y, (height/2)+180, .6);
    }
    
    //disk1
    if(disc2x>300 && disc2x<= 550 && pozitieX[j]!=disc3x && disc3x==450 && disc3y>=(height/2)+80){
      disc2x = lerp(disc2x,pozitieX[j], .6);
      disc2y = lerp(disc2x,pozitieY[j], .6);
    }
    else if(disc1y==(height/2)+180 && disc2x>=301 && disc2x<=550 && disc1x==450)//y1==(height/2)-100 && 
    {
    disc2x = lerp(disc2x, 450, .6);
    disc2y = lerp(disc2y, (height/2)+130, 0.6);
    j=2;
    okB=true;
    numarare();
    }
    else if(disc2x>=301 && disc2x<=550 && disc1x!=450){
      disc2x = lerp(disc2x, 450, .6);
      disc2y = lerp(disc2y, (height/2)+180, 0.6);
      j=3;
      numarare();
    }
    
  //disk2 
  if(disc1x>= 301  && disc1x<= 550 && ((disc2y==(height/2)+180 && disc2x==450) || (disc3x==450 && disc3y==(height/2)+180))){
  disc1x = lerp(disc1x, pozitiiX[i], .6);
  disc1y = lerp(disc1y, pozitiiY[i], .6);
  numarare();
  }
  else if(disc2x!=450 && disc1x>= 301 && disc1x<= 550){
    disc1x = lerp(disc1x, 450, .6);
    disc1y = lerp(disc1y, (height/2)+180, .6);
    i=1;
    numarare();
   }
  }
 if(disc1x!=disc2x && disc1x!=disc3x){okB=false;}
 if(disc2x!=disc3x){oB=false;}
}
void checkDiskOnTowerC(){
  if(!held){
    if(disc2x> 550 && pozitieX[j]!=disc3x && disc3x==750 && disc3y>=(height/2)+180){
      disc2x = lerp(disc2x,pozitieX[j], .8);
      disc2y = lerp(disc2x,pozitieY[j], .8);
    }
    else if(disc3x>550 && disc1x==750 && disc2x==750){
      disc3x = lerp(disc3x, 750, .6);
      disc3y = lerp(disc3y, (height/2)+80, .6);
      if(disc3x==disc1x){okC=true;}
      if(disc3x==disc2x){oC=true;}
    }
    else if(disc3x>550 && ((disc1x==750 && disc2x!=750) || (disc1x!=750 && disc2x==750)) ){
      disc3x = lerp(disc3x, 750, .6);
      disc3y = lerp(disc3y, (height/2)+130, .6);
      if(disc3x==disc1x){okC=true;}
      if(disc3x==disc2x){oC=true;}
    }
    else if(disc3x>550 && disc1x!=750 && disc2x!=750){
      disc3x = lerp(disc3x, 750, .6);
      disc3y = lerp(disc3y, (height/2)+180, .6);
    }
    
    //disk1
    if(disc2x>550 && disc1x==750){
      disc2x = lerp(disc2x, 750, .6);
      disc2y = lerp(disc2y, (height/2)+130, 0.6);
      j=4;
      okC=true;
      numarare();
    }
    else if(disc2x>550 && disc1x!=750){
      disc2x = lerp(disc2x, 750, .6);
      disc2y = lerp(disc2y, (height/2)+180, 0.6);
      j=5;
      numarare();
    }
    
    //disk2
    if(disc1x>550 && ((disc2x==750 && disc2y==(height/2)+180) || ((disc3x==750 && disc3y==(height/2)+180))) ) {
      disc1x = lerp(disc3x,pozitiiX[i], .8); //lerp(x1, 150, .6);
      disc1y = lerp(disc3y,pozitiiY[i], .8); //lerp(y1, pozitiiY[0], .6);
      //translate(x1,y1);
      numarare();
    }
    else if(disc2x!=750 && disc1x>550){
      disc1x = lerp(disc1x, 750, .6);
      disc1y = lerp(disc1y, (height/2)+180, .9);
      i=2;
      numarare();
    }
  }
  if(disc1x!=disc2x && disc1x!=disc3x){okC=false;}
  if(disc2x!=disc3x){oC=false;
  }
}

void drawTowers(){
  stroke(156, 116, 79);
  fill(0,0,0);
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


//void drawAndMoveDisk2() {
//  fill(255, 102, 255);
  
//  pushMatrix();
//  translate( disc2x, disc2y, 0 );
//  rotateX( PI/2 );
//  drawCylinder(30,50,20);
//  popMatrix();
  
//  if (dist(disc2x, disc2y, mouseX, mouseY) < 72) { 
//    fill(200);
//    if (mousePressed && disk2==false && disk3==false && oA==false && oB==false && oC==false) {
//      disk1 = true;
//      held=true;
//      if ( held ) {
//        disc2x += mouseX-pmouseX;
//        disc2y += mouseY-pmouseY;
//      }
//    }
//  }
//}

void drawAndMoveDisk3() {
  fill(153,51,153);
  
  //draw cilindru
  pushMatrix();
  translate( disc1x, disc1y, 0 );
  rotateX( PI/2 );
  drawCylinder(30,70,20);
  popMatrix();
  
  //ellipse(x1, y1, 100, 100);
  if (dist(disc1x, disc1y, mouseX, mouseY) < 72 && okA==false && okB==false && okC==false) { 
    fill(200);
    //pregatire drag daca click e apasat
    if (mousePressed && disk1==false && disk3==false) {
      disk2=true;
      held=true;
      //drag
      if ( held ) {
        disc1x+=mouseX-pmouseX;
        disc1y+=mouseY-pmouseY;
      }
    }
  }
}

void drawAndMoveDisk1(){
  fill(102, 153, 255);
  
  pushMatrix();
  translate( disc3x, disc3y, 0 );
  rotateX( PI/2 );
  drawCylinder(30,30,20);
  popMatrix();
  
  //ellipse(x2, y2, 60, 60);
  if (dist(disc3x, disc3y, mouseX, mouseY) < 72) { 
    fill(200);
    if (mousePressed && disk1==false && disk2==false) {
      disk3=true;
      held=true;
      if ( held ) {
        disc3x+=mouseX-pmouseX;
        disc3y+=mouseY-pmouseY;
      }
    }
  }
}

void mouseReleased() {
  delay=0;
  held = false;
  disk1=false;
  disk2=false;
  disk3=false;   
  mouse=true;
}
void drawCylinder( int sides, float r, float h)
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
