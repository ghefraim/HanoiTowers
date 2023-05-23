class Disk {
  int size;
  float posX, posY;
  boolean held = false;
  int defaultHeight = 20;
  int[] currentColor = {200, 200, 200};
  Tower sourceTower;
  
  Disk(float posX, float posY, int size, Tower sourceTower) {
    this.posX = posX;
    this.posY = posY;
    this.size = size;
    this.sourceTower = sourceTower;
  }
  
  int rank;
  Disk(Tower sourceTower, int rank){
    this.sourceTower = sourceTower;
    this.rank = rank;
  }
  void drawFinal() {
    stroke(100);
    fill(100, 200, 100);
    pushMatrix();
    translate(this.posX, this.posY, 0 );
    rotateX(PI/2);
    drawCylinder(50, this.size, 20);
    popMatrix();
    //println("XS");
  }
  void drawAndDrag() {
    //fill(255, 102, 255); //TODO: colorize disks individually
    stroke(100);
    fill(currentColor[0], currentColor[1], currentColor[2]);
    pushMatrix();
    translate(this.posX, this.posY, 0 );
    rotateX(PI/2);
    drawCylinder(50, this.size, 20);
    popMatrix();

    // drag disk if can

      if (validateDrag()) { // add check to be the last disk on tower
        this.held = true;
      } else if (!mousePressed && this.held) {
        Tower nearestTower = findNearestTower();
        boolean isValidMove = validateMove(nearestTower);
        
        if(isValidMove) {
          nearestTower.addDisk(this);
          this.posX = nearestTower.posX;
          this.posY = nearestTower.nextPosYAvailable;
          this.sourceTower.removeDisk(this);
          this.sourceTower = nearestTower;
          // for UI:
          movesCounter++;
          
          setColorGray();
        } else {
          this.posX = sourceTower.posX;
          this.posY = sourceTower.nextPosYAvailable; //dfH?
          
          setColorRed();
        }
          
        this.held = false;
      } else if (this.held) {
          this.posX += mouseX-pmouseX;
          this.posY += mouseY-pmouseY;
      } 
      noStroke();
   
  }
  
  boolean validateDrag() {
   boolean otherDiskHeld = false;
    for (int i=0; i<disksNumber; i++) {
      Disk disk = disks[i];
      if(disk.held == true) {
        otherDiskHeld = true;
        break;
      }
    }
    boolean isMouseOverThis = (abs(mouseX -this.posX) < this.size) && (abs(mouseY - this.posY) < defaultHeight-5);
    
    boolean isLastDiskOnTower = (this.sourceTower.getLastDiskSize() == this.size);
   
    return mousePressed && !otherDiskHeld && !this.held && isMouseOverThis && isLastDiskOnTower; 
  }

  
  Tower findNearestTower() {
    if (this.posX<=300) {
      return towerA;
    } else if (this.posX<=600) {
      return towerB;
    } else {
      return towerC;
    }
  }
  
  boolean validateMove(Tower destinationTower) {
    if (destinationTower.posX == sourceTower.posX) {
      return false;
    }
    if (this.size > destinationTower.getLastDiskSize()) {
      return false;
    }
    
    return true;
    
  }

  void setColorGray() {
    this.currentColor[0] = 200;
    this.currentColor[1] = 200;
    this.currentColor[2] = 200;
  }
  
   void setColorRed() {
    this.currentColor[0] = 170;
    this.currentColor[1] = 40;
    this.currentColor[2] = 20;
  }

}
