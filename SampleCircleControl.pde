/*

-put audio stuff in its own class(es?)
-more circles controlling more things (filter, delay, etc)
-size of circle changeable with mousewheel (indicates random range of values w/in circle)
-draw output sample data
-? way to record circle movements that it can then run through in loop?

*/



import beads.*;


AudioContext audioContext;
SamplePlayer sampler;
Gain gain;
Glide pitchGlide, gainGlide;

CircleControl circle;

int playDirection = 1;


void setup() {
  
 size(800, 800);
 background(0);
 ellipseMode(CENTER);
 
 circle = new CircleControl(width/2, height/2);
 
 
 audioContext = new AudioContext();
 
 sampler = new SamplePlayer(audioContext, SampleManager.sample(dataPath("drums.wav")));
 sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
 gain = new Gain(audioContext, 2, 0.4);
 
 pitchGlide = new Glide(audioContext, 1, 50);
 sampler.setRate(pitchGlide);
 
 gainGlide = new Glide(audioContext, 0.4, 50);
 gain.setGain(gainGlide);
 
 gain.addInput(sampler);
 audioContext.out.addInput(gain);
 
 audioContext.start();
}



void draw() {
  background(0);
  circle.display();
  
 
 
  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    playDirection = -playDirection; 
    float pitch = map(circle.getX(), 0, width, 0, 2);
    pitchGlide.setValue(pitch * playDirection);
    return;
  }
  
  if (circle.mouseInside(mouseX, mouseY)) {
    circle.setPressed();
    circle.calculateOffset(mouseX, mouseY); 
  }
}


void mouseDragged() {
  if (circle.isPressed()) {
    circle.move(mouseX, mouseY); 
    
    float pitch = map(circle.getX(), 0, width, 0, 2);
    pitchGlide.setValue(pitch * playDirection);
    
    float gain = map(circle.getY(), 0, height, 0.4, 0.0);
    gainGlide.setValue(gain);
 
  }
  
}


void mouseReleased() {
  circle.setReleased(); 
}