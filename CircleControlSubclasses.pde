class RateCircle extends CircleControl 
{
 
  RateCircle() 
  {
    super(int(GRID_SIZE * .75) + BORDER, int(GRID_SIZE * .75) + BORDER); 
    fillColor = color(200, 0, 0);
  }
  
  
  void updateUgens()
  {
    float xRand = getValueInRange(x);
    if (xRand < BORDER + GRID_SIZE/2) 
    {
      samplerAudio.setPlayReverse(); 
    }
    else
    {
      samplerAudio.setPlayForward(); 
    }
  
    setYUgen(RATE_MIN, RATE_MAX, samplerAudio.rateGlide);
  }
  
}



class LoopCircle extends CircleControl 
{
 
  LoopCircle()
  {
    super(BORDER + GRID_SIZE, BORDER + GRID_SIZE); 
    fillColor = color(0, 200, 0);
  }
  
  
  void updateUgens() 
  {
    for (int samplerIndex = 0; samplerIndex < 4; samplerIndex++) 
    {
      int sampleLength = samplerAudio.sampleLengths[samplerIndex];
      setXUgen(0, sampleLength, samplerAudio.endGlides[samplerIndex]);
      setYUgen(0, sampleLength, samplerAudio.startGlides[samplerIndex]);
    }
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
    setXUgen(LP_REZ_MIN, LP_REZ_MAX, samplerAudio.lpRezGlide);
    setYUgen(LP_FREQ_MIN, LP_FREQ_MAX, samplerAudio.lpFreqGlide);
  }
  
}


class CombCircle extends CircleControl 
{
  
  CombCircle()
  {
    super(BORDER + GRID_SIZE / 4 * 3, BORDER + GRID_SIZE);
    fillColor = color(0, 100, 100);
  }
  
  void updateUgens()
  {
    setXUgen(COMB_TIME_MIN, COMB_TIME_MAX, samplerAudio.combTimeGlide);
    setYUgen(COMB_FEEDBACK_MIN, COMB_FEEDBACK_MAX, samplerAudio.combFeedbackGlide);
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
    setXUgen(DELAY_TIME_MIN, DELAY_TIME_MAX, samplerAudio.delayTimeGlide);
    setYUgen(DELAY_FEEDBACK_MIN, DELAY_FEEDBACK_MAX, samplerAudio.delayFeedbackGlide);
  }
  
}


class CrossFadeCircle extends CircleControl
{
  CrossFadeCircle()
  {
    super(BORDER + GRID_SIZE / 2, BORDER + GRID_SIZE / 2);
    fillColor = color(100, 100, 0);
  }
   
  void updateUgens()
  {
    //just do this ugly and directly for now unless/until I find a better way
    float distance, gain;
    float x_ = random(x - randomRange, x + randomRange);
    float y_ = random(y - randomRange, y + randomRange);
    
    distance = dist(x_, y_, BORDER, BORDER);
    gain = MAX_SAMPLER_GAIN - map(distance, 0, GRID_SIZE, 0, MAX_SAMPLER_GAIN);
    if (gain < 0) gain = 0;
    samplerAudio.gainGlides[0].setValue(gain);
    
    distance = dist(x_, y_, width - BORDER, BORDER);
    gain = MAX_SAMPLER_GAIN - map(distance, 0, GRID_SIZE, 0, MAX_SAMPLER_GAIN);
    if (gain < 0) gain = 0;
    samplerAudio.gainGlides[1].setValue(gain);
    
    distance = dist(x_, y_, BORDER, height - BORDER);
    gain = MAX_SAMPLER_GAIN - map(distance, 0, GRID_SIZE, 0, MAX_SAMPLER_GAIN);
    if (gain < 0) gain = 0;
    samplerAudio.gainGlides[2].setValue(gain);
    
    distance = dist(x_, y_, width - BORDER, height - BORDER);
    gain = MAX_SAMPLER_GAIN - map(distance, 0, GRID_SIZE, 0, MAX_SAMPLER_GAIN);
    if (gain < 0) gain = 0;
    samplerAudio.gainGlides[3].setValue(gain);
        
    
  }
   
}