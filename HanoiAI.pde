//class HanoiAI {
//  Tower sourceTower, auxiliaryTower, destinationTower;
//  int totalDisks;

//  HanoiAI(int totalDisks) {
//    this.totalDisks = totalDisks;

//    // Create towers
//    sourceTower = new Tower(width / 4);
//    auxiliaryTower = new Tower(width / 2);
//    destinationTower = new Tower((3 * width) / 4);

//    // Create disks and add them to the source tower
//    for (int i = totalDisks; i > 0; i--) {
//      Disk disk = new Disk(sourceTower.posX, height - i * 20, i, sourceTower);
//      sourceTower.addDisk(disk);
//    }
//  }

//  void solve() {
//    moveDisks(totalDisks, sourceTower, auxiliaryTower, destinationTower);
//  }

//  void moveDisks(int disksToMove, Tower source, Tower auxiliary, Tower destination) {
//    if (disksToMove > 0) {
//      // Move (n-1) disks from source to auxiliary using destination as the auxiliary tower
//      moveDisks(disksToMove - 1, source, destination, auxiliary);

//      // Move the nth disk from source to destination
//      Disk diskToMove = source.removeTopDisk();
//      diskToMove.sourceTower = destination;
//      destination.addDisk(diskToMove);

//      // Display the move
//      //println("Move disk " + diskToMove.size + " from Tower " + source.posX + " to Tower " + destination.posX);

//      // Move the (n-1) disks from auxiliary to destination using source as the auxiliary tower
//      moveDisks(disksToMove - 1, auxiliary, source, destination);
//    }
//  }
//}


//void demoAISetup() {
//  hanoiAI = new HanoiAI(3); // Set the number of disks you want to solve
//  hanoiAI.solve();
//}
