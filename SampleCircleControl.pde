/*
-more circles controlling more things  (can probably make updateUgen method in subclasses more 'dry')
   //-volume and pan?
  combfilter style delay
  delay time and fback (typical delay)
  

-way to select overlapped circles (z value?) (and alternate way, w/ right mouse?, to move all as one)
??-size of circle changeable with mousewheel (indicates random range of values w/in circle) [[actual separate rect]]
-draw output sample data (or draw wav file with a play indicator and loop markers, etc
-? way to record circle movements that it can then run through in loop?
constants for max/min values, etc.

*/


import beads.*;


final int BORDER = 50;
final int GRID_DIVISIONS = 4;


SamplerAudio samplerAudio;

ArrayList<CircleControl> circles;
Grid grid;


void setup() {
  
  size(800, 800);
  background(0);
  ellipseMode(CENTER);
  
  grid = new Grid(GRID_DIVISIONS);

  circles = new ArrayList<CircleControl>();
  
  
  //move initial location to constructors?
  circles.add(new RateCircle(width/2, height/2));
  circles.add(new LoopCircle(BORDER, height - BORDER));
  circles.add(new FilterCircle(BORDER, BORDER));
  circles.add(new CombCircle(width - BORDER, height - BORDER));
  circles.add(new DelayCircle(BORDER, 725));
  
  samplerAudio = new SamplerAudio();

}



void draw() {
  background(0);
  
  for (CircleControl c: circles) {
    c.display();
  }
  
  grid.display();

  //println(frameRate);
}