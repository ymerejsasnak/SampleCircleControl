void mousePressed() {
  
  if (mouseButton == LEFT) {
  for (CircleControl c: circles) {
    if (c.mouseInside(mouseX, mouseY)) {
      c.setPressed();
      c.calculateOffset(mouseX, mouseY); 
      break; // only first circle in list moves
    }
  }
  }
  if (mouseButton == RIGHT) {
    for (CircleControl c: circles) {
      c.setPressed();
      c.calculateOffset(mouseX, mouseY);
    }
  }
  
}


void mouseDragged() {
  
  for (CircleControl c: circles) {
    
    if (c.isPressed()) {
      c.move(mouseX, mouseY); 
      c.updateUgens();
    
    }
  }
}


void mouseReleased() {
  for (CircleControl c: circles) {
    c.setReleased();
  }
}