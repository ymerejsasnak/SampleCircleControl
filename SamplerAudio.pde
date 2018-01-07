class SamplerAudio {
  
  AudioContext audioContext;
  
  int sampleLength;
  
  SamplePlayer sampler;
  LPRezFilter filter;
  TapIn combDelayIn;
  TapOut combDelayOut;
  Gain combGain;
  TapIn delayIn;
  TapOut delayOut;
  Gain delayGain; 
  Gain gain;
 
  
  Glide gainGlide;
  Glide rateGlide, directionGlide;
  Glide startGlide, endGlide;
  Glide lpFreqGlide, lpRezGlide;
  Glide combTimeGlide, combFeedbackGlide;
  Glide delayTimeGlide, delayFeedbackGlide;
  
  int playDirection = 1;
 
    
  String filename = dataPath("horns.wav");
  
  
  SamplerAudio() {
    
    audioContext = new AudioContext();
    
    try {
      sampler = new SamplePlayer(audioContext, SampleManager.sample(filename));
    }
    catch (Exception e) {
      println("error");
      stop();
    }
        
    sampleLength = (int)sampler.getSample().getLength();
    sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    sampler.setToLoopStart();
    sampler.setKillOnEnd(false);
        
    rateGlide = new Glide(audioContext, 1, 50);
    directionGlide = new Glide(audioContext, 1, 50);
    sampler.setRate(rateGlide);
      
    startGlide = new Glide(audioContext, 0, 50);
    sampler.setLoopStart(startGlide);
    endGlide = new Glide(audioContext, sampleLength, 50);
    sampler.setLoopEnd(endGlide);
    
    lpFreqGlide = new Glide(audioContext, 11025, 50);
    lpRezGlide = new Glide(audioContext, .4, 50);
    filter = new LPRezFilter(audioContext, 2 /*channels*/, lpFreqGlide, lpRezGlide);
    
    
    combFeedbackGlide = new Glide(audioContext, 0.0, 50);
    combGain = new Gain(audioContext, 1, combFeedbackGlide);
    
    combDelayIn = new TapIn(audioContext, 100);
    combTimeGlide = new Glide(audioContext, 40, 50);
    combDelayOut = new TapOut(audioContext, combDelayIn, combTimeGlide);
    
    
    //Glide combTimeGlide, combFeedbackGlide;
  //Glide delayTimeGlide, delayFeedbackGlide;
    //gainGlide = new Glide(audioContext, 0.6, 50);
    //gain = new Gain(audioContext, 2, gainGlide);
    
    
    filter.addInput(sampler);   
    
    combDelayIn.addInput(filter);
    combGain.addInput(combDelayOut);
    combDelayIn.addInput(combGain);
    //gain.addInput(filter);
    audioContext.out.addInput(filter);
    audioContext.out.addInput(combGain);
    
    audioContext.start();
  }
  
  
  void setPlayForward() {
    playDirection = 1;
  }
  
  
  void setPlayReverse() {
    playDirection = -1;
  }
  
  
  void setRate(float rate) {
    rateGlide.setValue(rate * playDirection);
  }
  
  
  void setLoopStart(float loopStart) {
    startGlide.setValue(sampleLength * loopStart); 
  }
  
  void setLoopLength(float loopLength) {
    float loopEnd = startGlide.getValue() + loopLength * sampleLength;
    if (loopEnd > sampleLength) {
      loopEnd = sampleLength - 1;
    }
    endGlide.setValue(loopEnd); 
  }
  
  void setFilterFreq(float freq) {
    lpFreqGlide.setValue(freq); 
  }
  
  void setFilterRez(float rez) {
    lpRezGlide.setValue(rez); 
  }
  
  void setCombTime(float time) {
    combTimeGlide.setValue(time); 
  }
  
  void setFeedback(float feedback) {
    combFeedbackGlide.setValue(feedback); 
  }
  
}