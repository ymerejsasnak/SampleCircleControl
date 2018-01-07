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
    fillColor = color(200, 0, 0, 100);
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
    fillColor = color(0, 200, 0, 100);
  }
  
  
  void updateUgen() {
    
    float loopStart = map(y, height - BORDER, BORDER, 0.0, .999);
    float loopLength = map(x, BORDER, width - BORDER, 1.0, 0.001);
    
    samplerAudio.setLoopStart(loopStart);
    samplerAudio.setLoopLength(loopLength);
    
    // if position gets out of loop boundaries, put it back to loop start
    if (!samplerAudio.sampler.inLoop()) {
      samplerAudio.sampler.setToLoopStart();
    }
  }
}


class FilterCircle extends CircleControl {
 
  FilterCircle(int x, int y) {
    super(x, y);
    fillColor = color(0, 0, 200, 100);
  }
  
  void updateUgen() {
    
    float filterFreq = map(y, BORDER, height - BORDER, 11025.0, 0.0);
    float filterRez = map(x, BORDER, width - BORDER, .4, .99);
    
    samplerAudio.setFilterFreq(filterFreq);
    samplerAudio.setFilterRez(filterRez);
  }
}


class CombCircle extends CircleControl {
  
  CombCircle(int x, int y) {
    super(x, y);
    fillColor = color(0, 100, 100, 100);
  }
  
  void updateUgen() {
    float time = map(x, BORDER, width - BORDER, 2.0, 40.0);
    float feedback = map(y, BORDER, height - BORDER, .99, 0);
    
    samplerAudio.setCombTime(time);
    samplerAudio.setCombFeedback(feedback);
    
  }
  
}


class DelayCircle extends CircleControl {
  
  DelayCircle(int x, int y) {
    super(x, y);
    fillColor = color(100, 0, 100, 100);
  }
  
  void updateUgen() {
    float time = map(x, BORDER, width - BORDER, 100.0, 1000.0);
    float feedback = map(y, BORDER, height - BORDER, .9, 0);
    
    samplerAudio.setDelayTime(time);
    samplerAudio.setDelayFeedback(feedback);
  }
}