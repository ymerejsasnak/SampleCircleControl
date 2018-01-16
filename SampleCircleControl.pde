/*

TO DO:
(gross code in crossfade circle updateugen function!)

=change loop thing to start time and loop length rather than end time?

=other grid controls:
  -inner grid boxes turn on recording INTO loop
  
=side controls
  -entire border area: record to file (use selectOutput())

=then ANY non-circle leftclick turns off any recording
  
=add circles:
  -ring mod/fm (freq and mix)
  -vol and pan

=various final adjustments
 -ugen settings (fx values, glide times (loop point glide time too slow sometimes?), etc)
 -path timer speed?
 -maybe some more gain control/compressor to avoid loud/clipping issues

*/


import beads.*;


SamplerAudio samplerAudio;

ArrayList<CircleControl> circles;
SurfaceListener surfaceListener;
Grid grid;


void setup() 
{
  
  size(800, 800);
  background(SCREEN_BACKGROUND);
  ellipseMode(CENTER);
  
  textSize(20);
  strokeWeight(3);
  
  grid = new Grid();

  circles = new ArrayList<CircleControl>();
  surfaceListener = new SurfaceListener();
  
  circles.add(new RateCircle());
  circles.add(new LoopCircle());
  circles.add(new FilterCircle());
  circles.add(new CombCircle());
  circles.add(new DelayCircle());
  circles.add(new CrossFadeCircle());
  
  samplerAudio = new SamplerAudio();

}



void draw() 
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