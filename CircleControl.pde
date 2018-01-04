class CircleControl {
  
 int x, y;
 int offsetX, offsetY;
 int diameter;
 
 boolean pressed;
 
 CircleControl(int x, int y) {
   this.x = x;
   this.y = y;
   diameter = 50;
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
 }
 
 
 
 void display() {
   if (pressed) {
     fill(200);
   }
   else {
     fill(100);
   }
   
   if (mouseInside(mouseX, mouseY)) {
     stroke(255);
   }
   else {
     noStroke();
   }
   
   ellipse(x, y, diameter, diameter);
 }
  
}