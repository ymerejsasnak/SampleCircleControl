/*


-more circles controlling more things  (can probably make updateUgen method in subclasses more 'dry')
   //-volume and pan
  -loop start, loop end (DONE but work on it more so it makes more sense?)
  1-lp filter rez and freq
  2-hp filter rez and freq (parallel! or serial with above?)
  4-delay time and fback (typical delay)
  3-combfilter style delay


??-size of circle changeable with mousewheel (indicates random range of values w/in circle) [[actual separate rect]]
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

  circles = new ArrayList<CircleControl>();
  
  circles.add(new RateCircle(width/2, height/2));
  circles.add(new LoopCircle(BORDER, height - BORDER));
  circles.add(new FilterCircle(BORDER, BORDER));
  
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