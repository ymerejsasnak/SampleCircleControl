void mousePressed() {
  
  for (CircleControl c: circles) {
    if (c.mouseInside(mouseX, mouseY)) {
      c.setPressed();
      c.calculateOffset(mouseX, mouseY); 
    }
  }
  
}


void mouseDragged() {
  
  for (CircleControl c: circles) {
    
    if (c.isPressed()) {
      c.move(mouseX, mouseY); 
      c.updateUgen();
    
    }
  }
}


void mouseReleased() {
  for (CircleControl c: circles) {
    c.setReleased();
  }
}