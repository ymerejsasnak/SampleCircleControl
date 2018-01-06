class CircleControl {
  
 int x, y;
 int offsetX, offsetY;
 int diameter;
 
 color fillColor;
 
 boolean pressed;
 
 CircleControl(int x, int y) {
   this.x = x;
   this.y = y;
   diameter = 20;
   pressed = false;
 }
 
 
 int getX() {
   return x; 
 }
 
 
 int getY() {
   return y; 
 }
 
 
 void setPressed() {
   pressed = true;  
 }
 
 
 void setReleased() {
   pressed = false; 
 }
 
 
 boolean isPressed() {
   return pressed;
 }
 
 
 boolean mouseInside(int _mouseX, int _mouseY) {
   return dist(x, y, _mouseX, _mouseY) <= diameter / 2 + 1; // +1 just to make clickable zone *slightly* bigger
 }
 
 
 void calculateOffset(int _mouseX, int _mouseY) {
   offsetX = x - _mouseX;
   offsetY = y - _mouseY;
 } 
 
 
 void move(int newX, int newY) {
   x = newX + offsetX;
   y = newY + offsetY;
   
   //constrain to grid
   if (x < BORDER) x = BORDER;
   if (x > width - BORDER) x = width - BORDER;
   if (y < BORDER) y = BORDER;
   if (y > height - BORDER) y = height - BORDER;
 }
 
 
 void updateUgen() {
   
 }
 
 
 void display() {
   if (pressed) {
     fill(150);
   }
   else {
     fill(fillColor);
   }
   
   if (mouseInside(mouseX, mouseY)) {
     stroke(200);
   }
   else {
     noStroke();
   }
   
   ellipse(x, y, diameter, diameter);
 }
  
}



class RateCircle extends CircleControl {
 
  RateCircle(int x, int y) {
    super(x, y); 
    fillColor = color(200, 0, 0);
  }
  
  
  void updateUgen() {
    
    float playRate = map(y, BORDER, height - BORDER, 2, 0);
    samplerAudio.setRate(playRate);
    
    if (mouseX < width/2) {
      samplerAudio.setPlayReverse(); 
    }
    else {
      samplerAudio.setPlayForward(); 
    }
  }
}



class LoopCircle extends CircleControl {
 
  LoopCircle(int x, int y) {
    super(x, y); 
    fillColor = color(0, 200, 0);
  }
  
  
  void updateUgen() {
    
    float loopStart = map(y, height - BORDER, BORDER, 0.0, .9);
    float loopLength = map(x, BORDER, width - BORDER, 1.0, 0.01);
    
    samplerAudio.setLoopStart(loopStart);
    samplerAudio.setLoopLength(loopLength);
    
    // if position gets out of loop boundaries, put it back to loop start
    if (!samplerAudio.sampler.inLoop()) {
      samplerAudio.sampler.setToLoopStart();
    }
  }
}