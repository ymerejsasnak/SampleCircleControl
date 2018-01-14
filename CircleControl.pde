enum PathMode
{
  FORWARD, PINGPONG, OFF 
}

abstract class CircleControl 
{
  
  int x, y;
  int offsetX, offsetY;
   
  color fillColor;
   
  boolean pressed;
   
  int randomness;
   
  PathMode pathMode;
  ArrayList<PVector> path;
  int pathIndex;
  int pathDirection;
  Timer pathTimer;
    
    
  CircleControl(int x, int y) 
  {
     this.x = x;
     this.y = y;
     pressed = false;
     randomness = 0;
     path = new ArrayList<PVector>();
     pathIndex = 0;
     pathMode = PathMode.OFF;
     pathDirection = 1;
     pathTimer = new Timer(100);
  }
   
  
  /* 
    methods related to basic user control of the circle 
  */
  
  void setPressed()
  {
    pressed = true;  
  }
   
   
  void setReleased() 
  {
    pressed = false; 
  }
   
   
  boolean isPressed() 
  {
    return pressed;
  }
   
   
  boolean mouseInside(int _mouseX, int _mouseY) 
  {
    // return true if inside circle or inside 'randomness square'
    return dist(x, y, _mouseX, _mouseY) <= CIRCLE_DIAMETER / 2 ||
               (_mouseX > x - randomness && _mouseX < x + randomness && 
               _mouseY > y - randomness && _mouseY < y + randomness);
  }
   
   
  // this is used to keep a pressed circle in the same relative position to the mouse
  void calculateOffset(int _mouseX, int _mouseY)
  {
    offsetX = x - _mouseX;
    offsetY = y - _mouseY;
  } 
   
   
  void move(int newX, int newY)
  {
    x = newX + offsetX;
    y = newY + offsetY;
  }

   
  void constrainToGrid()
  {
    if (x < BORDER + randomness) 
    {  
      x = BORDER + randomness;
    }
    else if (x > BORDER + GRID_SIZE - randomness)  
    {
      x = BORDER + GRID_SIZE - randomness;
    }
    
    if (y < BORDER + randomness)  
    {
      y = BORDER + randomness;
    }
    else if (y > BORDER + GRID_SIZE - randomness) 
    {
      y = BORDER + GRID_SIZE - randomness;
    }  
  }
   
   
  void changeRandomness(int wheelDirection)
  {
    randomness -= RANDOM_INCREMENT * wheelDirection; 
    if (randomness < 0) randomness = 0;
    if (randomness > MAX_RANDOM) randomness = MAX_RANDOM;
  }
   

  /* 
    methods related to creation and management of circle movement paths
  */
  
  void addPoint()
  {
    if (pathMode != PathMode.OFF)
    {   
      path.add(new PVector(x, y)); 
    }
  }
   
  void clearPath()
  {
    path.clear(); 
    pathIndex = 0;
    pathDirection = 1;
  }
   
  void cyclePathMode() {
    pathMode = PathMode.values()[(pathMode.ordinal() + 1) % PathMode.values().length];  
    pathIndex = 0;
    pathDirection = 1;
  }
   
  void walkPath() 
  {
    if (pathMode != PathMode.OFF && !isPressed())
    {
      int points = path.size();
      if (points > 1 && pathTimer.checkTimer()) 
      {
        x = (int) path.get(pathIndex).x;
        y = (int) path.get(pathIndex).y;
        constrainToGrid();
        pathIndex = pathIndex + pathDirection;
        if (pathMode == PathMode.FORWARD) 
        {
          pathIndex = pathIndex % points; 
        }
        else if (pathMode == PathMode.PINGPONG && (pathIndex == 0 || pathIndex == points - 1)) 
        {
          pathDirection = -pathDirection;
        }
      }
    }
  }
  
  
  /*
    methods related to translating x,y coords and sending to ugens
  */
  
  void updateUgens()
  {
    // nothing needed here? each subclass does it in a slightly unique way?????
  }
   
  void setXUgen(float min, float max, Glide glide)
  {
    float xRandom = random(x - randomness, x + randomness);
    float value = map(xRandom, BORDER, BORDER + GRID_SIZE, min, max);
    glide.setValue(value);
  }
   
  void setYUgen(float min, float max, Glide glide) 
  {
    float yRandom = random(y - randomness, y + randomness);
    float value = map(yRandom, BORDER, BORDER + GRID_SIZE, max, min);
    glide.setValue(value);
  }
   
   
  
  void display() 
  {
    
    if (pressed) 
    {
      fill(fillColor, PRESSED_ALPHA);
    }
    else 
    {
      fill(fillColor, CIRCLE_ALPHA);
    }
   
    if (mouseInside(mouseX, mouseY))
    {
      stroke(200);
    }
    else 
    {
      stroke(100);
    }
     
    //draw the circle
    ellipse(x, y, CIRCLE_DIAMETER, CIRCLE_DIAMETER);
    
    //draw the randomness square
    rectMode(CENTER);
    fill(fillColor, RECT_ALPHA);
    rect(x, y, randomness * 2, randomness * 2, 5); //the 5 is for slightly rounded corners
    
    //draw path points
    if (pathMode != PathMode.OFF) 
    {
      for (PVector point: path)
      {
        stroke(fillColor, PATH_POINT_ALPHA / 2);
        fill(fillColor, PATH_POINT_ALPHA);
        ellipse(point.x, point.y, PATH_POINT_DIAMETER, PATH_POINT_DIAMETER);
      }
    }
     
  }
  
}