class SurfaceListener 
{
  
  int lastSelectedSamplerIndex;
  boolean loadButton;
  
  SurfaceListener() 
  {
     lastSelectedSamplerIndex = -1;
     loadButton = false;
  }
  
  
  int getLastSelectedIndex() {
    return lastSelectedSamplerIndex; 
  }
  
  
  void checkCells (int _mouseX, int _mouseY)
  { //this is kind of ugly, eh?
    if (_mouseX > BORDER && _mouseX < BORDER + CELL_SIZE &&
        _mouseY > BORDER && _mouseY < BORDER + CELL_SIZE)
      {
        lastSelectedSamplerIndex = 0; 
        loadButton = true;
      }
    else if (_mouseX > BORDER + CELL_SIZE * 3 && _mouseX < width - BORDER &&
             _mouseY > BORDER && _mouseY < BORDER + CELL_SIZE)
      {
        lastSelectedSamplerIndex = 1;
        loadButton = true;
      }
    else if (_mouseX > BORDER && _mouseX < BORDER + CELL_SIZE &&
             _mouseY > BORDER + CELL_SIZE * 3 && _mouseY < height - BORDER)
      {
        lastSelectedSamplerIndex = 2; 
        loadButton = true;
      }
    else if (_mouseX > BORDER + CELL_SIZE * 3 && _mouseX < width - BORDER &&
             _mouseY > BORDER + CELL_SIZE * 3 && _mouseY < height - BORDER)
      {
        lastSelectedSamplerIndex = 3; 
        loadButton = true;
      }
    
    if (loadButton)
    {
      samplerAudio.loadNewFile();
      loadButton = false;
    }
  }
  
  
  //TEMPORARILY LEFT IN, NEEDS TO CHANGE TO FIT NEW STRUCTURE
  void checkSides(int _mouseX, int _mouseY) 
  {
    // top bar - e
    if (_mouseX > BORDER && _mouseX < GRID_SIZE - BORDER && _mouseY < BORDER) 
    {
      //lastSelectedSamplerIndex = 0;
      //samplerAudio.loadNewFile();
      
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

  