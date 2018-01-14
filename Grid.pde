class Grid
{
  
  Grid()
  {
    
  }
  
  
  void display() 
  {
    for (int x = 0; x < GRID_CELLS; x++)
    {
      for (int y = 0; y < GRID_CELLS; y++)
      {
        stroke(SCREEN_BACKGROUND);
        fill(GRID_BACKGROUND);
        rectMode(CORNER);
        rect(x * CELL_SIZE + BORDER, y * CELL_SIZE + BORDER, CELL_SIZE, CELL_SIZE);
      }
    }
  }
  
}