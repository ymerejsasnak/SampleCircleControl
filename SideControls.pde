class SideControls 
{
  
  
  SideControls() 
  {
     
  }
  
  void checkSides(int _mouseX, int _mouseY) 
  {
    // top bar - load file
    if (_mouseX > BORDER && _mouseX < GRID_SIZE - BORDER && _mouseY < BORDER) 
    {
      samplerAudio.loadNewFile();
    }
    // left bar - record to new loop
    else if (_mouseX < BORDER && _mouseY < GRID_SIZE - BORDER && _mouseY > BORDER) 
    {
      println("l");
    }
    // right bar - mix record with current loop
    else if (_mouseX > BORDER + GRID_SIZE && _mouseY < GRID_SIZE - BORDER && _mouseY > BORDER) 
    {
      println("r");
    }
    // bottom bar - record to file
    else if (_mouseX > BORDER && _mouseX < GRID_SIZE - BORDER && _mouseY > BORDER + GRID_SIZE) 
    {
      samplerAudio.record();
    }
  }
}

  