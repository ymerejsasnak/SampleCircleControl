class Grid {
  
  int divisions;
  int size;
  
  Grid(int divisions) {
    this.divisions = divisions;
    size = GRID_SIZE / divisions;
  }
  
  void display() {
    stroke(SCREEN_BACKGROUND);
    fill(GRID_BACKGROUND);
    
    rectMode(CORNER);
    for (int x = 0; x < divisions; x++) {
      for (int y = 0; y < divisions; y++) {
        rect(x * size + BORDER, y * size + BORDER, size, size);
      }
    }
    
    
  }
  
}