/*


-more circles controlling more things
  (put stuff in mousedragged method into a circle.update method, then subclass the circle class for each
   separate circle, and each has its own unique update method (does conversion of values and setting beads, etc)
  //-volume and pan
  -loop start, loop end (DONE but work on it more so it makes more sense?)
  -lp filter rez and freq
  -hp filter rez and freq (parallel or serial with above?)
  -delay time and fback
  -grain stuff (change SamplePlayer to GranularSamplePlayer)
  

??-size of circle changeable with mousewheel (indicates random range of values w/in circle)
-draw output sample data (or draw wav file with a play indicator and loop markers, etc
-? way to record circle movements that it can then run through in loop?

*/

final int BORDER = 50;
final int GRID_DIVISIONS = 4;

import beads.*;


SamplerAudio samplerAudio;

ArrayList<CircleControl> circles;
//RateCircle rateCircle;
Grid grid;


void setup() {
  
  size(800, 800);
  background(0);
  ellipseMode(CENTER);
  
  grid = new Grid(GRID_DIVISIONS);
  //rateCircle = new RateCircle(width/2, height/2);
  
  circles = new ArrayList<CircleControl>();
  
  circles.add(new RateCircle(width/2, height/2));
  circles.add(new LoopCircle(width - BORDER, BORDER));
   
  samplerAudio = new SamplerAudio();

}



void draw() {
  background(0);
  
  for (CircleControl c: circles) {
    c.display();
  }
  
  grid.display();

  println(frameRate);
}