/*

-control path mode with center button: standard/forward, pingpong, off
-adjust speed of path following? (ie slow it down)

-load file
-record to file
-basic instructions/messages/coordinate values/labels for each circle kind of stuff

adjust various things sonically (delay values, filter, etc)
constants for max/min values, etc.
comments/cleanup
*/


import beads.*;


final int BORDER = 50;
final int SCREEN_SIZE = 800;
final int GRID_SIZE = SCREEN_SIZE - BORDER * 2;
final int GRID_DIVISIONS = 4;

final int GLIDE_TIME = 500;
final int DIRECTION_GLIDE_TIME = 50;

final int MAX_RANDOM = 100;

final int CIRCLE_DIAMETER = 50;
final int CIRCLE_ALPHA = 50;
final int RECT_ALPHA = 25;


SamplerAudio samplerAudio;

ArrayList<CircleControl> circles;
Grid grid;


void setup() {
  
  size(800, 800);
  background(0);
  ellipseMode(CENTER);
  
  grid = new Grid(GRID_DIVISIONS);

  circles = new ArrayList<CircleControl>();
  
  circles.add(new RateCircle());
  circles.add(new LoopCircle());
  circles.add(new FilterCircle());
  circles.add(new CombCircle());
  circles.add(new DelayCircle());
  
  samplerAudio = new SamplerAudio();

}



void draw() {
  if (samplerAudio.sampler != null) {
    
    background(0);
    
    grid.display();
    
    for (CircleControl c: circles) {
      c.updatePosition();
      c.display();
      c.updateUgens();
    }
  
  }
  //println(frameRate);

}