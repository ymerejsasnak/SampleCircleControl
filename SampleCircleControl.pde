/*

extend window horizontally and have some controls on the right side:
-load file
-record to file
-basic instructions/messages/coordinate values/labels for each circle kind of stuff
-timer speed per circle?
-path mode per circle??
-glide time per circle???
-adjustable ranges for fx?
-option to show or hide path drawing?

fix how circles are drawn when drawing a path (ie flickers between origin and current pos)?
adjust various things sonically (delay values, filter, etc)
constants for max/min values, etc.
comments/cleanup
*/


import beads.*;


final int BORDER = 50;
final int GRID_SIZE = 700;
final int GRID_DIVISIONS = 4;

final int GLIDE_TIME = 500;
final int DIRECTION_GLIDE_TIME = 50;

final int MAX_RANDOM = 100;

final int CIRCLE_DIAMETER = 50;
final int CIRCLE_ALPHA = 70;
final int PRESSED_ALPHA = 15;
final int RECT_ALPHA = 50;
final int SCREEN_BACKGROUND = 30;
final int GRID_BACKGROUND = 10;


SamplerAudio samplerAudio;

ArrayList<CircleControl> circles;
Grid grid;


void setup() {
  
  size(1000, 800);
  background(SCREEN_BACKGROUND);
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
    
    background(SCREEN_BACKGROUND);
    
    grid.display();
    
    for (CircleControl c: circles) {
      c.walkPath();
      c.display();
      c.updateUgens();
    }
  
  }
  //println(frameRate);

}