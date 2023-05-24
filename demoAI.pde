void demoAISetup(){
  // Create the towers
  disksNumber = Integer.parseInt(inputText);
  movesCounter = 0;
  
  gameFinished=false;
    
  aiMovesCount = 0;
  aiCurrentMove = 0;

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
  
  background(30);
  drawTowers();
  for (int i = 0; i < disksNumber; i ++) {
    disks[i].drawAndDrag();
  }

  // Call the demoAI method to solve the game
  hanoiSolver(disksNumber, 0, 2, 1);
  
  demoAISetupDone = true;
}

void hanoiSolver(int n, int sourceTower, int targetTower, int auxTower) {
  if (n == 0) {
    return;
  }
  
  // Move n-1 disks from the source tower to the auxiliary tower using the target tower as the auxiliary
  hanoiSolver(n - 1, sourceTower, auxTower, targetTower);
  
  sourceTowerSequence[aiMovesCount] = sourceTower;
  targetTowerSequence[aiMovesCount] = targetTower;
  aiMovesCount ++;
  
  // Move the n-1 disks from the auxiliary tower to the target tower using the source tower as the auxiliary
  hanoiSolver(n - 1, auxTower, targetTower, sourceTower);
}

void demoAI() {
  if(!demoAISetupDone) {
    demoAISetup();
  } else {
    //UNCOMMENT THESE IF WANT TO PLAY AUTOMATICALLY
    //delay(500);
    //goToNextMove();
  }
}

void goToNextMove() {
  if(sourceTowerSequence[aiCurrentMove] != targetTowerSequence[aiCurrentMove]) // not won yet
  {
    println();
    moveDisksAI(sourceTowerSequence[aiCurrentMove], targetTowerSequence[aiCurrentMove]);
 
    movesCounter++;
    drawMoveCounter();

    aiCurrentMove ++;
  }
  else //AI won
  {
      if(!gameFinished) {
      gameFinished=true;
    }
    drawPlayAgainScreen();
  }
}

void moveDisksAI(int sourceNr, int targetNr) 
{
  Tower sourceTower, targetTower;
  
  if(sourceNr == 0) {sourceTower = towerA;}
  else if(sourceNr == 1) {sourceTower = towerB;}
  else {sourceTower = towerC;}
  
  if(targetNr == 0) {targetTower = towerA;}
  else if(targetNr == 1) {targetTower = towerB;}
  else {targetTower = towerC;}
  
  Disk diskToMove = sourceTower.disksOn[sourceTower.disksOnCount];
  
  targetTower.addDisk(diskToMove);
  diskToMove.posX = targetTower.posX;
  diskToMove.posY = targetTower.nextPosYAvailable;
  diskToMove.sourceTower.removeDisk(diskToMove);
  diskToMove.sourceTower = targetTower;
  
  drawTowers();
  for (int i = 0; i < disksNumber; i ++) {
    if(aiCurrentMove == aiMovesCount-1){
      disks[i].drawFinal();
    }
    else {
      disks[i].drawAndDrag();
    }
  } 
}
