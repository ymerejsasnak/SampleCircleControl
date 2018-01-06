class Grid {
  
  int divisions;
  int size;
  
  Grid(int divisions) {
    this.divisions = divisions;
    size = (width - BORDER * 2) / divisions;
  }
  
  void display() {
    stroke(20);
    noFill();
    
    for (int x = 0; x < divisions; x++) {
      for (int y = 0; y < divisions; y++) {
        rect(x * size + BORDER, y * size + BORDER, size, size);
      }
    }
    
    
  }
  
  
  
  
}