void mousePressed() {
  
  
  if (circle.mouseInside(mouseX, mouseY)) {
    circle.setPressed();
    circle.calculateOffset(mouseX, mouseY); 
  }
}


void mouseDragged() {
  if (circle.isPressed()) {
    circle.move(mouseX, mouseY); 
    
    float playRate = map(circle.getY(), BORDER, height - BORDER, 2, 0);
    samplerAudio.setPlayRate(playRate);
    
    if (mouseX < width/2) {
      samplerAudio.setPlayReverse(); 
    }
    else {
      samplerAudio.setPlayForward(); 
    }
    
    //float gain = map(circle.getY(), 0, height, 1, 0.0);
    //gainGlide.setValue(gain);
 
  }
  
}


void mouseReleased() {
  circle.setReleased(); 
}