//void demoAISetup(){
//  // Create the towers
//  disksNumber = Integer.parseInt(inputText);
//  movesCounter = 0;

//  towerA = new Tower(150);
//  towerB = new Tower(450);
//  towerC = new Tower(750);
  
//  disks = new Disk[disksNumber+1];

//  for (int i = 0; i < disksNumber; i ++) {
//    int diskSize = 100 - (((90 - 30) / (disksNumber - 1)) * i);
//    Disk disk = new Disk(150, (height/2)+200 - ((i+1) * 20), diskSize, towerA);
//    disks[i] = disk;
//    towerA.addDisk(disk);
//  }
  
//  //println(gameMode);
//  background(30);
//  drawTowers();
//  for (int i = 0; i < disksNumber; i ++) {
//    disks[i].drawAndDrag();
//  }

//  // Call the demoAI method to solve the game
//  demoAI(disksNumber, towerA, towerC, towerB);
  
//  demoAISetupDone = false;
//}

//void demoAI(int n, Tower sourceTower, Tower targetTower, Tower auxiliaryTower) {
//  if (n == 0) {
//    return;
//  }
  
//  // Move n-1 disks from the source tower to the auxiliary tower using the target tower as the auxiliary
//  demoAI(n - 1, sourceTower, auxiliaryTower, targetTower);
  
//  // Move the nth disk from the source tower to the target tower
//  moveDisk(sourceTower, targetTower);
  
//  background(30);
//  drawTowers();
//  for (int i = 0; i < disksNumber; i ++) {
//    disks[i].drawAndDrag();
//  }
//  delay(500);
  
//  // Move the n-1 disks from the auxiliary tower to the target tower using the source tower as the auxiliary
//  demoAI(n - 1, auxiliaryTower, targetTower, sourceTower);
//}

//void moveDisk(Tower sourceTower, Tower targetTower) {
//  //println(sourceTower.disksOnCount, sourceTower.disksOn[sourceTower.disksOnCount].size);
//  Disk diskToMove = sourceTower.disksOn[sourceTower.disksOnCount];
  
//  //diskToMove.sourceTower = targetTower;
//  //diskToMove.posX = targetTower.posX;
//  //diskToMove.posY = targetTower.nextPosYAvailable;
  
  
//  targetTower.addDisk(diskToMove);
//  diskToMove.posX = targetTower.posX;
//  diskToMove.posY = targetTower.nextPosYAvailable;
//  diskToMove.sourceTower.removeDisk(diskToMove);
//  diskToMove.sourceTower = targetTower;
//  movesCounter++;
  
  
//  targetTower.disksOn[targetTower.disksOnCount] = diskToMove;
//  targetTower.disksOnCount++;
  
//}
