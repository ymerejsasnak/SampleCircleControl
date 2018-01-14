/*

TO DO:

=cleanup/refactor SamplerAudio class  

=change loop thing to start time and loop length rather than end time?

=four samplers!
  -switch SamplerAudio to not automatically ask for file at the beginning (no file is ok, nothing happens)
  -then allow 4 files to be loaded separately (use scalingmixer then all routed the same)
  -be sure waves can be loaded in any or none, avoid null pointers
  -this is done by clicking respective corner grid boxes (have to add functionality to grid class)
  
=other grid controls:
  -inner grid boxes turn on recording INTO loop
  
=side controls
  -entire border area: record to file

=then ANY non-circle leftclick turns off any recording
  
=add circles:
  -sample crossfade (100% at corner, 25% each at center, etc)
  -ring mode/fm (freq and mix)
  -vol and pan

=various final adjustments
 -ugen settings (fx values, glide times (loop point glide time too slow sometimes?), etc)
 -path timer speed?
 -maybe some more gain control to avoid loud/clipping issues

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