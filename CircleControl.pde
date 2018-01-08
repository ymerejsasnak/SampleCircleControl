abstract class CircleControl {
  
 int x, y;
 int offsetX, offsetY;
 int diameter;
 
 color fillColor;
 
 boolean pressed;
 
 int randomness = 0;
 
 CircleControl(int x, int y) {
   this.x = x;
   this.y = y;
   diameter = 20;
   pressed = false;
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
   return dist(x, y, _mouseX, _mouseY) <= max(diameter / 2 + 1, randomness + 1); // +1 just to make clickable zone *slightly* bigger
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
 }
  
}