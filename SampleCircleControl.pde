CircleControl circle;



void setup() {
  
 size(800, 800);
 background(0);
 ellipseMode(CENTER);
 
 circle = new CircleControl(width/2, height/2);
 
}



void draw() {
  background(0);
  circle.display();
 
  
}

void mousePressed() {
  if (circle.mouseInside(mouseX, mouseY)) {
    circle.setPressed();
    circle.calculateOffset(mouseX, mouseY); 
  }
}


void mouseDragged() {
  if (circle.isPressed()) {
    circle.move(mouseX, mouseY); 
  }
  
}


void mouseReleased() {
  circle.setReleased(); 
}