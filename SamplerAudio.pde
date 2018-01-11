public class SamplerAudio {
  
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

  
  SamplerAudio() {
    
    audioContext = new AudioContext();
    
    selectInput("load a file", "loadfile", dataFile("data"), this);
  }
  
  
  void loadSample(String fileName) {
    sampler = new SamplePlayer(audioContext, SampleManager.sample(fileName));
    
        
    sampleLength = (int)sampler.getSample().getLength();
    sampler.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    sampler.setToLoopStart();
    sampler.setKillOnEnd(false);
        
    rateGlide = new Glide(audioContext, 1, GLIDE_TIME);
    directionGlide = new Glide(audioContext, 1, DIRECTION_GLIDE_TIME);
    sampler.setRate(new Mult(audioContext, rateGlide, directionGlide));
      
    startGlide = new Glide(audioContext, 0, GLIDE_TIME);
    sampler.setLoopStart(startGlide);
    endGlide = new Glide(audioContext, sampleLength, GLIDE_TIME);
    sampler.setLoopEnd(endGlide);
    
    lpFreqGlide = new Glide(audioContext, 11025, GLIDE_TIME);
    lpRezGlide = new Glide(audioContext, .4, GLIDE_TIME);
    filter = new LPRezFilter(audioContext, 2 /*channels*/, lpFreqGlide, lpRezGlide);
    
    
    combFeedbackGlide = new Glide(audioContext, 0.0, GLIDE_TIME);
    combGain = new Gain(audioContext, 1, combFeedbackGlide);
    
    combDelayIn = new TapIn(audioContext, 100);
    combTimeGlide = new Glide(audioContext, 40, GLIDE_TIME);
    combDelayOut = new TapOut(audioContext, combDelayIn, combTimeGlide);
    
    delayFeedbackGlide = new Glide(audioContext, 0.0, GLIDE_TIME);
    delayGain = new Gain(audioContext, 1, delayFeedbackGlide);
    
    delayIn = new TapIn(audioContext, 2000);
    delayTimeGlide = new Glide(audioContext, 1000, GLIDE_TIME);
    delayOut = new TapOut(audioContext, delayIn, delayTimeGlide);
    
   
    //gainGlide = new Glide(audioContext, 0.6, 50);
    //gain = new Gain(audioContext, 2, gainGlide);
    
    
    filter.addInput(sampler);   
    
    combDelayIn.addInput(filter);
    combGain.addInput(combDelayOut);
    combDelayIn.addInput(combGain);
    
    
    delayIn.addInput(combGain);
    delayIn.addInput(filter);
    delayGain.addInput(delayOut);
    delayIn.addInput(delayGain);
    
    //gain.addInput(filter);
    audioContext.out.addInput(filter);
    audioContext.out.addInput(combGain);
    audioContext.out.addInput(delayGain);
    
    audioContext.start();
  }
  
  
  void setPlayForward() {
    directionGlide.setValue(1);
  }
  
  
  void setPlayReverse() {
    directionGlide.setValue(-1);
  }

  
  public void loadfile(File selection) {
    if (selection == null) {}
    else {
     loadSample(selection.getAbsolutePath());
   }
  }

}