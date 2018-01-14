class RateCircle extends CircleControl 
{
 
  RateCircle() 
  {
    super(int(GRID_SIZE * .75) + BORDER, int(GRID_SIZE * .75) + BORDER); 
    fillColor = color(200, 0, 0);
  }
  
  
  void updateUgens() 
  {
    setYUgen(0.3, 3, samplerAudio.rateGlide);
    
    float xRand = random(x - randomness, x + randomness);
    if (xRand < BORDER + GRID_SIZE/2) 
    {
      samplerAudio.setPlayReverse(); 
    }
    else
    {
      samplerAudio.setPlayForward(); 
    }
    
  }
  
}



class LoopCircle extends CircleControl 
{
 
  LoopCircle()
  {
    super(BORDER, BORDER + GRID_SIZE); 
    fillColor = color(0, 200, 0);
  }
  
  
  void updateUgens() 
  {
    float sampleLength = samplerAudio.sampleLength;
    
    setXUgen(0, sampleLength, samplerAudio.startGlide);
    setYUgen(sampleLength, 0, samplerAudio.endGlide);
  }  
  
}


class FilterCircle extends CircleControl
{
 
  FilterCircle()
  {
    super(BORDER, BORDER);
    fillColor = color(0, 0, 200);
  }
  
  void updateUgens()
  {
    setXUgen(.4, .99, samplerAudio.lpRezGlide);
    setYUgen(0, 11025, samplerAudio.lpFreqGlide);
  }
  
}


class CombCircle extends CircleControl 
{
  
  CombCircle()
  {
    super(BORDER + GRID_SIZE, BORDER + GRID_SIZE);
    fillColor = color(0, 100, 100);
  }
  
  void updateUgens()
  {
    setXUgen(1, 40, samplerAudio.combTimeGlide);
    setYUgen(0, .8, samplerAudio.combFeedbackGlide);
  }
  
}


class DelayCircle extends CircleControl
{
  
  DelayCircle()
  {
    super(BORDER + GRID_SIZE/2, BORDER + GRID_SIZE);
    fillColor = color(100, 0, 100);
  }
  
  void updateUgens() 
  {
    setXUgen(100, 1000, samplerAudio.delayTimeGlide);
    setYUgen(0, .8, samplerAudio.delayFeedbackGlide);
  }
  
}