class Tower {
  float posX;
  Disk[] disksOn = new Disk[disksNumber+1];
  int disksOnCount;
  float nextPosYAvailable;
  
  Tower(float posX) {
    this.posX = posX;
    disksOnCount = 0;
    nextPosYAvailable = 0;
  }
  
  void addDisk(Disk disk){
    disksOnCount ++;
    this.disksOn[disksOnCount] = disk;
    nextPosYAvailable = (height/2)+200 - (disksOnCount * disk.defaultHeight);
    
  }
  
  void removeDisk(Disk disk) {
    //remove disk from array
    if (this.disksOn.length > 0) {
      Disk[] newDisks = new Disk[disksNumber+1];
      arrayCopy(disksOn, 0, newDisks, 0, disksNumber+1);
      disksOn = newDisks;
      disksOnCount --;
      nextPosYAvailable = nextPosYAvailable + disk.defaultHeight;
    }

  }
  
  int getLastDiskSize() {
    Disk lastDisk = disksOn[disksOnCount];
    if (lastDisk != null) {
      return lastDisk.size;
    }
    return 10000;
  }
}
