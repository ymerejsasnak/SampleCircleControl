class SurfaceListener 
{
  
  int lastSelectedSamplerIndex;
  
  SurfaceListener() 
  {
     lastSelectedSamplerIndex = -1;
  }
  
  
  int getLastSelectedIndex() {
    return lastSelectedSamplerIndex; 
  }
  
  
  void checkCells (int _mouseX, int _mouseY)
  {
    
  }
  
  
  //TEMPORARILY LEFT IN, NEEDS TO CHANGE TO FIT NEW STRUCTURE
  void checkSides(int _mouseX, int _mouseY) 
  {
    // top bar - e
    if (_mouseX > BORDER && _mouseX < GRID_SIZE - BORDER && _mouseY < BORDER) 
    {
      lastSelectedSamplerIndex = 0;
      samplerAudio.loadNewFile();
    }
    // left bar - 
    else if (_mouseX < BORDER && _mouseY < GRID_SIZE - BORDER && _mouseY > BORDER) 
    {
      println("l");
    }
    // right bar - 
    else if (_mouseX > BORDER + GRID_SIZE && _mouseY < GRID_SIZE - BORDER && _mouseY > BORDER) 
    {
      println("r");
    }
    // bottom bar - 
    else if (_mouseX > BORDER && _mouseX < GRID_SIZE - BORDER && _mouseY > BORDER + GRID_SIZE) 
    {
      samplerAudio.recordToFile();
    }
  }
}

  