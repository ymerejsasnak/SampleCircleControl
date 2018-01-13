/*

separate mode where recorded stuff replaces playing loop instead of saved as file!
simplify controls? -- click on top bar to load, left bar to record into loop, right to record to file, bottom to stop either record

adjust various things sonically (delay values, filter, glide time, etc)
 (and changing loop points when loading files of different length doesn't always sound right at first because of glide time)
also, maybe change loop thing to start time and loop length rather than end time

constants for max/min values, etc.
comments/cleanup


possible future stuff to add: 
-control: timer speed per circle
-control: path mode per circle
-control: glide time per circle
-circle: crossfade between 4 samples (100% at corner, 25% each at center, etc)
-circle: ring mod/fm (frequency and mix)?
-circle: reverb?
-circle: grain stuff?
-circle: volume/pan
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
SideControls sideControls;
Grid grid;


void setup() 
{
  
  size(800, 800);
  background(SCREEN_BACKGROUND);
  ellipseMode(CENTER);
  textSize(20);
  strokeWeight(3);
  
  grid = new Grid(GRID_DIVISIONS);

  circles = new ArrayList<CircleControl>();
  sideControls = new SideControls();
  
  circles.add(new RateCircle());
  circles.add(new LoopCircle());
  circles.add(new FilterCircle());
  circles.add(new CombCircle());
  circles.add(new DelayCircle());
  
  samplerAudio = new SamplerAudio();

  
}



void draw() 
{
  if (samplerAudio.sampler != null)
  {
    
    background(SCREEN_BACKGROUND);
    
    grid.display();
    
    for (CircleControl c: circles) 
    {
      c.walkPath();
      c.display();
      c.updateUgens();
    }

  }

}