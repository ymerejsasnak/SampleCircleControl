enum PathMode {
  FORWARD, PINGPONG, OFF 
}

abstract class CircleControl {
  
 int x, y;
 int offsetX, offsetY;
 int diameter;
 
 color fillColor;
 
 boolean pressed;
 
 int randomness;
 
 ArrayList<PVector> path;
 int pathIndex;
 PathMode pathMode;
 int pathDirection;
 Timer pathTimer;
 
 CircleControl(int x, int y) {
   this.x = x;
   this.y = y;
   diameter = CIRCLE_DIAMETER;
   pressed = false;
   randomness = 0;
   path = new ArrayList<PVector>();
   pathIndex = 0;
   pathMode = PathMode.OFF;
   pathDirection = 1;
   pathTimer = new Timer(50);
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
   return dist(x, y, _mouseX, _mouseY) <= diameter / 2 + 1 ||// +1 just to make clickable zone *slightly* bigger
          (_mouseX > x - randomness && _mouseX < x + randomness && 
           _mouseY > y - randomness && _mouseY < y + randomness);
 }
 
 
 void calculateOffset(int _mouseX, int _mouseY) {
   offsetX = x - _mouseX;
   offsetY = y - _mouseY;
 } 
 
 
 void move(int newX, int newY) {
   x = newX + offsetX;
   y = newY + offsetY;
   
 }
 
 void constrainToGrid() {
   if (x < BORDER + randomness)  
     x = BORDER + randomness;
   if (x > BORDER + GRID_SIZE - randomness)  
     x = BORDER + GRID_SIZE - randomness;
   if (y < BORDER + randomness)  
     y = BORDER + randomness;
   if (y > BORDER + GRID_SIZE - randomness) 
     y = BORDER + GRID_SIZE - randomness;
 }
 
 void increaseRandomness() {
   randomness -= 5; 
   if (randomness < 0) randomness = 0;
 }
 
 void decreaseRandomness() {
   randomness += 5;
   if (randomness > MAX_RANDOM) randomness = MAX_RANDOM;
 }
 
  
 
 void updateUgens(){
 }
 
 void setXUgen(float min, float max, Glide glide) {
   float xRandom = random(x - randomness, x + randomness);
   float value = map(xRandom, BORDER, BORDER + GRID_SIZE, min, max);
   glide.setValue(value);
 }
 
 void setYUgen(float min, float max, Glide glide) {
   float yRandom = random(y - randomness, y + randomness);
   float value = map(yRandom, BORDER, BORDER + GRID_SIZE, max, min);
   glide.setValue(value);
 }
 
 
 
  void addPoint() {
    if (pathMode != PathMode.OFF) {   
      path.add(new PVector(x, y)); 
    }
  }
 
 void clearPath() {
   path.clear(); 
   pathIndex = 0;
   pathDirection = 1;
 }
 
 void cyclePathMode() {
   pathMode = PathMode.values()[(pathMode.ordinal() + 1) % PathMode.values().length];  
   if (pathMode == PathMode.OFF) {
     clearPath();
   }
 }
 
 void walkPath() {
   int points = path.size();
   if (points > 0 && pathTimer.checkTimer()) {
     x = (int) path.get(pathIndex).x;
     y = (int) path.get(pathIndex).y;
     constrainToGrid();
     pathIndex = pathIndex + pathDirection;
     if (pathMode == PathMode.FORWARD) {
       pathIndex = pathIndex % points; 
     }
     else if (pathMode == PathMode.PINGPONG && (pathIndex == 0 || pathIndex == points - 1)) {
       pathDirection = -pathDirection;
     }
   }
     
 }
 
 
 void display() {
   if (pressed) {
     fill(150);
   }
   else {
     fill(fillColor, CIRCLE_ALPHA);
   }
   
   if (mouseInside(mouseX, mouseY)) {
     stroke(200);
   }
   else {
     stroke(100);
   }
   
   //draw the circle
   ellipse(x, y, diameter, diameter);
   
   //draw the randomness rect
   rectMode(CENTER);
   fill(fillColor, RECT_ALPHA);
   rect(x, y, randomness * 2, randomness * 2);
   
   //draw path points
   if (pathMode == PathMode.OFF) {
     return;
   }
   for (PVector point: path) {
     stroke(fillColor, CIRCLE_ALPHA);
     fill(fillColor, RECT_ALPHA);
     ellipse(point.x, point.y, 5, 5);
   }
 }
  
}