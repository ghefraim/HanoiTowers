import java.util.ArrayList;
import java.util.List;
import java.io.*;
FileWriter fw;
BufferedWriter bw;

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
int[] sourceTowerSequence = new int[1025];
int[] targetTowerSequence = new int[1025];
int aiMovesCount;
int aiCurrentMove;
boolean invalidTextOnScreen = false;
boolean gameFinished;
int delayTimer;
//HanoiAI hanoiAI;
void setup() {
  size(900, 700, P3D);

  numDisks = 3; //doesn't affect anything yet
  playHumanSetupDone = false;
  demoAISetupDone = false;
  gameFinished = false;
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

void resetGlobalVariables() {
  //disksNumber = 0;
  //gameMode = 0;
  //playHumanSetupDone = false;
  //demoAISetupDone = false;
}
