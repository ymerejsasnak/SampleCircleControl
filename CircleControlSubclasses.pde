class RateCircle extends CircleControl {
 
  RateCircle() {
    super(int(GRID_SIZE * .75) + BORDER, int(GRID_SIZE * .75) + BORDER); 
    fillColor = color(200, 0, 0);
  }
  
  
  void updateUgens() {
    setYUgen(0.3, 3, samplerAudio.rateGlide);
    
    float xRand = random(x - randomness, x + randomness);
    if (xRand < width/2) {
      samplerAudio.setPlayReverse(); 
    }
    else {
      samplerAudio.setPlayForward(); 
    }
  }
}



class LoopCircle extends CircleControl {
 
  LoopCircle() {
    super(BORDER, height - BORDER); 
    fillColor = color(0, 200, 0);
  }
  
  
  void updateUgens() {
    float sampleLength = samplerAudio.sampleLength;
    
    setXUgen(0, sampleLength, samplerAudio.startGlide);
    setYUgen(sampleLength, 0, samplerAudio.endGlide);
        
    // if position gets out of loop boundaries, put it back to loop start
    if (!samplerAudio.sampler.inLoop()) {
      samplerAudio.sampler.setToLoopStart();
    }
  }
}


class FilterCircle extends CircleControl {
 
  FilterCircle() {
    super(BORDER, BORDER);
    fillColor = color(0, 0, 200);
  }
  
  void updateUgens() {
    setXUgen(.4, .99, samplerAudio.lpRezGlide);
    setYUgen(0, 11025, samplerAudio.lpFreqGlide);
  }
}


class CombCircle extends CircleControl {
  
  CombCircle() {
    super(width - BORDER, height - BORDER);
    fillColor = color(0, 100, 100);
  }
  
  void updateUgens() {
    setXUgen(2, 40, samplerAudio.combTimeGlide);
    setYUgen(0, .95, samplerAudio.combFeedbackGlide);
  }
  
}


class DelayCircle extends CircleControl {
  
  DelayCircle() {
    super(width/2, height - BORDER);
    fillColor = color(100, 0, 100);
  }
  
  void updateUgens() {
    setXUgen(100, 1000, samplerAudio.delayTimeGlide);
    setYUgen(0, .9, samplerAudio.delayFeedbackGlide);
  }
}