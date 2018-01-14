/*
cleanup/refactor -
  
  whole sampleraudio class needs real looking at
  side controls is fine (it will have different function in future - record to file, unload all, etc)
  a second look at mouseevents may be good too
  



separate mode where recorded stuff replaces playing loop instead of saved as file!
simplify controls? -- click on top bar to load, left bar to record into loop, right to record to file, bottom to stop either record

adjust various things sonically (delay values, filter, glide time, etc) (delays make things too loud sometimes!)
 (and changing loop points when loading files of different length doesn't always sound right at first because of glide time)
also, maybe change loop thing to start time and loop length rather than end time

constants for max/min values, etc.
more comments/cleanup?

 stuff to add: 
-control: timer speed per circle
-control: path mode per circle
-control: glide time per circle
-circle: crossfade between 4 samples (100% at corner, 25% each at center, etc)
    (in which case the grid parts can be buttons for load/record for each sample? (or some stuff)
-circle: ring mod/fm (frequency and mix)?
-circle: volume/pan
*/


import beads.*;


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
    
    background(SCREEN_BACKGROUND);
    
    grid.display();
    
    if (samplerAudio.hasSample())
    {
      for (CircleControl c: circles) 
      {
        c.walkPath();
        c.display();
        c.updateUgens();
      }
    } 

}