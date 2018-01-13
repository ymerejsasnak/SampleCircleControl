void mousePressed() {
  
  if (mouseButton == CENTER)
  {
    for (CircleControl c: circles)
    {
      c.cyclePathMode(); 
    }
    return;
  }
  
  for (CircleControl c: circles)
  {
    if ( (mouseButton == LEFT && c.mouseInside(mouseX, mouseY)) || mouseButton == RIGHT) 
    {
      c.setPressed();
      c.clearPath();
      c.calculateOffset(mouseX, mouseY); 
      if (mouseButton == LEFT) 
      {
      return; // only first circle in list moves
      }
    }
    
  }
    
  if (mouseButton == RIGHT) {
    return;
  }
  
  // check sides last, circles can overlap sides, circles come first
  sideControls.checkSides(mouseX, mouseY);
}


void mouseDragged() {
  
  for (CircleControl c: circles) {
    
    if (c.isPressed()) {
      c.move(mouseX, mouseY); 
      c.constrainToGrid();
      c.addPoint();
    }
  }
}


void mouseReleased() {
  for (CircleControl c: circles) {
    c.setReleased();
  }
}


void mouseWheel(MouseEvent event) {
  
  for (CircleControl c: circles) {
    if (c.mouseInside(mouseX, mouseY)) {
      float wheel = event.getCount();
      if (wheel == 1) c.increaseRandomness();
      if (wheel == -1) c.decreaseRandomness();
      c.constrainToGrid();
      break;
    }
  }
}