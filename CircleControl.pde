abstract class CircleControl {
  
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
   if (x < BORDER)  x = BORDER;
   if (x > BORDER + GRID_SIZE)  x = BORDER + GRID_SIZE;
   if (y < BORDER)  y = BORDER;
   if (y > BORDER + GRID_SIZE) y = BORDER + GRID_SIZE;
 }
 
 
 void updateUgens(){
 }
 
 void setXUgen(float min, float max, Glide glide) {
   float value = map(x, BORDER, BORDER + GRID_SIZE, min, max);
   glide.setValue(value);
 }
 
 void setYUgen(float min, float max, Glide glide) {
   float value = map(y, BORDER, BORDER + GRID_SIZE, max, min);
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
   
   ellipse(x, y, diameter, diameter);
 }
  
}