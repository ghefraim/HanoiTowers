import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;
import java.io.*;
FileWriter fw;
BufferedWriter bw;
/*
TODO:
De facut partea cu AI
Aranjat mai frumos Meniul de si pagina de final de joc
Adaugat culori random la diskuri? 
*/
int numDisks, delay;
int movesCounter;
boolean reset;

String inputText = "3";
int disksNumber = 3;
int gameMode = 0; //0 - Menu, 1 - Play Human, 2 - AI Demo
boolean playHumanSetupDone, demoAISetupDone;
Disk d1, d2, d3;
Disk[] disks;
Tower towerA, towerB, towerC;
//HanoiAI hanoiAI;
void setup() {
  size(900, 700, P3D);

  numDisks = 3; //doesn't affect anything yet
  playHumanSetupDone = false;
  demoAISetupDone = false;
}

void draw() {
  if (gameMode==0) {
    drawMenu();
  } else if (gameMode == 1) {
    playHuman();
  } else if (gameMode == 2) {
    if(!demoAISetupDone) {
      //demoAISetup();
    }
    
    //print("SADF");
    //drawTowers();
    //for (int i = 0; i < disksNumber; i ++) {
    //disks[i].drawAndDrag();
    //}
  }
}
