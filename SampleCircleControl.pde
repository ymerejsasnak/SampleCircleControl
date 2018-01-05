/*


-more circles controlling more things (one existing now is temporary/test)
  -rate and direction (DONE)
  -volume and pan
  -loop start, loop end 
  -lp filter rez and freq
  -hp filter rez and freq (parallel or serial with above?)
  -delay time and fback
  -grain stuff (change SamplePlayer to GranularSamplePlayer)
  
-size of circle changeable with mousewheel (indicates random range of values w/in circle)
-draw output sample data
-? way to record circle movements that it can then run through in loop?

*/



import beads.*;


SamplerAudio samplerAudio;

CircleControl circle;


void setup() {
  
  size(800, 800);
  background(0);
  ellipseMode(CENTER);
   
   
  circle = new CircleControl(width/2, height/2);
   
  samplerAudio = new SamplerAudio();

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
    
    float playRate = map(circle.getY(), 0, height, 2, 0);
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