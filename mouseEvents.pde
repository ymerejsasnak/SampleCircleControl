void mousePressed() {
  
  if (mouseButton == LEFT) {
    for (CircleControl c: circles) {
      if (c.mouseInside(mouseX, mouseY)) {
        c.setPressed();
        c.clearPath();
        c.calculateOffset(mouseX, mouseY); 
        break; // only first circle in list moves
      }
    }
  }
  if (mouseButton == RIGHT) { // move ALL circles at once
    for (CircleControl c: circles) {
      c.setPressed();
      c.clearPath();
      c.calculateOffset(mouseX, mouseY);
    }
  }
  
  if (mouseButton == CENTER) {
    for (CircleControl c: circles) {
      c.cyclePathMode(); 
    }
  }
  
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